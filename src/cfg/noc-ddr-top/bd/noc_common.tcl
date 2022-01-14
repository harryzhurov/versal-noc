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

set cips_name       versal_cips_mamont

puts "\n======== Create block design \"$bd_name\" ========"

create_bd_design "${bd_name}"
update_compile_order -fileset sources_1
open_bd_design ${bd_path}

#-------------------------------------------------------------------------------
#
#   BD Configuration Section
#

# Create interface ports
set CH0_DDR4_0_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 CH0_DDR4_0_0 ]

set ref_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 ref_clk ]
set_property -dict [ list \
 CONFIG.FREQ_HZ {200000000} \
 ] $ref_clk

set sys_clk0_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys_clk0_0 ]
set_property -dict [ list \
 CONFIG.FREQ_HZ {200000000} \
 ] $sys_clk0_0


# Create ports
set nttw_out_0 [ create_bd_port -dir O -from 1 -to 0 nttw_out_0 ]
set sw4 [ create_bd_port -dir I -type ce sw4 ]
set_property -dict [ list \
 CONFIG.POLARITY {ACTIVE_HIGH} \
] $sw4

# Create instance: axi_noc_0, and set properties
set axi_noc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc:1.0 axi_noc_0 ]
set_property -dict [ list \
 CONFIG.CONTROLLERTYPE {DDR4_SDRAM} \
 CONFIG.LOGO_FILE {data/noc_mc.png} \
 CONFIG.MC0_CONFIG_NUM {config17} \
 CONFIG.MC1_CONFIG_NUM {config17} \
 CONFIG.MC2_CONFIG_NUM {config17} \
 CONFIG.MC3_CONFIG_NUM {config17} \
 CONFIG.MC_CASLATENCY {22} \
 CONFIG.MC_CONFIG_NUM {config17} \
 CONFIG.MC_DATAWIDTH {64} \
 CONFIG.MC_DDR4_2T {Disable} \
 CONFIG.MC_DM_WIDTH {8} \
 CONFIG.MC_DQS_WIDTH {8} \
 CONFIG.MC_DQ_WIDTH {64} \
 CONFIG.MC_ECC {false} \
 CONFIG.MC_EN_ECC_SCRUBBING {false} \
 CONFIG.MC_EN_INTR_RESP {TRUE} \
 CONFIG.MC_F1_LPDDR4_MR1 {0x0000} \
 CONFIG.MC_F1_LPDDR4_MR2 {0x0000} \
 CONFIG.MC_F1_LPDDR4_MR3 {0x0000} \
 CONFIG.MC_F1_LPDDR4_MR13 {0x0000} \
 CONFIG.MC_F1_TRCD {13750} \
 CONFIG.MC_F1_TRCDMIN {13750} \
 CONFIG.MC_INIT_MEM_USING_ECC_SCRUB {false} \
 CONFIG.MC_INPUTCLK0_PERIOD {5000} \
 CONFIG.MC_INPUT_FREQUENCY0 {200.000} \
 CONFIG.MC_MEMORY_DEVICETYPE {UDIMMs} \
 CONFIG.MC_MEMORY_SPEEDGRADE {DDR4-3200AA(22-22-22)} \
 CONFIG.MC_TRC {45750} \
 CONFIG.MC_TRCD {13750} \
 CONFIG.MC_TRP {13750} \
 CONFIG.MC_TRPMIN {13750} \
 CONFIG.NUM_CLKS {1} \
 CONFIG.NUM_MC {1} \
 CONFIG.NUM_MCP {1} \
 CONFIG.NUM_MI {0} \
] $axi_noc_0

set_property -dict [ list \
 CONFIG.DATA_WIDTH {512} \
 CONFIG.CONNECTIONS {MC_0 { read_bw {12500} write_bw {12500} read_avg_burst {4} write_avg_burst {4}} } \
 CONFIG.CATEGORY {pl} \
] [get_bd_intf_pins /axi_noc_0/S00_AXI]

set_property -dict [ list \
 CONFIG.ASSOCIATED_BUSIF {S00_AXI} \
] [get_bd_pins /axi_noc_0/aclk0]

# Create instance: axi_nttw_m_0, and set properties
set block_name axi_nttw_m
set block_cell_name axi_nttw_m_0
if { [catch {set axi_nttw_m_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
   return 1
 } elseif { $axi_nttw_m_0 eq "" } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
   return 1
 }

# Create instance: c_shift_ram_0, and set properties
set c_shift_ram_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_shift_ram:12.0 c_shift_ram_0 ]
set_property -dict [ list \
 CONFIG.AsyncInitVal {0} \
 CONFIG.CE {true} \
 CONFIG.DefaultData {0} \
 CONFIG.Depth {1} \
 CONFIG.SyncInitVal {0} \
 CONFIG.Width {1} \
] $c_shift_ram_0

