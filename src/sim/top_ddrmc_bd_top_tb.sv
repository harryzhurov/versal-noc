//-------------------------------------------------------------------------------
//
//     Project: Any
//
//     Purpose: Default testbench file
//
//
//-------------------------------------------------------------------------------

`timescale 1ns/1ps

`include "cfg_params.svh"


module top_ddrmc_bd_top_tb;

localparam CLK_HALF_PERIOD = `CLK_HALF_PERIOD;
localparam WIDTH           = `WIDTH;
    
logic             start = 0;
logic [WIDTH-1:0] out; 

logic             sys_clk0_0_p = 0;
logic             sys_clk0_0_n = 1;


`ifdef DIFF_REFCLK
logic ref_clk_p = 0;
logic ref_clk_n = 1;
`else
logic ref_clk = 0;
`endif

    
`ifdef DIFF_REFCLK
always begin
    #CLK_HALF_PERIOD
    ref_clk_p = ~ref_clk_p;
    ref_clk_n = ~ref_clk_n;
end
`else
always begin
    #CLK_HALF_PERIOD
     ref_clk = ~ref_clk;
end
`endif

always begin
    #2.5ns
    sys_clk0_0_p = ~sys_clk0_0_p;
    sys_clk0_0_n = ~sys_clk0_0_n;
    
end


initial begin
    
    #1us
    start = 1;
    #20us
    $display("\n%c[1;32m ******************** SIMULATION RUN FINISHED SUCCESSFULLY ********************%c[0m", 27, 27);
    $stop(2);   
end 

noc_slon_wrapper_sim_wrapper top_inst
(
`ifdef DIFF_REFCLK
    .ref_clk_clk_p     ( ref_clk_p    ),
    .ref_clk_clk_n     ( ref_clk_n    ),
`else                                   
    .ref_clk           ( ref_clk      ),
`endif                 
                       
    .sw4               ( start        ),

    .sys_clk0_0_clk_p  ( sys_clk0_0_p ),
    .sys_clk0_0_clk_n  ( sys_clk0_0_n ),

    .nttw_out_0        ( out          )
);

endmodule
//-------------------------------------------------------------------------------
