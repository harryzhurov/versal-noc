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

create_clock -period $REF_CLK_PERIOD [get_ports ref_clk_p]

#set_property -dict {PACKAGE_PIN AE32 IOSTANDARD LVCMOS33} [get_ports ref_clk]
set_property PACKAGE_PIN AE42 [get_ports ref_clk_p]
set_property PACKAGE_PIN AF43 [get_ports ref_clk_n]
set_property IOSTANDARD LVDS15 [get_ports ref_clk_p]
set_property IOSTANDARD LVDS15 [get_ports ref_clk_n]

# EMCCLK
#set_property PACKAGE_PIN P16 [get_ports emcclk]
#set_property IOSTANDARD LVCMOS33 [get_ports emcclk]

#set_switching_activity -deassert_resets

#-------------------------------------------------------------------------------
#    dnum: mapped to user leds
#-------------------------------------------------------------------------------
set_property PACKAGE_PIN L35     [get_ports {out[3]}]
set_property PACKAGE_PIN K36     [get_ports {out[2]}]
set_property PACKAGE_PIN J33     [get_ports {out[1]}]
set_property PACKAGE_PIN H34     [get_ports {out[0]}]

set_property IOSTANDARD LVCMOS18 [get_ports {out}]

#set_property PACKAGE_PIN L35     [get_ports "GPIO_LED_3_LS"]           ; # Bank 306  VCC1V8       IO_L6P_HDGC_306.
#set_property PACKAGE_PIN K36     [get_ports "GPIO_LED_2_LS"]           ; # Bank 306  VCC1V8       IO_L6N_306......
#set_property PACKAGE_PIN J33     [get_ports "GPIO_LED_1_LS"]           ; # Bank 306  VCC1V8       IO_L7P_306......
#set_property PACKAGE_PIN H34     [get_ports "GPIO_LED_0_LS"]           ; # Bank 306  VCC1V8       IO_L7N_306......
#
#set_property IOSTANDARD LVCMOS18 [get_ports "GPIO_LED_3_LS"]
#set_property IOSTANDARD LVCMOS18 [get_ports "GPIO_LED_2_LS"]
#set_property IOSTANDARD LVCMOS18 [get_ports "GPIO_LED_1_LS"]
#set_property IOSTANDARD LVCMOS18 [get_ports "GPIO_LED_0_LS"]

