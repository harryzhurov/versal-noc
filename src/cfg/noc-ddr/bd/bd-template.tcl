#--------------------------------------------------------------------------------
#
#     Project:     Any
#
#     Description: BD adding hook template
#
#     Author:      Harry E. Zhurov
#
#--------------------------------------------------------------------------------

source $BUILD_SRC_DIR/<bd-relevant-params>.tcl

set bd_name         <bd-name>
set bd_path         "${PROJECT_NAME}.srcs/sources_1/bd/${bd_name}/${bd_name}.bd"

puts "\n======== Create block design \"$bd_name\" ========"

create_bd_design "${bd_name}"
update_compile_order -fileset sources_1
open_bd_design ${bd_path}

#-------------------------------------------------------------------------------
#
#   BD Configuration Section
#

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

