//-------------------------------------------------------------------------------
//
//     Project: Any
//
//     Purpose: NoC test project top-level file
//
//
//-------------------------------------------------------------------------------

`timescale 1ns/1ps

`include "cfg_params.svh"

//`define WIDTH 4

module automatic top_ddrmc
(
`ifdef DIFF_REFCLK
    input  logic              ref_clk_p,
    input  logic              ref_clk_n,
`else
    input  logic              ref_clk,
`endif

    input  logic              sw4,

    input  logic      [0:0]   sys_clk0_0_clk_n,
    input  logic      [0:0]   sys_clk0_0_clk_p,

    output logic     [ 0:0]   CH0_DDR4_0_0_act_n,
    output logic     [16:0]   CH0_DDR4_0_0_adr,
    output logic     [ 1:0]   CH0_DDR4_0_0_ba,
    output logic     [ 1:0]   CH0_DDR4_0_0_bg,
    output logic     [ 0:0]   CH0_DDR4_0_0_ck_c,
    output logic     [ 0:0]   CH0_DDR4_0_0_ck_t,
    output logic     [ 0:0]   CH0_DDR4_0_0_cke,
    output logic     [ 0:0]   CH0_DDR4_0_0_cs_n,
    inout  logic     [ 7:0]   CH0_DDR4_0_0_dm_n,
    inout  logic     [63:0]   CH0_DDR4_0_0_dq,
    inout  logic     [ 7:0]   CH0_DDR4_0_0_dqs_c,
    inout  logic     [ 7:0]   CH0_DDR4_0_0_dqs_t,
    output logic     [ 0:0]   CH0_DDR4_0_0_odt,
    output logic     [ 0:0]   CH0_DDR4_0_0_reset_n,


    output logic [`WIDTH-1:0] out
);

//------------------------------------------------------------------------------
//
//    Settings
//
localparam DATA_W  = `DATA_WIDTH;
localparam WSTRB_W = DATA_W/8;

`ifdef SIMULATOR
localparam int HB_HALF_PERIOD = `MAIN_CLK/2;
`else
localparam int HB_HALF_PERIOD = `MAIN_CLK*1e6/2;
`endif
localparam int HB_CNT_W       = $clog2(HB_HALF_PERIOD);

//------------------------------------------------------------------------------
//
//    Types
//
typedef logic [HB_CNT_W-1:0] hb_cnt_t;
//------------------------------------------------------------------------------
//
//    Objects
//
`ifdef DIFF_REFCLK
logic ref_clk;
`endif

logic          clk;
logic          mmcm_locked;

hb_cnt_t       hb_cnt = 0;
logic          start  = 0;

logic          aclk;
logic          aresetn;

logic [        0:0]   AXI_awvalid;
logic [        0:0]   AXI_awready;
logic [       63:0]   AXI_awaddr;
logic [        1:0]   AXI_awburst;
logic [        3:0]   AXI_awcache;
logic [        1:0]   AXI_awid;
logic [        7:0]   AXI_awlen;
logic [        0:0]   AXI_awlock;
logic [        2:0]   AXI_awprot;
logic [        3:0]   AXI_awqos;
logic [        3:0]   AXI_awregion;
logic [        2:0]   AXI_awsize;
logic [       17:0]   AXI_awuser;
              
logic [        0:0]   AXI_wvalid;
logic [        0:0]   AXI_wready;
logic [ DATA_W-1:0]   AXI_wdata;
logic [        0:0]   AXI_wlast;
logic [WSTRB_W-1:0]   AXI_wstrb;

logic [        1:0]   AXI_bid;
logic [        0:0]   AXI_bready;
logic [        1:0]   AXI_bresp;
logic [        0:0]   AXI_bvalid;
              
logic [       0:0]    AXI_arvalid;
logic [        0:0]   AXI_arready;
logic [       63:0]   AXI_araddr;
logic [        1:0]   AXI_arburst;
logic [        3:0]   AXI_arcache;
logic [        1:0]   AXI_arid;
logic [        7:0]   AXI_arlen;
logic [        0:0]   AXI_arlock;
logic [        2:0]   AXI_arprot;
logic [        3:0]   AXI_arqos;
logic [        3:0]   AXI_arregion;
logic [        2:0]   AXI_arsize;
logic [       17:0]   AXI_aruser;
              
