//------------------------------------------------------------------------------
//
//
//
//
//------------------------------------------------------------------------------

`timescale 1ns/1ps

`include "common.svh"
`include "cfg_params.svh"

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//
//
//
module automatic axi_noc_transaction_tester_m
#(
    parameter  DATA_W  = 64,
    localparam WSTRB_W = DATA_W/8
)
(
    input  logic               clk,
    input  logic               rst,
    
    input  logic               start,
    output logic [        1:0] out = 0,

    output logic [        0:0] awvalid,
    input  logic [        0:0] awready,
(* mark_debug = "true" *)    output logic [       63:0] awaddr,
    output logic [        1:0] awburst,
    output logic [        3:0] awcache,
    output logic [        1:0] awid,
(* mark_debug = "true" *)    output logic [        7:0] awlen,
    output logic [        0:0] awlock,
    output logic [        2:0] awprot,
    output logic [        3:0] awqos,
    output logic [        3:0] awregion,
    output logic [        2:0] awsize,
    output logic [       17:0] awuser,

(* mark_debug = "true" *)    output logic [        0:0] wvalid,
    input  logic [        0:0] wready,
(* mark_debug = "true" *)    output logic [ DATA_W-1:0] wdata,
    output logic [        0:0] wlast,
(* mark_debug = "true" *)    output logic [WSTRB_W-1:0] wstrb,

    input  logic [        1:0] bid,
    output logic [        0:0] bready,
    input  logic [        1:0] bresp,
    input  logic [        0:0] bvalid,

    output logic [        0:0] arvalid,
    input  logic [        0:0] arready,
(* mark_debug = "true" *)    output logic [       63:0] araddr,
    output logic [        1:0] arburst,
    output logic [        3:0] arcache,
    output logic [        1:0] arid,
(* mark_debug = "true" *)    output logic [        7:0] arlen,
    output logic [        0:0] arlock,
    output logic [        2:0] arprot,
    output logic [        3:0] arqos,
    output logic [        3:0] arregion,
    output logic [        2:0] arsize,
    output logic [       17:0] aruser,

    input  logic [        0:0] rvalid,
    output logic [        0:0] rready,
    input  logic [ DATA_W-1:0] rdata,
    input  logic [        1:0] rid,
    input  logic [        0:0] rlast,
    input  logic [        1:0] rresp
);

//------------------------------------------------------------------------------
//
//    Settings
//
localparam MAX_COUNT   = 256;
localparam INIT_COUNT  = 0;
localparam COUNT       = 64;
localparam MAX_COUNT_W = $clog2(MAX_COUNT);

//localparam BASE_ADDR = 64'h0000_0201_0000_0010;
//localparam BASE_ADDR = 64'h0000_0500_0000_0000;
localparam BASE_ADDR = `BASE_ADDRESS;

//------------------------------------------------------------------------------
//
//    Types
//

typedef enum logic [1:0]
{
    AXBURST_FIXED    = 2'b00,
    AXBURST_INCR     = 2'b01,
    AXBURST_WRAP     = 2'b10,
    AXBURST_RESERVED = 2'b11
}
axburst_t;

typedef enum logic [3:0]
{
    AXCACHE_DEV_NONBUF           = 4'b0000,
    AXCACHE_DEV_BUF              = 4'b0001,
    AXCACHE_NORM_NONCACHE_NONBUF = 4'b0010,
    AXCACHE_NORM_NONCACHE_BUF    = 4'b0011
}
axcache_t;

typedef logic [MAX_COUNT_W-1:0] data_counter_t;

typedef enum logic [1:0]
{
    mfsmWRITE_INIT,
    mfsmWRITE_DATA,
    mfsmREAD_INIT,
    mfsmREAD_DATA
}
mode_fsm_t;

//------------------------------------------------------------------------------
//
//    Objects
//
mode_fsm_t     mfsm        = mfsmWRITE_INIT;
mode_fsm_t     mfsm_next;
data_counter_t dcnt        = 0;
data_counter_t data        = 0;
data_counter_t count       = INIT_COUNT;

//logic start = 0;
//
//initial begin
//
//    #3us
//    @(posedge clk) ;
//    start = 1;
//
//end

`ifdef AXI_NTT_ENABLE_ILA

(* mark_debug = "true" *) mode_fsm_t          dbg_mfsm;

(* mark_debug = "true" *) logic               dbg_awvalid;
(* mark_debug = "true" *) logic               dbg_awready;
(* mark_debug = "true" *) logic [       63:0] dbg_awaddr;
(* mark_debug = "true" *) logic [        7:0] dbg_awlen;
                       
(* mark_debug = "true" *) logic               dbg_wvalid;
(* mark_debug = "true" *) logic               dbg_wready;
(* mark_debug = "true" *) logic [ DATA_W-1:0] dbg_wdata;
(* mark_debug = "true" *) logic [        0:0] dbg_wlast;
(* mark_debug = "true" *) logic [WSTRB_W-1:0] dbg_wstrb;
                       
(* mark_debug = "true" *) logic               dbg_arvalid;
(* mark_debug = "true" *) logic               dbg_arready;
(* mark_debug = "true" *) logic [       63:0] dbg_araddr;
(* mark_debug = "true" *) logic [        7:0] dbg_arlen;
                       
(* mark_debug = "true" *) logic               dbg_rvalid;
(* mark_debug = "true" *) logic               dbg_rready;
(* mark_debug = "true" *) logic [ DATA_W-1:0] dbg_rdata;
(* mark_debug = "true" *) logic               dbg_rlast;


assign dbg_mfsm    = mfsm;

assign dbg_awvalid = awvalid;
assign dbg_awready = awready;
assign dbg_awaddr  = awaddr;
assign dbg_awlen   = awlen;
assign dbg_wvalid  = wvalid;
assign dbg_wready  = wready;
assign dbg_wdata   = wdata;
assign dbg_wlast   = wlast;
assign dbg_wstrb   = wstrb;
assign dbg_arvalid = arvalid;
assign dbg_arready = arready;
assign dbg_araddr  = araddr;
assign dbg_arlen   = arlen;
assign dbg_rvalid  = rvalid;
assign dbg_rready  = rready;
assign dbg_rdata   = rdata;
assign dbg_rlast   = rlast;

`endif // AXI_NTT_ENABLE_ILA