# Create instance: clk_wizard_0, and set properties
set clk_wizard_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wizard:1.0 clk_wizard_0 ]
set_property -dict [ list \
 CONFIG.CLKFBOUT_MULT {15.000000} \
 CONFIG.CLKOUT1_DIVIDE {12.000000} \
 CONFIG.CLKOUT_DRIVES {BUFG,BUFG,BUFG,BUFG,BUFG,BUFG,BUFG} \
 CONFIG.CLKOUT_DYN_PS {None,None,None,None,None,None,None} \
 CONFIG.CLKOUT_GROUPING {Auto,Auto,Auto,Auto,Auto,Auto,Auto} \
 CONFIG.CLKOUT_MATCHED_ROUTING {false,false,false,false,false,false,false} \
 CONFIG.CLKOUT_PORT {clk_out1,clk_out2,clk_out3,clk_out4,clk_out5,clk_out6,clk_out7} \
 CONFIG.CLKOUT_REQUESTED_DUTY_CYCLE {50.000,50.000,50.000,50.000,50.000,50.000,50.000} \
 CONFIG.CLKOUT_REQUESTED_OUT_FREQUENCY {250.000,100.000,100.000,100.000,100.000,100.000,100.000} \
 CONFIG.CLKOUT_REQUESTED_PHASE {0.000,0.000,0.000,0.000,0.000,0.000,0.000} \
 CONFIG.CLKOUT_USED {true,false,false,false,false,false,false} \
 CONFIG.PRIM_IN_FREQ {200} \
 CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
 CONFIG.USE_LOCKED {true} \
] $clk_wizard_0

# Create instance: versal_cips_mamont, and set properties
set versal_cips_mamont [ create_bd_cell -type ip -vlnv xilinx.com:ip:versal_cips:3.1 versal_cips_mamont ]
set_property -dict [ list \
 CONFIG.BOOT_MODE {Custom} \
 CONFIG.DDR_MEMORY_MODE {Custom} \
 CONFIG.DESIGN_MODE {1} \
 CONFIG.PS_PMC_CONFIG {\
   PS_USE_PMCPL_CLK0 {0}\
   PS_USE_PMCPL_CLK1 {0}\
   PS_USE_PMCPL_CLK2 {0}\
   PS_USE_PMCPL_CLK3 {0}\
   PS_NUM_FABRIC_RESETS {0}\
   PMC_REF_CLK_FREQMHZ {33.33333333}\
   SMON_ALARMS {Set_Alarms_On}\
   SMON_ENABLE_TEMP_AVERAGING {0}\
   SMON_TEMP_AVERAGING_SAMPLES {0}\
 } \
 CONFIG.PS_PMC_CONFIG_APPLIED {1} \
] $versal_cips_mamont

# Create instance: xlconstant_0, and set properties
set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

# Create interface connections
connect_bd_intf_net -intf_net CLK_IN1_D_0_1 [get_bd_intf_ports ref_clk] [get_bd_intf_pins clk_wizard_0/CLK_IN1_D]
connect_bd_intf_net -intf_net axi_noc_0_CH0_DDR4_0 [get_bd_intf_ports CH0_DDR4_0_0] [get_bd_intf_pins axi_noc_0/CH0_DDR4_0]
connect_bd_intf_net -intf_net axi_nttw_m_0_interface_aximm [get_bd_intf_pins axi_noc_0/S00_AXI] [get_bd_intf_pins axi_nttw_m_0/interface_aximm]
connect_bd_intf_net -intf_net sys_clk0_0_1 [get_bd_intf_ports sys_clk0_0] [get_bd_intf_pins axi_noc_0/sys_clk0]

# Create port connections
connect_bd_net -net CE_0_1 [get_bd_ports sw4] [get_bd_pins c_shift_ram_0/CE]
connect_bd_net -net axi_nttw_m_0_nttw_out [get_bd_ports nttw_out_0] [get_bd_pins axi_nttw_m_0/nttw_out]
connect_bd_net -net c_shift_ram_0_Q [get_bd_pins axi_nttw_m_0/start] [get_bd_pins c_shift_ram_0/Q]
connect_bd_net -net clk_wizard_0_clk_out1 [get_bd_pins axi_noc_0/aclk0] [get_bd_pins axi_nttw_m_0/aclk] [get_bd_pins c_shift_ram_0/CLK] [get_bd_pins clk_wizard_0/clk_out1]
connect_bd_net -net clk_wizard_0_locked [get_bd_pins axi_nttw_m_0/aresetn] [get_bd_pins clk_wizard_0/locked]
connect_bd_net -net xlconstant_0_dout [get_bd_pins c_shift_ram_0/D] [get_bd_pins xlconstant_0/dout]