logic [        0:0]   AXI_rvalid;
logic [        0:0]   AXI_rready;
logic [ DATA_W-1:0]   AXI_rdata;
logic [        1:0]   AXI_rid;
logic [        0:0]   AXI_rlast;
logic [        1:0]   AXI_rresp;

//------------------------------------------------------------------------------
//
//    ILA debug
//
`ifdef TOP_ENABLE_ILA

(* mark_debug = "true" *) logic [`WIDTH-1:0] dbg_out;
(* mark_debug = "true" *) logic              dbg_mmcm_locked;

assign dbg_out        = out;
assign dbg_pll_locked = mmcm_locked;

`endif // TOP_DEBUG_ENABLE


//------------------------------------------------------------------------------
//
//    Functions and tasks
//

//------------------------------------------------------------------------------
//
//    Logic
//
//always_ff @(posedge clk) begin
//    if(mmcm_locked) begin
//        out <= out + 1;
//    end
//end

assign aclk          = clk;
assign s_axi_aresetn = mmcm_locked;
assign aresetn       = mmcm_locked;

assign out[2]        = 0;
assign out[3]        = hb_cnt[HB_CNT_W-2];

always_ff @(posedge clk) begin
    hb_cnt <= hb_cnt + 1;
    if(hb_cnt == HB_HALF_PERIOD) begin
        hb_cnt <= 0;
        //start  <= 1;
    end
end

always_ff @(posedge clk) begin
    if(sw4) begin
        start <= 1;
    end
end

//------------------------------------------------------------------------------
//
//    Instances
//
`ifdef DIFF_REFCLK
IBUFDS diff_clk_200
(
    .I  ( ref_clk_p ),
    .IB ( ref_clk_n ),
    .O  ( ref_clk   )
);
`endif
//------------------------------------------------------------------------------
mmcm mmcm_inst
(
    .clk_in1  ( ref_clk    ),
    .clk_out1 ( clk        ),
    .locked   ( mmcm_locked )
);
//------------------------------------------------------------------------------
//cips_slon_wrapper cips_i();
//------------------------------------------------------------------------------
axi_nttw_m 
#(
    .DATA_W ( DATA_W )
)
axi_nttw
(
    .aclk     ( aclk         ),
    .aresetn  ( aresetn      ),
    .start    ( start        ),
    .out      ( out[1:0]     ),
    .awvalid  ( AXI_awvalid  ),
    .awready  ( AXI_awready  ),
    .awaddr   ( AXI_awaddr   ),
    .awburst  ( AXI_awburst  ),
    .awcache  ( AXI_awcache  ),
    .awid     ( AXI_awid     ),
    .awlen    ( AXI_awlen    ),
    .awlock   ( AXI_awlock   ),
    .awprot   ( AXI_awprot   ),
    .awqos    ( AXI_awqos    ),
    .awregion ( AXI_awregion ),
    .awsize   ( AXI_awsize   ),
    .awuser   ( AXI_awuser   ),
    .wvalid   ( AXI_wvalid   ),
    .wready   ( AXI_wready   ),
    .wdata    ( AXI_wdata    ),
    .wlast    ( AXI_wlast    ),
    .wstrb    ( AXI_wstrb    ),
    .bid      ( AXI_bid      ),
    .bready   ( AXI_bready   ),
    .bresp    ( AXI_bresp    ),
    .bvalid   ( AXI_bvalid   ),
    .arvalid  ( AXI_arvalid  ),
    .arready  ( AXI_arready  ),
    .araddr   ( AXI_araddr   ),
    .arburst  ( AXI_arburst  ),
    .arcache  ( AXI_arcache  ),
    .arid     ( AXI_arid     ),
    .arlen    ( AXI_arlen    ),
    .arlock   ( AXI_arlock   ),
    .arprot   ( AXI_arprot   ),
    .arqos    ( AXI_arqos    ),
    .arregion ( AXI_arregion ),
    .arsize   ( AXI_arsize   ),
    .aruser   ( AXI_aruser   ),
    .rvalid   ( AXI_rvalid   ),
    .rready   ( AXI_rready   ),
    .rdata    ( AXI_rdata    ),
    .rid      ( AXI_rid      ),
    .rlast    ( AXI_rlast    ),
    .rresp    ( AXI_rresp    )
);
//------------------------------------------------------------------------------
noc_slon_wrapper 
noc_slon
(
    .clk                  ( aclk         ),
    //.s_axi_aresetn        ( aresetn      ),
    .S00_AXI_awvalid      ( AXI_awvalid  ),
    .S00_AXI_awready      ( AXI_awready  ),
    .S00_AXI_awaddr       ( AXI_awaddr   ),
    .S00_AXI_awburst      ( AXI_awburst  ),
    .S00_AXI_awcache      ( AXI_awcache  ),
    //.S00_AXI_awid         ( AXI_awid     ),
    .S00_AXI_awlen        ( AXI_awlen    ),
    .S00_AXI_awlock       ( AXI_awlock   ),
    .S00_AXI_awprot       ( AXI_awprot   ),
    .S00_AXI_awqos        ( AXI_awqos    ),
    .S00_AXI_awregion     ( AXI_awregion ),
    .S00_AXI_awsize       ( AXI_awsize   ),
    //.S00_AXI_awuser       ( AXI_awuser   ),
    .S00_AXI_wvalid       ( AXI_wvalid   ),
    .S00_AXI_wready       ( AXI_wready   ),
    .S00_AXI_wdata        ( AXI_wdata    ),
    .S00_AXI_wlast        ( AXI_wlast    ),
    .S00_AXI_wstrb        ( AXI_wstrb    ),
    //.S00_AXI_bid          ( AXI_bid      ),
    .S00_AXI_bready       ( AXI_bready   ),
    .S00_AXI_bresp        ( AXI_bresp    ),
    .S00_AXI_bvalid       ( AXI_bvalid   ),
    .S00_AXI_arvalid      ( AXI_arvalid  ),
    .S00_AXI_arready      ( AXI_arready  ),
    .S00_AXI_araddr       ( AXI_araddr   ),
    .S00_AXI_arburst      ( AXI_arburst  ),
    .S00_AXI_arcache      ( AXI_arcache  ),
    //.S00_AXI_arid         ( AXI_arid     ),
    .S00_AXI_arlen        ( AXI_arlen    ),
    .S00_AXI_arlock       ( AXI_arlock   ),
    .S00_AXI_arprot       ( AXI_arprot   ),
    .S00_AXI_arqos        ( AXI_arqos    ),
    .S00_AXI_arregion     ( AXI_arregion ),
    .S00_AXI_arsize       ( AXI_arsize   ),
    //.S00_AXI_aruser       ( AXI_aruser   ),
    .S00_AXI_rvalid       ( AXI_rvalid   ),
    .S00_AXI_rready       ( AXI_rready   ),
    .S00_AXI_rdata        ( AXI_rdata    ),
    //.S00_AXI_rid          ( AXI_rid      ),
    .S00_AXI_rlast        ( AXI_rlast    ),
    .S00_AXI_rresp        ( AXI_rresp    ),
    
    .sys_clk0_0_clk_n     ( sys_clk0_0_clk_n     ),
    .sys_clk0_0_clk_p     ( sys_clk0_0_clk_p     ),
    
    .CH0_DDR4_0_0_act_n   ( CH0_DDR4_0_0_act_n   ),
    .CH0_DDR4_0_0_adr     ( CH0_DDR4_0_0_adr     ),
    .CH0_DDR4_0_0_ba      ( CH0_DDR4_0_0_ba      ),
    .CH0_DDR4_0_0_bg      ( CH0_DDR4_0_0_bg      ),
    .CH0_DDR4_0_0_ck_c    ( CH0_DDR4_0_0_ck_c    ),
    .CH0_DDR4_0_0_ck_t    ( CH0_DDR4_0_0_ck_t    ),
    .CH0_DDR4_0_0_cke     ( CH0_DDR4_0_0_cke     ),
    .CH0_DDR4_0_0_cs_n    ( CH0_DDR4_0_0_cs_n    ),
    .CH0_DDR4_0_0_dm_n    ( CH0_DDR4_0_0_dm_n    ),
    .CH0_DDR4_0_0_dq      ( CH0_DDR4_0_0_dq      ),
    .CH0_DDR4_0_0_dqs_c   ( CH0_DDR4_0_0_dqs_c   ),
    .CH0_DDR4_0_0_dqs_t   ( CH0_DDR4_0_0_dqs_t   ),
    .CH0_DDR4_0_0_odt     ( CH0_DDR4_0_0_odt     ),
    .CH0_DDR4_0_0_reset_n ( CH0_DDR4_0_0_reset_n )
    
);
//------------------------------------------------------------------------------

endmodule
//-------------------------------------------------------------------------------

