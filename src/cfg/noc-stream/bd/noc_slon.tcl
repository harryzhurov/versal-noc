#--------------------------------------------------------------------------------
#
#     Project:     Any
#
#     Description: BD adding hook template
#
#     Author:      Harry E. Zhurov
#
#--------------------------------------------------------------------------------

#source $BUILD_SRC_DIR/<bd-relevant-params>.tcl
source $BUILD_SRC_DIR/cfg_params.tcl
source $BUILD_SRC_DIR/impl_env.tcl

set bd_name         noc_slon
set bd_path         "${PROJECT_NAME}.srcs/sources_1/bd/${bd_name}/${bd_name}.bd"

puts "\n======== Create block design \"$bd_name\" ========"

create_bd_design "${bd_name}"
update_compile_order -fileset sources_1
open_bd_design ${bd_path}

#-------------------------------------------------------------------------------
#
#   BD Configuration Section
#
# Create interface ports
set S00_AXI [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI ]
set_property -dict [ list \
 CONFIG.ADDR_WIDTH {64} \
 CONFIG.ARUSER_WIDTH {0} \
 CONFIG.AWUSER_WIDTH {0} \
 CONFIG.BUSER_WIDTH {0} \
 CONFIG.DATA_WIDTH {64} \
 CONFIG.FREQ_HZ {250000000} \
 CONFIG.HAS_BRESP {0} \
 CONFIG.HAS_BURST {0} \
 CONFIG.HAS_CACHE {0} \
 CONFIG.HAS_LOCK {0} \
 CONFIG.HAS_PROT {0} \
 CONFIG.HAS_QOS {0} \
 CONFIG.HAS_REGION {0} \
 CONFIG.HAS_RRESP {0} \
 CONFIG.HAS_WSTRB {0} \
 CONFIG.ID_WIDTH {0} \
 CONFIG.MAX_BURST_LENGTH {256} \
 CONFIG.NUM_READ_OUTSTANDING {16} \
 CONFIG.NUM_READ_THREADS {1} \
 CONFIG.NUM_WRITE_OUTSTANDING {16} \
 CONFIG.NUM_WRITE_THREADS {1} \
 CONFIG.PROTOCOL {AXI4} \
 CONFIG.READ_WRITE_MODE {READ_WRITE} \
 CONFIG.RUSER_BITS_PER_BYTE {1} \
 CONFIG.RUSER_WIDTH {0} \
 CONFIG.SUPPORTS_NARROW_BURST {1} \
 CONFIG.WUSER_BITS_PER_BYTE {1} \
 CONFIG.WUSER_WIDTH {0} \
 ] $S00_AXI


# Create ports
set clk [ create_bd_port -dir I -type clk -freq_hz 250000000 clk ]
set_property -dict [ list \
 CONFIG.ASSOCIATED_BUSIF {S00_AXI} \
] $clk
set s_axi_aresetn [ create_bd_port -dir I -type rst s_axi_aresetn ]

# Create instance: axi_bram_ctrl_0, and set properties
set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
set_property -dict [ list \
 CONFIG.DATA_WIDTH {64} \
 CONFIG.ECC_TYPE {0} \
 CONFIG.SINGLE_PORT_BRAM {1} \
] $axi_bram_ctrl_0

# Create instance: axi_noc_0, and set properties
set axi_noc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc:1.0 axi_noc_0 ]
set_property -dict [ list \
 CONFIG.NUM_CLKS {1} \
 CONFIG.NUM_MI {1} \
 CONFIG.NUM_SI {1} \
] $axi_noc_0

set_property -dict [ list \
 CONFIG.DATA_WIDTH {64} \
 CONFIG.APERTURES {{0x201_0000_0000 1G}} \
 CONFIG.CATEGORY {pl} \
] [get_bd_intf_pins /axi_noc_0/M00_AXI]

set_property -dict [ list \
 CONFIG.DATA_WIDTH {64} \
 CONFIG.CONNECTIONS {M00_AXI { read_bw {6000} write_bw {6000} read_avg_burst {4} write_avg_burst {4}} } \
 CONFIG.DEST_IDS {M00_AXI:0x40} \
 CONFIG.CATEGORY {pl} \
] [get_bd_intf_pins /axi_noc_0/S00_AXI]

set_property -dict [ list \
 CONFIG.ASSOCIATED_BUSIF {M00_AXI:S00_AXI} \
] [get_bd_pins /axi_noc_0/aclk0]

# Create instance: emb_mem_gen_0, and set properties
set emb_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:emb_mem_gen:1.0 emb_mem_gen_0 ]

set_property -dict [list CONFIG.MEMORY_OPTIMIZATION {no_mem_opt}] [get_bd_cells emb_mem_gen_0]

# Create interface connections
connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_ports S00_AXI] [get_bd_intf_pins axi_noc_0/S00_AXI]
connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins emb_mem_gen_0/BRAM_PORTA]
connect_bd_intf_net -intf_net axi_noc_0_M00_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins axi_noc_0/M00_AXI]

# Create port connections
connect_bd_net -net clk_1 [get_bd_ports clk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_noc_0/aclk0]
connect_bd_net -net s_axi_aresetn_1 [get_bd_ports s_axi_aresetn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn]

# Create address segments
assign_bd_address -offset 0x020100000000 -range 0x00004000 -target_address_space [get_bd_addr_spaces S00_AXI] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] -force

#-------------------------------------------------------------------------------
#
#   BD Final Tasks Section
#
validate_bd_design
make_wrapper -files [get_files ${bd_path}] -top
add_files -norecurse ${PROJECT_NAME}.gen/sources_1/bd/${bd_name}/hdl/${bd_name}_wrapper.v
update_compile_order -fileset sources_1

puts "\n-------- Export simulation for \"$bd_name\" --------"
set_property top ${bd_name}_wrapper [get_filesets sim_1]
generate_target simulation [get_files ${bd_path}] -force
export_simulation -of_objects [get_files ${bd_path}] -simulator questa -absolute_path -force -directory ${SIM_SCRIPT_DIR}

#--------------------------------------------------------------------------------
#
#   Suppress parasitic messages
#
#set_msg_config -id "Synth 8-3295" -regexp -string [list ".+<pattern-frame>.+"]     -suppress

#--------------------------------------------------------------------------------