//------------------------------------------------------------------------------
//
//    Functions and tasks
//
function logic [WSTRB_W-1:0] get_wstrb(input int count);

    logic [WSTRB_W-1:0] wstrb = '1;
    return wstrb >> (8 - count%8);
endfunction

//------------------------------------------------------------------------------
//
//    Logic
//
always_ff @(posedge clk) begin
    mfsm <= mfsm_next;
end

always_comb begin

    automatic mode_fsm_t next = mfsm;

    unique case(mfsm)
    //--------------------------------------------
    mfsmWRITE_INIT: begin
        if(awready && start) begin
            next = mfsmWRITE_DATA;
        end
    end
    //--------------------------------------------
    mfsmWRITE_DATA: begin
        if(wready) begin
            //if(dcnt == COUNT-1) begin
            if(dcnt == count) begin
                next = mfsmREAD_INIT;
            end
        end
    end
    //--------------------------------------------
    mfsmREAD_INIT: begin
        if(arready && bvalid) begin
            next = mfsmREAD_DATA;
        end
    end
    //--------------------------------------------
    mfsmREAD_DATA: begin
        if(rvalid && rlast) begin
            //if(dcnt == COUNT-1) begin
            if(dcnt == count) begin
                next = mfsmWRITE_INIT;
            end
        end
    end
    //--------------------------------------------
    endcase

    mfsm_next = next;
end

always_ff @(posedge clk) begin
    if(mfsm == mfsmREAD_DATA && mfsm_next == mfsmWRITE_INIT) begin
        count <= count + 1;
        if(count == COUNT-1) begin
            count <= INIT_COUNT;
        end
    end
end

always_comb begin

    data     = dcnt + 16;

    awvalid  = 0;
    awaddr   = BASE_ADDR;
    awlen    = count; // COUNT-1;

    awburst  = AXBURST_INCR;
    awcache  = AXCACHE_NORM_NONCACHE_BUF;
    awid     = 0;
    awlock   = 0;
    awprot   = 0;
    awqos    = 0;
    awregion = 0;
    awsize   = $clog2(WSTRB_W);
    awuser   = 0;

    wvalid   = 0;
    wdata    = {(DATA_W/MAX_COUNT_W){data}};
    wlast    = 0;
    wstrb    = 0;

    bready   = 1;

    arvalid  = 0;
    araddr   = BASE_ADDR;
    arburst  = AXBURST_INCR;
    arcache  = AXCACHE_NORM_NONCACHE_BUF;
    arid     = 0;
    arlen    = count; // COUNT-1;
    arlock   = 0;
    arprot   = 0;
    arqos    = 0;
    arregion = 0;
    arsize   = $clog2(WSTRB_W);
    aruser   = 0;

    rready   = 0;

    unique case(mfsm)
    //--------------------------------------------
    mfsmWRITE_INIT: begin
        awvalid = start;
        awaddr  = BASE_ADDR + 0;
    end
    //--------------------------------------------
    mfsmWRITE_DATA: begin
        wvalid = 1;
        wstrb  = '1;
        if(mfsm_next == mfsmREAD_INIT) begin
            wlast = 1;
            //wstrb = get_wstrb(COUNT);
        end
    end
    //--------------------------------------------
    mfsmREAD_INIT: begin
        if(mfsm_next == mfsmREAD_DATA) begin
            arvalid = 1;
        end
    end
    //--------------------------------------------
    mfsmREAD_DATA: begin
        rready = 1;
    end
    //--------------------------------------------
    endcase
end

always_ff @(posedge clk) begin

    unique case(mfsm)
    //--------------------------------------------
    mfsmWRITE_INIT: begin
        dcnt <= 0;
    end
    //--------------------------------------------
    mfsmWRITE_DATA: begin
        if(wready) begin
            dcnt <= dcnt + 1;
        end
    end
    //--------------------------------------------
    mfsmREAD_INIT: begin
        dcnt <= 0;
    end
    //--------------------------------------------
    mfsmREAD_DATA: begin
        if(rvalid) begin
            dcnt <= dcnt + 1;
        end
    end
    //--------------------------------------------
    endcase

end
//------------------------------------------------------------------------------
//
//    Check data
//

always_ff @(posedge clk) begin
    if(mfsm == mfsmREAD_DATA) begin
        if(rvalid) begin
            if(rdata != wdata) begin
                out[0] <= 1;
            end

            if(mfsm_next == mfsmWRITE_INIT && !rlast) begin
                out[1] <= 1;
            end
        end
    end
end



//------------------------------------------------------------------------------
//
//    Instances
//

//------------------------------------------------------------------------------

endmodule : axi_noc_transaction_tester_m
//------------------------------------------------------------------------------

