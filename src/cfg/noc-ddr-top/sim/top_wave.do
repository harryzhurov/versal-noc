onerror {resume}
radix define DDR4_CMD {
    "#" "CKE",
    "#" "|CS#",
    "#" "||ACT#",
    "#" "|||RAS#/A16",
    "#" "||||CAS#/A15",
    "#" "|||||WE#/A14",
    "#" "||||||A12/BC#",
    "#" "|||||||A10/AP",
    "8'b10100000" "MRS" -color "#A0A0A0",
    "8'b10100001" "MRS" -color "#A0A0A0",
    "8'b10100010" "MRS" -color "#A0A0A0",
    "8'b10100011" "MRS" -color "#A0A0A0",
    "8'b10100100" "REF" -color "#A0A0A0",
    "8'b10100101" "REF" -color "#A0A0A0",
    "8'b10100110" "REF" -color "#A0A0A0",
    "8'b10100111" "REF" -color "#A0A0A0",
    "8'b00100100" "SRE" -color "#A0A0A0",
    "8'b00100101" "SRE" -color "#A0A0A0",
    "8'b00100110" "SRE" -color "#A0A0A0",
    "8'b00100111" "SRE" -color "#A0A0A0",
    "8'b10111100" "SRX" -color "#A0A0A0",
    "8'b10111101" "SRX" -color "#A0A0A0",
    "8'b10111110" "SRX" -color "#A0A0A0",
    "8'b10111111" "SRX" -color "#A0A0A0",
    "8'b10101000" "PRE" -color "#A0A0A0",
    "8'b10101010" "PRE" -color "#A0A0A0",
    "8'b10101001" "PREA" -color "#A0A0A0",
    "8'b10101011" "PREA" -color "#A0A0A0",
    "8'b10101100" "RFU" -color "#A0A0A0",
    "8'b10101101" "RFU" -color "#A0A0A0",
    "8'b10101110" "RFU" -color "#A0A0A0",
    "8'b10101111" "RFU" -color "#A0A0A0",
    "8'b10000000" "ACT" -color "#ff0000",
    "8'b10110000" "WR" -color "#ffff00",
    "8'b10110010" "WR" -color "#ffff00",
    "8'b10110001" "WRA" -color "#ffff00",
    "8'b10110011" "WRA" -color "#ffff00",
    "8'b10110100" "RD" -color "#00ff00",
    "8'b10110110" "RD" -color "#00ff00",
    "8'b10110101" "RDA" -color "#00ff00",
    "8'b10110111" "RDA" -color "#00ff00",
    "8'b10111100" "NOP" -color "#A0A0A0",
    "8'b10111101" "NOP" -color "#A0A0A0",
    "8'b10111110" "NOP" -color "#A0A0A0",
    "8'b10111111" "NOP" -color "#00A0A0",
    "8'b11111111" "DES" -color "#808080",
    -default binary
    -defaultcolor #008080
}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider AW
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/awvalid
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/awready
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/awaddr
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/awlen
add wave -noupdate -divider W
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/wvalid
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/wready
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/wdata
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/wlast
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/wstrb
add wave -noupdate -divider B
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/bready
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/bresp
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/bvalid
add wave -noupdate -divider AR
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/arvalid
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/arready
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/araddr
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/arlen
add wave -noupdate -divider R
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/rvalid
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/rready
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/rdata
add wave -noupdate /top_ddrmc_bd_top_tb/top_inst/noc_slon_wrapper_i/noc_slon_i/axi_nttw_m_0/rlast
add wave -noupdate -divider {DDRMC Responder}
add wave -noupdate -divider {New Divider}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {990677 ps} 0} {{Cursor 2} {2018499 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 295
configure wave -valuecolwidth 182
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
WaveRestoreZoom {285635 ps} {3751363 ps}
