#--------------------------------------------------------------------------------
#
#     Project:     Any
#
#     Description: Xilinx Versal ACAP CIPS BD adding hook
#
#     Author:      Harry E. Zhurov
#
#--------------------------------------------------------------------------------

source $BUILD_SRC_DIR/cfg_params.tcl
source $BUILD_SRC_DIR/impl_env.tcl

set bd_name         cips_slon
set cips_name       versal_cips_mamont
set bd_path         "${PROJECT_NAME}.srcs/sources_1/bd/${bd_name}/${bd_name}.bd"

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