# Create address segments
assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_nttw_m_0/interface_aximm] [get_bd_addr_segs axi_noc_0/S00_AXI/C0_DDR_LOW0] -force

# Set debug
set_property HDL_ATTRIBUTE.DEBUG true [get_bd_intf_nets {axi_nttw_m_0_interface_aximm}]
apply_bd_automation -rule xilinx.com:bd_rule:debug -dict [list \
                                                          [get_bd_intf_nets axi_nttw_m_0_interface_aximm] {AXI_R_ADDRESS "Data and Trigger" AXI_R_DATA "Data and Trigger" AXI_W_ADDRESS "Data and Trigger" AXI_W_DATA "Data and Trigger" AXI_W_RESPONSE "Data and Trigger" CLK_SRC "/clk_wizard_0/clk_out1" AXIS_ILA "Auto" APC_EN "0" } \
                                                         ]


#-------------------------------------------------------------------------------
#
#   BD Final Tasks Section
#
validate_bd_design
make_wrapper -files [get_files ${bd_path}] -top
add_files -norecurse ${PROJECT_NAME}.gen/sources_1/bd/${bd_name}/hdl/${bd_name}_wrapper.v
set_property top ${bd_name}_wrapper [get_filesets sources_1]
update_compile_order -fileset sources_1

puts "\n-------- Export simulation for \"$bd_name\" --------"
set sim_top_name [get_property top [get_filesets sim_1]]  
set_property top ${bd_name}_wrapper [get_filesets sim_1]
generate_target simulation [get_files ${bd_path}] -force
export_simulation -of_objects [get_files ${bd_path}] -simulator questa -absolute_path -force -directory ${SIM_SCRIPT_DIR}
set_property top $sim_top_name [get_filesets sim_1]

puts "\n======== Finish block design \"$bd_name\" creating ========\n"

#--------------------------------------------------------------------------------
#
#   Suppress parasitic messages
#
#set_msg_config -id "Synth 8-3295" -regexp -string [list ".+<pattern-frame>.+"]     -suppress

set_msg_config -id "Synth 8-3295" -regexp -string [list ".+tying undriven pin inst:pmc_gpio_in.+"]     -suppress
set_msg_config -id "Synth 8-3295" -regexp -string [list ".+tying undriven pin inst:lpd_gpio_i.+"]      -suppress
set_msg_config -id "Synth 8-3295" -regexp -string [list ".+tying undriven pin inst:pmc_pl_gpi.+"]      -suppress
set_msg_config -id "Synth 8-3295" -regexp -string [list ".+tying undriven pin inst:pmc_i2c_scl_in.+"]  -suppress
set_msg_config -id "Synth 8-3295" -regexp -string [list ".+tying undriven pin inst:pmc_i2c_sda_in.+"]  -suppress
set_msg_config -id "Synth 8-3295" -regexp -string [list ".+tying undriven pin inst:uart[01]_.+"]       -suppress
set_msg_config -id "Synth 8-3295" -regexp -string [list ".+tying undriven pin inst:fmio_uart[10]_.+"]  -suppress

set_msg_config -id "Synth 8-7071" -regexp -string [list ".+port.+of module 'pspmc_v1_0_3_pspmc' is unconnected for instance 'inst'.+"]  -suppress
set_msg_config -id "Synth 8-7071" -regexp -string [list ".+port.+of module 'PS9' is unconnected for instance 'PS9_inst'.+"]             -suppress

set_msg_config -id "Synth 8-7023" -regexp -string [list ".+instance 'PS9_inst' of module 'PS9' has [0-9]+ connections declared, but only [0-9]+ given.+"]             -suppress
set_msg_config -id "Synth 8-7023" -regexp -string [list ".+instance 'inst' of module 'pspmc_v1_0_3_pspmc' has [0-9]+ connections declared, but only [0-9]+ given.+"]  -suppress
set_msg_config -id "Synth 8-7023" -regexp -string [list ".+instance 'pspmc_0' of module 'bd_.+_pspmc_0_0' has [0-9]+ connections declared, but only [0-9]+ given.+"]  -suppress

set_msg_config -id "Synth 8-4446" -regexp -string [list ".*all outputs are unconnected for this instance and logic may be removed .+build\/.+\/sources_1\/bd\/.+\/ip\/.+\/bd_0\/synth\/bd_.+\.v.*"]  -suppress
set_msg_config -id "Synth 8-693"  -regexp -string [list ".*zero replication count - replication ignored .+build\/.+\/sources_1\/bd\/.+\/ip\/.+\/bd_0\/ip\/ip_0\/hdl\/pspmc_.*"]  -suppress

#--------------------------------------------------------------------------------


