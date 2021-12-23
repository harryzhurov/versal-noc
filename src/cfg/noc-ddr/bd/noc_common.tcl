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

create_bd_cell -type ip -vlnv xilinx.com:ip:versal_cips:3.1 ${cips_name}

set_property -dict [                                        \
    list CONFIG.PS_PMC_CONFIG "                             \
        PMC_REF_CLK_FREQMHZ          ${PMC_REF_CLK}         \
        PS_NUM_FABRIC_RESETS         0                      \
        PS_USE_PMCPL_CLK0            0                      \
        PS_USE_PMCPL_CLK1            0                      \
        PS_USE_PMCPL_CLK2            0                      \
        PS_USE_PMCPL_CLK3            0                      \
        SMON_ALARMS                  Set_Alarms_On          \
        SMON_ENABLE_TEMP_AVERAGING   0                      \
        SMON_TEMP_AVERAGING_SAMPLES  8                      \
    "                                                       \
    CONFIG.PS_PMC_CONFIG_APPLIED {1}                        \
]                                                           \
[get_bd_cells ${cips_name}]

apply_bd_automation -rule xilinx.com:bd_rule:cips -config { \
    board_preset  {No}                                      \
    boot_config   {Custom}                                  \
    configure_noc {Add new AXI NoC}                         \
    debug_config  {Custom}                                  \
    design_flow   {Full System}                             \
    mc_type       {None}                                    \
    num_mc        {1}                                       \
    pl_clocks     {None}                                    \
    pl_resets     {None}                                    \
}                                                           \
[get_bd_cells ${cips_name}]

# Create interface ports

set CH0_DDR4_0_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 CH0_DDR4_0_0 ]

set S00_AXI [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI ]
set_property -dict [ list \
 CONFIG.ADDR_WIDTH {64} \
 CONFIG.ARUSER_WIDTH {0} \
 CONFIG.AWUSER_WIDTH {0} \
 CONFIG.BUSER_WIDTH {0} \
 CONFIG.DATA_WIDTH {512} \
 CONFIG.FREQ_HZ {250000000} \
 CONFIG.HAS_BRESP {0} \
 CONFIG.HAS_BURST {0} \
 CONFIG.HAS_CACHE {0} \
 CONFIG.HAS_LOCK {0} \
 CONFIG.HAS_PROT {0} \
 CONFIG.HAS_QOS {0} \
 CONFIG.HAS_REGION {0} \
 CONFIG.HAS_RRESP {0} \
 CONFIG.HAS_WSTRB {1} \
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

set sys_clk0_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys_clk0_0 ]
set_property -dict [ list \
 CONFIG.FREQ_HZ {200000000} \
 ] $sys_clk0_0


# Create ports
set clk [ create_bd_port -dir I -type clk -freq_hz 250000000 clk ]
set_property -dict [ list \
 CONFIG.ASSOCIATED_BUSIF {S00_AXI} \
] $clk

