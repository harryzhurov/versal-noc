//------------------------------------------------------------------------------
//
//
//
//
//------------------------------------------------------------------------------

`timescale 1ns/1ps

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//
//   
//
module axi_nttw_m
#(
    parameter  DATA_W  = 64,
    localparam WSTRB_W = DATA_W/8
)
    
(
    input  wire                 aclk,
    input  wire                 aresetn,
    
    input  wire                 start,
    output wire [        1:0]   out,
                        
    output wire [        0:0]   awvalid,
    input  wire [        0:0]   awready,
    output wire [       63:0]   awaddr,
    output wire [        1:0]   awburst,
    output wire [        3:0]   awcache,
    output wire [        1:0]   awid,
    output wire [        7:0]   awlen,
    output wire [        0:0]   awlock,
    output wire [        2:0]   awprot,
    output wire [        3:0]   awqos,
    output wire [        3:0]   awregion,
    output wire [        2:0]   awsize,
    output wire [       17:0]   awuser,
                        
    output wire [        0:0]   wvalid,
    input  wire [        0:0]   wready,
    output wire [ DATA_W-1:0]   wdata,
    output wire [        0:0]   wlast,
    output wire [WSTRB_W-1:0]   wstrb,

    input  wire [        1:0]   bid,
    output wire [        0:0]   bready,
    input  wire [        1:0]   bresp,
    input  wire [        0:0]   bvalid,
                        
    output wire [       0:0]    arvalid,
    input  wire [        0:0]   arready,
    output wire [       63:0]   araddr,
    output wire [        1:0]   arburst,
    output wire [        3:0]   arcache,
    output wire [        1:0]   arid,
    output wire [        7:0]   arlen,
    output wire [        0:0]   arlock,
    output wire [        2:0]   arprot,
    output wire [        3:0]   arqos,
    output wire [        3:0]   arregion,
    output wire [        2:0]   arsize,
    output wire [       17:0]   aruser,
                        
    input  wire [        0:0]   rvalid,
    output wire [        0:0]   rready,
    input  wire [ DATA_W-1:0]   rdata,
    input  wire [        1:0]   rid,
    input  wire [        0:0]   rlast,
    input  wire [        1:0]   rresp
);

//------------------------------------------------------------------------------
//
//    Settings
//
    
//------------------------------------------------------------------------------
//
//    Types
//

//------------------------------------------------------------------------------
//
//    Objects
//

//------------------------------------------------------------------------------
//
//    Functions and tasks
//

//------------------------------------------------------------------------------
//
//    Logic
//

//------------------------------------------------------------------------------
//
//    Instances
//
axi_noc_transaction_tester_m 
#(
    .DATA_W ( DATA_W )
)
axi_ntt
(
    .clk     ( aclk     ),
    .rst     ( aresetn  ),
    .start   ( start    ),
    .out     ( out      ),
    .awvalid ( awvalid  ),
    .awready ( awready  ),
    .awaddr  ( awaddr   ),
    .awburst ( awburst  ),
    .awcache ( awcache  ),
    .awid    ( awid     ),
    .awlen   ( awlen    ),
    .awlock  ( awlock   ),
    .awprot  ( awprot   ),
    .awqos   ( awqos    ),
    .awregion( awregion ),
    .awsize  ( awsize   ),
    .awuser  ( awuser   ),
    .wvalid  ( wvalid   ),
    .wready  ( wready   ),
    .wdata   ( wdata    ),
    .wlast   ( wlast    ),
    .wstrb   ( wstrb    ),
    .bid     ( bid      ),
    .bready  ( bready   ),
    .bresp   ( bresp    ),
    .bvalid  ( bvalid   ),
    .arvalid ( arvalid  ),
    .arready ( arready  ),
    .araddr  ( araddr   ),
    .arburst ( arburst  ),
    .arcache ( arcache  ),
    .arid    ( arid     ),
    .arlen   ( arlen    ),
    .arlock  ( arlock   ),
    .arprot  ( arprot   ),
    .arqos   ( arqos    ),
    .arregion( arregion ),
    .arsize  ( arsize   ),
    .aruser  ( aruser   ),
    .rvalid  ( rvalid   ),
    .rready  ( rready   ),
    .rdata   ( rdata    ),
    .rid     ( rid      ),
    .rlast   ( rlast    ),
    .rresp   ( rresp    )
);

//------------------------------------------------------------------------------

endmodule : axi_nttw_m
//------------------------------------------------------------------------------

