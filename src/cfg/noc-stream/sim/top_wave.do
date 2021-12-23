onerror {resume}
radix define DOUT {
    "'b0001" "SLON" -color "#FF0040",
    "'b0101" "S100" -color "#00FF80",
    -default binary
    -defaultcolor #008080
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/noc_slon/noc_slon_i/clk
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/dcnt
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/mfsm
add wave -noupdate -divider AW
add wave -noupdate -color Cyan /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/awvalid
add wave -noupdate -color {Dark Orchid} /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/awready
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/awaddr
add wave -noupdate -radix unsigned /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/awlen
add wave -noupdate -divider W
add wave -noupdate -color Aquamarine /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/wvalid
add wave -noupdate -color {Blue Violet} /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/wready
add wave -noupdate -color Tan /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/wdata
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/wlast
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/axi_nttw/wstrb
add wave -noupdate -divider AR
add wave -noupdate -color Turquoise /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/arvalid
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/arready
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/araddr
add wave -noupdate -radix unsigned /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/arlen
add wave -noupdate -divider R
add wave -noupdate -color Turquoise /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/rvalid
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/rready
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/rdata
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/axi_nttw/axi_ntt/rlast
add wave -noupdate -divider {BRAM Side}
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/noc_slon/noc_slon_i/axi_bram_ctrl_0/s_axi_awaddr
add wave -noupdate -radix unsigned -radixshowbase 0 /top_noc_tb/top_inst/top_noc_i/noc_slon/noc_slon_i/axi_bram_ctrl_0/s_axi_awlen
add wave -noupdate -color Cyan -radix binary -radixshowbase 0 /top_noc_tb/top_inst/top_noc_i/noc_slon/noc_slon_i/axi_bram_ctrl_0/s_axi_awvalid
add wave -noupdate -color {Dark Orchid} /top_noc_tb/top_inst/top_noc_i/noc_slon/noc_slon_i/axi_bram_ctrl_0/s_axi_awready
add wave -noupdate -color Aquamarine /top_noc_tb/top_inst/top_noc_i/noc_slon/noc_slon_i/axi_bram_ctrl_0/s_axi_wvalid
add wave -noupdate -color {Blue Violet} /top_noc_tb/top_inst/top_noc_i/noc_slon/noc_slon_i/axi_bram_ctrl_0/s_axi_wready
add wave -noupdate -color Orange /top_noc_tb/top_inst/top_noc_i/noc_slon/noc_slon_i/axi_bram_ctrl_0/s_axi_wdata
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/noc_slon/noc_slon_i/axi_bram_ctrl_0/s_axi_wlast
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/noc_slon/noc_slon_i/axi_bram_ctrl_0/s_axi_wstrb
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/noc_slon/noc_slon_i/axi_noc_0_M00_AXI_AWADDR
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/noc_slon/S00_AXI_araddr
add wave -noupdate -radix unsigned -radixshowbase 0 /top_noc_tb/top_inst/top_noc_i/noc_slon/S00_AXI_arlen
add wave -noupdate -color Aquamarine /top_noc_tb/top_inst/top_noc_i/noc_slon/S00_AXI_arvalid
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/noc_slon/S00_AXI_arready
add wave -noupdate -color Cyan /top_noc_tb/top_inst/top_noc_i/noc_slon/S00_AXI_rvalid
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/noc_slon/S00_AXI_rready
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/noc_slon/S00_AXI_rdata
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/noc_slon/S00_AXI_rlast
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/noc_slon/S00_AXI_rresp
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/noc_slon/noc_slon_i/axi_bram_ctrl_0/bram_we_a
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/noc_slon/noc_slon_i/axi_bram_ctrl_0/bram_addr_a
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/noc_slon/noc_slon_i/axi_bram_ctrl_0/bram_wrdata_a
add wave -noupdate /top_noc_tb/top_inst/top_noc_i/noc_slon/noc_slon_i/axi_bram_ctrl_0/bram_rddata_a
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {602500 ps} 0} {{Cursor 2} {8543901 ps} 0 Gold Salmon} {{Cursor 3} {1167655 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 273
configure wave -valuecolwidth 147
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 3000
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {21737472 ps}
