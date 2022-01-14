#-------------------------------------------------------------------------------
#   project:       vivado-bullet
#   cfg:           xilinx_AC701
#
#   description:   slon5 start-up
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

#-------------------------------------------------------------------------------
#    Clocks
#-------------------------------------------------------------------------------

create_clock -period $REF_CLK_PERIOD [get_ports ref_clk_clk_p]

#set_property -dict {PACKAGE_PIN AE32 IOSTANDARD LVCMOS33} [get_ports ref_clk]
set_property PACKAGE_PIN AW27 [get_ports ref_clk_clk_p]
set_property PACKAGE_PIN AY27 [get_ports ref_clk_clk_n]
set_property IOSTANDARD LVDS15 [get_ports ref_clk_clk_p]
set_property IOSTANDARD LVDS15 [get_ports ref_clk_clk_n]

# EMCCLK
#set_property PACKAGE_PIN P16 [get_ports emcclk]
#set_property IOSTANDARD LVCMOS33 [get_ports emcclk]

#set_switching_activity -deassert_resets

#-------------------------------------------------------------------------------
#    dnum: mapped to user leds
#-------------------------------------------------------------------------------
set_property PACKAGE_PIN J33 [get_ports {nttw_out_0[1]}]
set_property PACKAGE_PIN H34 [get_ports {nttw_out_0[0]}]