# Create instance: axi_noc_0, and set properties
set axi_noc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc:1.0 axi_noc_0 ]
set_property -dict [ list \
    CONFIG.LOGO_FILE                   {data/noc_mc.png}       \
    CONFIG.CONTROLLERTYPE              {DDR4_SDRAM}            \
    CONFIG.MC_EN_INTR_RESP             {false}                  \
    CONFIG.NUM_CLKS                    {1}                     \
    CONFIG.NUM_MC                      {1}                     \
    CONFIG.NUM_MCP                     {1}                     \
    CONFIG.NUM_MI                      {0}                     \
    CONFIG.MC0_CONFIG_NUM              {config17}              \
    CONFIG.MC1_CONFIG_NUM              {config17}              \
    CONFIG.MC2_CONFIG_NUM              {config17}              \
    CONFIG.MC3_CONFIG_NUM              {config17}              \
    CONFIG.MC_INPUT_FREQUENCY0         {200.000}               \
    CONFIG.MC_INPUTCLK0_PERIOD         {5000}                  \
    CONFIG.MC_MEMORY_DEVICETYPE        {UDIMMs}                \
    CONFIG.MC_MEMORY_SPEEDGRADE        {DDR4-3200AA(22-22-22)} \
    CONFIG.MC_TRCD                     {13750}                 \
    CONFIG.MC_TRP                      {13750}                 \
    CONFIG.MC_DDR4_2T                  {Disable}               \
    CONFIG.MC_CASLATENCY               {22}                    \
    CONFIG.MC_TRC                      {45750}                 \
    CONFIG.MC_TRPMIN                   {13750}                 \
    CONFIG.MC_CONFIG_NUM               {config17}              \
    CONFIG.MC_F1_TRCD                  {13750}                 \
    CONFIG.MC_F1_TRCDMIN               {13750}                 \
    CONFIG.MC_F1_LPDDR4_MR1            {0x000}                 \
    CONFIG.MC_F1_LPDDR4_MR2            {0x000}                 \
    CONFIG.MC_F1_LPDDR4_MR3            {0x000}                 \
    CONFIG.MC_F1_LPDDR4_MR13           {0x000}                 \
    CONFIG.MC_DATAWIDTH                {64}                    \
    CONFIG.MC_ECC                      {false}                 \
    CONFIG.MC_DQ_WIDTH                 {64}                    \
    CONFIG.MC_DQS_WIDTH                {8}                     \
    CONFIG.MC_DM_WIDTH                 {8}                     \
    CONFIG.MC_EN_ECC_SCRUBBING         {false}                 \
    CONFIG.MC_INIT_MEM_USING_ECC_SCRUB {false}                 \
] $axi_noc_0

set_property -dict [ list \
 #CONFIG.DATA_WIDTH {64} \
 #CONFIG.CONNECTIONS {MC_0 { read_bw {1720} write_bw {1720} read_avg_burst {4} write_avg_burst {4}} } \
 CONFIG.CONNECTIONS {MC_0 { read_bw {12500} write_bw {12500} read_avg_burst {4} write_avg_burst {4}} } \
 CONFIG.CATEGORY {pl} \
] [get_bd_intf_pins /axi_noc_0/S00_AXI]

set_property -dict [ list \
 CONFIG.ASSOCIATED_BUSIF {S00_AXI} \
] [get_bd_pins /axi_noc_0/aclk0]

# Create interface connections
connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_ports S00_AXI] [get_bd_intf_pins axi_noc_0/S00_AXI]
connect_bd_intf_net -intf_net axi_noc_0_CH0_DDR4_0 [get_bd_intf_ports CH0_DDR4_0_0] [get_bd_intf_pins axi_noc_0/CH0_DDR4_0]
connect_bd_intf_net -intf_net sys_clk0_0_1 [get_bd_intf_ports sys_clk0_0] [get_bd_intf_pins axi_noc_0/sys_clk0]

# Create port connections
connect_bd_net -net clk_1 [get_bd_ports clk] [get_bd_pins axi_noc_0/aclk0]

# Create address segments
assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces noc_tg/Data] [get_bd_addr_segs axi_noc_0/S00_AXI/C0_DDR_LOW0] -force

#-------------------------------------------------------------------------------
#
#   BD Final Tasks Section
#
validate_bd_design
make_wrapper -files [get_files ${bd_path}] -top
add_files -norecurse ${PROJECT_NAME}.gen/sources_1/bd/${bd_name}/hdl/${bd_name}_wrapper.v
update_compile_order -fileset sources_1

puts "\n-------- Export simulation for \"$bd_name\" --------"
set sim_top_name [get_property top [get_filesets sim_1]]  
set_property top ${bd_name}_wrapper [get_filesets sim_1]
generate_target simulation [get_files ${bd_path}] -force
export_simulation -of_objects [get_files ${bd_path}] -simulator questa -absolute_path -force -directory ${SIM_SCRIPT_DIR}
set_property top $sim_top_name [get_filesets sim_1]


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


