
puts "\n------->>> Add net to debug probes <<<-------"

create_debug_core ila_core ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores ila_core]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores ila_core]
set_property C_ADV_TRIGGER false [get_debug_cores ila_core]
set_property C_DATA_DEPTH 1024 [get_debug_cores ila_core]
set_property C_EN_STRG_QUAL false [get_debug_cores ila_core]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores ila_core]
#set_property C_TRIGIN_EN false [get_debug_cores ila_core]
#set_property C_TRIGOUT_EN false [get_debug_cores ila_core]
set_property port_width 1 [get_debug_ports ila_core/clk]

connect_debug_port ila_core/clk [get_nets -hier -filter {NAME =~ *mmcm_inst/inst/clk_out1}]

#-------------------------------------------------------------------------------
#
#    Top module
#
if { $AXI_NTT_ENABLE_ILA } {
    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_mfsm*}]

    create_probe ila_core DATA
    
    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_awvalid}]
    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_awready}]
    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_awaddr[*]}]
    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_awlen[*]}]

    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_wvalid}]
    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_wready}]
    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_wdata[*]}]
    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_wlast}]
    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_wstrb[*]}]

    create_probe ila_core DATA

    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_arvalid}]
    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_arready}]
    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_araddr[*]}]
    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_arlen[*]}]

    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_rvalid}]
    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_rready}]
    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_rdata[*]}]
    net2probe ila_core [get_nets -hier -filter {NAME =~ *axi_ntt/dbg_rlast}]
}
puts "-----------------------------------------------\n"