set_property IOSTANDARD LVCMOS18 [get_ports {nttw_out_0[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {nttw_out_0[0]}]

set_property PACKAGE_PIN G37 [get_ports sw4]
set_property IOSTANDARD LVCMOS18 [get_ports sw4]


#set_property PACKAGE_PIN L35     [get_ports "GPIO_LED_3_LS"]           ; # Bank 306  VCC1V8       IO_L6P_HDGC_306.
#set_property PACKAGE_PIN K36     [get_ports "GPIO_LED_2_LS"]           ; # Bank 306  VCC1V8       IO_L6N_306......
#set_property PACKAGE_PIN J33     [get_ports "GPIO_LED_1_LS"]           ; # Bank 306  VCC1V8       IO_L7P_306......
#set_property PACKAGE_PIN H34     [get_ports "GPIO_LED_0_LS"]           ; # Bank 306  VCC1V8       IO_L7N_306......
#
#set_property IOSTANDARD LVCMOS18 [get_ports "GPIO_LED_3_LS"]
#set_property IOSTANDARD LVCMOS18 [get_ports "GPIO_LED_2_LS"]
#set_property IOSTANDARD LVCMOS18 [get_ports "GPIO_LED_1_LS"]
#set_property IOSTANDARD LVCMOS18 [get_ports "GPIO_LED_0_LS"]


#set_property PACKAGE_PIN AR47 [get_ports {CH0_DDR4_0_0_act_n[0]}]
#set_property PACKAGE_PIN AL46 [get_ports {CH0_DDR4_0_0_adr[0]}]
#set_property PACKAGE_PIN AL42 [get_ports {CH0_DDR4_0_0_adr[10]}]
#set_property PACKAGE_PIN AK38 [get_ports {CH0_DDR4_0_0_adr[11]}]
#set_property PACKAGE_PIN AN42 [get_ports {CH0_DDR4_0_0_adr[12]}]
#set_property PACKAGE_PIN AU45 [get_ports {CH0_DDR4_0_0_adr[13]}]
#set_property PACKAGE_PIN AK39 [get_ports {CH0_DDR4_0_0_adr[14]}]
#set_property PACKAGE_PIN AK40 [get_ports {CH0_DDR4_0_0_adr[15]}]
#set_property PACKAGE_PIN AL44 [get_ports {CH0_DDR4_0_0_adr[16]}]
#set_property PACKAGE_PIN AU44 [get_ports {CH0_DDR4_0_0_adr[1]}]
#set_property PACKAGE_PIN AR44 [get_ports {CH0_DDR4_0_0_adr[2]}]
#set_property PACKAGE_PIN AM41 [get_ports {CH0_DDR4_0_0_adr[3]}]
#set_property PACKAGE_PIN AL41 [get_ports {CH0_DDR4_0_0_adr[4]}]
#set_property PACKAGE_PIN AL37 [get_ports {CH0_DDR4_0_0_adr[5]}]
#set_property PACKAGE_PIN AM38 [get_ports {CH0_DDR4_0_0_adr[6]}]
#set_property PACKAGE_PIN AP43 [get_ports {CH0_DDR4_0_0_adr[7]}]
#set_property PACKAGE_PIN AN47 [get_ports {CH0_DDR4_0_0_adr[8]}]
#set_property PACKAGE_PIN AT44 [get_ports {CH0_DDR4_0_0_adr[9]}]
#set_property PACKAGE_PIN AN43 [get_ports {CH0_DDR4_0_0_ba[0]}]
#set_property PACKAGE_PIN AL47 [get_ports {CH0_DDR4_0_0_ba[1]}]
#set_property PACKAGE_PIN AP42 [get_ports {CH0_DDR4_0_0_bg[0]}]
#set_property PACKAGE_PIN AT47 [get_ports {CH0_DDR4_0_0_bg[1]}]
#set_property PACKAGE_PIN AR46 [get_ports {CH0_DDR4_0_0_ck_t[0]}]
#set_property PACKAGE_PIN AT46 [get_ports {CH0_DDR4_0_0_ck_c[0]}]
#set_property PACKAGE_PIN AR45 [get_ports {CH0_DDR4_0_0_cke[0]}]
#set_property PACKAGE_PIN AL43 [get_ports {CH0_DDR4_0_0_cs_n[0]}]
#set_property PACKAGE_PIN BC41 [get_ports {CH0_DDR4_0_0_dm_n[0]}]
#set_property PACKAGE_PIN BB43 [get_ports {CH0_DDR4_0_0_dm_n[1]}]
#set_property PACKAGE_PIN BB44 [get_ports {CH0_DDR4_0_0_dm_n[2]}]
#set_property PACKAGE_PIN AR42 [get_ports {CH0_DDR4_0_0_dm_n[3]}]
#set_property PACKAGE_PIN AH46 [get_ports {CH0_DDR4_0_0_dm_n[4]}]
#set_property PACKAGE_PIN AH45 [get_ports {CH0_DDR4_0_0_dm_n[5]}]
#set_property PACKAGE_PIN AG41 [get_ports {CH0_DDR4_0_0_dm_n[6]}]
#set_property PACKAGE_PIN AG39 [get_ports {CH0_DDR4_0_0_dm_n[7]}]
#set_property PACKAGE_PIN BE41 [get_ports {CH0_DDR4_0_0_dq[0]}]
#set_property PACKAGE_PIN AV42 [get_ports {CH0_DDR4_0_0_dq[10]}]
#set_property PACKAGE_PIN AV43 [get_ports {CH0_DDR4_0_0_dq[11]}]
#set_property PACKAGE_PIN BE42 [get_ports {CH0_DDR4_0_0_dq[12]}]
#set_property PACKAGE_PIN BD42 [get_ports {CH0_DDR4_0_0_dq[13]}]
#set_property PACKAGE_PIN AW43 [get_ports {CH0_DDR4_0_0_dq[14]}]
#set_property PACKAGE_PIN AW42 [get_ports {CH0_DDR4_0_0_dq[15]}]
#set_property PACKAGE_PIN BD45 [get_ports {CH0_DDR4_0_0_dq[16]}]
#set_property PACKAGE_PIN BC45 [get_ports {CH0_DDR4_0_0_dq[17]}]
#set_property PACKAGE_PIN AV45 [get_ports {CH0_DDR4_0_0_dq[18]}]
#set_property PACKAGE_PIN AW44 [get_ports {CH0_DDR4_0_0_dq[19]}]
#set_property PACKAGE_PIN BF41 [get_ports {CH0_DDR4_0_0_dq[1]}]
#set_property PACKAGE_PIN BD44 [get_ports {CH0_DDR4_0_0_dq[20]}]
#set_property PACKAGE_PIN BE45 [get_ports {CH0_DDR4_0_0_dq[21]}]
#set_property PACKAGE_PIN AW45 [get_ports {CH0_DDR4_0_0_dq[22]}]
#set_property PACKAGE_PIN AY44 [get_ports {CH0_DDR4_0_0_dq[23]}]
#set_property PACKAGE_PIN AM37 [get_ports {CH0_DDR4_0_0_dq[24]}]
#set_property PACKAGE_PIN AN38 [get_ports {CH0_DDR4_0_0_dq[25]}]
#set_property PACKAGE_PIN AR39 [get_ports {CH0_DDR4_0_0_dq[26]}]
#set_property PACKAGE_PIN AT39 [get_ports {CH0_DDR4_0_0_dq[27]}]
#set_property PACKAGE_PIN AT40 [get_ports {CH0_DDR4_0_0_dq[28]}]
#set_property PACKAGE_PIN AT41 [get_ports {CH0_DDR4_0_0_dq[29]}]
#set_property PACKAGE_PIN AV41 [get_ports {CH0_DDR4_0_0_dq[2]}]
#set_property PACKAGE_PIN AP39 [get_ports {CH0_DDR4_0_0_dq[30]}]
#set_property PACKAGE_PIN AN40 [get_ports {CH0_DDR4_0_0_dq[31]}]
#set_property PACKAGE_PIN AJ47 [get_ports {CH0_DDR4_0_0_dq[32]}]
#set_property PACKAGE_PIN AH47 [get_ports {CH0_DDR4_0_0_dq[33]}]
#set_property PACKAGE_PIN AE46 [get_ports {CH0_DDR4_0_0_dq[34]}]
#set_property PACKAGE_PIN AD45 [get_ports {CH0_DDR4_0_0_dq[35]}]
#set_property PACKAGE_PIN AK47 [get_ports {CH0_DDR4_0_0_dq[36]}]
#set_property PACKAGE_PIN AK46 [get_ports {CH0_DDR4_0_0_dq[37]}]
#set_property PACKAGE_PIN AE47 [get_ports {CH0_DDR4_0_0_dq[38]}]
#set_property PACKAGE_PIN AD47 [get_ports {CH0_DDR4_0_0_dq[39]}]
#set_property PACKAGE_PIN AU41 [get_ports {CH0_DDR4_0_0_dq[3]}]
#set_property PACKAGE_PIN AJ45 [get_ports {CH0_DDR4_0_0_dq[40]}]
#set_property PACKAGE_PIN AJ44 [get_ports {CH0_DDR4_0_0_dq[41]}]
#set_property PACKAGE_PIN AE44 [get_ports {CH0_DDR4_0_0_dq[42]}]
#set_property PACKAGE_PIN AD44 [get_ports {CH0_DDR4_0_0_dq[43]}]
#set_property PACKAGE_PIN AK45 [get_ports {CH0_DDR4_0_0_dq[44]}]
#set_property PACKAGE_PIN AK44 [get_ports {CH0_DDR4_0_0_dq[45]}]
#set_property PACKAGE_PIN AE45 [get_ports {CH0_DDR4_0_0_dq[46]}]
#set_property PACKAGE_PIN AF44 [get_ports {CH0_DDR4_0_0_dq[47]}]
#set_property PACKAGE_PIN AH41 [get_ports {CH0_DDR4_0_0_dq[48]}]
#set_property PACKAGE_PIN AH40 [get_ports {CH0_DDR4_0_0_dq[49]}]
#set_property PACKAGE_PIN BG41 [get_ports {CH0_DDR4_0_0_dq[4]}]
#set_property PACKAGE_PIN AD40 [get_ports {CH0_DDR4_0_0_dq[50]}]
#set_property PACKAGE_PIN AC39 [get_ports {CH0_DDR4_0_0_dq[51]}]
#set_property PACKAGE_PIN AH39 [get_ports {CH0_DDR4_0_0_dq[52]}]
#set_property PACKAGE_PIN AJ40 [get_ports {CH0_DDR4_0_0_dq[53]}]
#set_property PACKAGE_PIN AD41 [get_ports {CH0_DDR4_0_0_dq[54]}]
#set_property PACKAGE_PIN AE40 [get_ports {CH0_DDR4_0_0_dq[55]}]
#set_property PACKAGE_PIN AG37 [get_ports {CH0_DDR4_0_0_dq[56]}]
#set_property PACKAGE_PIN AH38 [get_ports {CH0_DDR4_0_0_dq[57]}]
#set_property PACKAGE_PIN AD37 [get_ports {CH0_DDR4_0_0_dq[58]}]
#set_property PACKAGE_PIN AC37 [get_ports {CH0_DDR4_0_0_dq[59]}]
#set_property PACKAGE_PIN BF42 [get_ports {CH0_DDR4_0_0_dq[5]}]
#set_property PACKAGE_PIN AH37 [get_ports {CH0_DDR4_0_0_dq[60]}]
#set_property PACKAGE_PIN AJ38 [get_ports {CH0_DDR4_0_0_dq[61]}]
#set_property PACKAGE_PIN AD39 [get_ports {CH0_DDR4_0_0_dq[62]}]
#set_property PACKAGE_PIN AD38 [get_ports {CH0_DDR4_0_0_dq[63]}]
#set_property PACKAGE_PIN AW41 [get_ports {CH0_DDR4_0_0_dq[6]}]
#set_property PACKAGE_PIN AW40 [get_ports {CH0_DDR4_0_0_dq[7]}]
#set_property PACKAGE_PIN BC42 [get_ports {CH0_DDR4_0_0_dq[8]}]
#set_property PACKAGE_PIN BC43 [get_ports {CH0_DDR4_0_0_dq[9]}]
#set_property PACKAGE_PIN AY41 [get_ports {CH0_DDR4_0_0_dqs_t[0]}]
#set_property PACKAGE_PIN BA41 [get_ports {CH0_DDR4_0_0_dqs_c[0]}]
#set_property PACKAGE_PIN AY42 [get_ports {CH0_DDR4_0_0_dqs_t[1]}]
#set_property PACKAGE_PIN BA43 [get_ports {CH0_DDR4_0_0_dqs_c[1]}]
#set_property PACKAGE_PIN AY45 [get_ports {CH0_DDR4_0_0_dqs_t[2]}]
#set_property PACKAGE_PIN BA44 [get_ports {CH0_DDR4_0_0_dqs_c[2]}]
#set_property PACKAGE_PIN AP40 [get_ports {CH0_DDR4_0_0_dqs_t[3]}]
#set_property PACKAGE_PIN AP41 [get_ports {CH0_DDR4_0_0_dqs_c[3]}]
#set_property PACKAGE_PIN AF47 [get_ports {CH0_DDR4_0_0_dqs_t[4]}]
#set_property PACKAGE_PIN AF46 [get_ports {CH0_DDR4_0_0_dqs_c[4]}]
#set_property PACKAGE_PIN AH43 [get_ports {CH0_DDR4_0_0_dqs_t[5]}]
#set_property PACKAGE_PIN AG44 [get_ports {CH0_DDR4_0_0_dqs_c[5]}]
#set_property PACKAGE_PIN AF39 [get_ports {CH0_DDR4_0_0_dqs_t[6]}]
#set_property PACKAGE_PIN AF40 [get_ports {CH0_DDR4_0_0_dqs_c[6]}]
#set_property PACKAGE_PIN AE38 [get_ports {CH0_DDR4_0_0_dqs_t[7]}]
#set_property PACKAGE_PIN AF37 [get_ports {CH0_DDR4_0_0_dqs_c[7]}]
#set_property PACKAGE_PIN AM39 [get_ports {CH0_DDR4_0_0_odt[0]}]
#set_property PACKAGE_PIN AD42 [get_ports {CH0_DDR4_0_0_reset_n[0]}]
#set_property PACKAGE_PIN AE42 [get_ports {sys_clk0_0_clk_p[0]}]
#set_property PACKAGE_PIN AF43 [get_ports {sys_clk0_0_clk_n[0]}]