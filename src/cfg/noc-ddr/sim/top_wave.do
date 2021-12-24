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
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/awvalid
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/awready
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/awaddr
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/awlen
add wave -noupdate -divider W
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/wvalid
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/wready
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/wdata
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/wlast
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/wstrb
add wave -noupdate -divider B
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/bready
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/bresp
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/bvalid
add wave -noupdate -divider AR
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/arvalid
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/arready
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/araddr
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/arlen
add wave -noupdate -divider R
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/rvalid
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/rready
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/rdata
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/axi_nttw/axi_ntt/rlast
add wave -noupdate -divider {DDRMC Responder}
add wave -noupdate {/top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/inst/noc_ddr4_phy/inst/channel[0]/u_ddr_responder/ddr4_adr}
add wave -noupdate {/top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/inst/noc_ddr4_phy/inst/channel[0]/u_ddr_responder/ddr4_bg}
add wave -noupdate {/top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/inst/noc_ddr4_phy/inst/channel[0]/u_ddr_responder/ddr4_ba}
add wave -noupdate {/top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/inst/noc_ddr4_phy/inst/channel[0]/u_ddr_responder/ddr4_cke}
add wave -noupdate {/top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/inst/noc_ddr4_phy/inst/channel[0]/u_ddr_responder/ddr4_ck_t}
add wave -noupdate {/top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/inst/noc_ddr4_phy/inst/channel[0]/u_ddr_responder/ddr4_ck_c}
add wave -noupdate {/top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/inst/noc_ddr4_phy/inst/channel[0]/u_ddr_responder/ddr4_cs_n}
add wave -noupdate {/top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/inst/noc_ddr4_phy/inst/channel[0]/u_ddr_responder/ddr4_dm_dbi_n}
add wave -noupdate {/top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/inst/noc_ddr4_phy/inst/channel[0]/u_ddr_responder/ddr4_dq}
add wave -noupdate {/top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/inst/noc_ddr4_phy/inst/channel[0]/u_ddr_responder/ddr4_dqs_c}
add wave -noupdate {/top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/inst/noc_ddr4_phy/inst/channel[0]/u_ddr_responder/ddr4_dqs_t}
add wave -noupdate {/top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/inst/noc_ddr4_phy/inst/channel[0]/u_ddr_responder/ddr4_odt}
add wave -noupdate {/top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/inst/noc_ddr4_phy/inst/channel[0]/u_ddr_responder/ddr4_reset_n}
add wave -noupdate {/top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/inst/noc_ddr4_phy/inst/channel[0]/u_ddr_responder/ddr4_act_n}
add wave -noupdate -divider {New Divider}
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/noc2dmc_valid_in_0
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/noc2dmc_data_in_0
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/noc2dmc_credit_rdy_0
add wave -noupdate /top_ddrmc_tb/top_inst/top_ddrmc_i/noc_slon/noc_slon_i/axi_noc_0/inst/MC0_ddrc/dmc2noc_credit_rtn_0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2423211 ps} 0} {{Cursor 2} {4196926 ps} 0}
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
WaveRestoreZoom {0 ps} {7143424 ps}
