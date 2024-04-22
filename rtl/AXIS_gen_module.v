`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/19 11:28:39
// Design Name: 
// Module Name: AXIS_gen_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module AXIS_gen_module(
    input           i_clk               ,
    input           i_rst               ,
    input           i_stat_rx_status    ,

    input           m_axis_tx_tready    ,
    output          m_axis_tx_tvalid    ,
    output [511:0]  m_axis_tx_tdata     ,
    output          m_axis_tx_tlast     ,
    output [63 :0]  m_axis_tx_tkeep     ,
    output          m_axis_tx_tuser     ,

    input           s_axis_rx_tvalid    ,
    input [511:0]   s_axis_rx_tdata     ,
    input           s_axis_rx_tlast     ,
    input [63 :0]   s_axis_rx_tkeep     ,
    input           s_axis_rx_tuser     
);


localparam  P_SEND_LEN = 10;
localparam  P_SRC_MAC = 48'h01_02_03_04_05_06;
localparam  P_DST_MAC = 48'hff_ff_ff_ff_ff_ff;
localparam  P_TYPE    = 16'h0800            ;

reg             rm_axis_tx_tvalid   = 'd0;
reg  [511:0]    rm_axis_tx_tdata    = 'd0;
reg             rm_axis_tx_tlast    = 'd0;
reg  [63 :0]    rm_axis_tx_tkeep    = 'd0;
reg  [5 : 0]    r_init_cnt          = 'd0;
reg             ri_stat_rx_status   = 'd0;
reg  [15: 0]    r_send_cnt          = 'd0;


wire            w_send_en           ;
wire            w_tx_active         ;

assign m_axis_tx_tvalid = rm_axis_tx_tvalid;
assign m_axis_tx_tlast  = rm_axis_tx_tlast ;
assign m_axis_tx_tuser  = 'd0 ;

assign w_send_en   = &r_init_cnt;
assign w_tx_active = rm_axis_tx_tvalid & m_axis_tx_tready;

genvar i;
generate
    for(i = 0; i < 64; i = i + 1)begin
        assign m_axis_tx_tdata[i*8 +: 8] = rm_axis_tx_tdata[(63-i)*8 +: 8];
        assign m_axis_tx_tkeep[i] = rm_axis_tx_tkeep[63 - i];
    end
endgenerate


always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        ri_stat_rx_status <= 'd0;
    else
        ri_stat_rx_status <= i_stat_rx_status;
end


always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        r_init_cnt <= 'd0;
    else if(&r_init_cnt)
        r_init_cnt <= r_init_cnt;
    else if(i_stat_rx_status)
        r_init_cnt <= r_init_cnt + 1;
    else
        r_init_cnt <= r_init_cnt;
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        r_send_cnt <= 'd0;
    else if(r_send_cnt == P_SEND_LEN - 1 && w_tx_active)
        r_send_cnt <= 'd0;
    else if(w_tx_active)
        r_send_cnt <= r_send_cnt + 'd1;
    else
        r_send_cnt <= r_send_cnt;
end

 
 
always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        rm_axis_tx_tvalid <= 'd0;
    else if(r_send_cnt == P_SEND_LEN - 1 && w_tx_active)
        rm_axis_tx_tvalid <= 'd0;
    else if(w_send_en)
        rm_axis_tx_tvalid <= 'd1;
    else
        rm_axis_tx_tvalid <= rm_axis_tx_tvalid;
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        rm_axis_tx_tdata <= 'd0;
    else if(r_send_cnt == 0 && w_tx_active)
        rm_axis_tx_tdata <= {32{16'haa_bb}};
    else if(r_send_cnt == 0)
        rm_axis_tx_tdata <= {P_DST_MAC,P_SRC_MAC,P_TYPE,{50{8'hab}}};
    else if(w_tx_active)
        rm_axis_tx_tdata <= {32{r_send_cnt}};
    else
        rm_axis_tx_tdata <= rm_axis_tx_tdata;
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        rm_axis_tx_tlast <= 'd0;
    else if(r_send_cnt == P_SEND_LEN - 2 && w_tx_active)
        rm_axis_tx_tlast <= 'd1;
    else if(r_send_cnt == P_SEND_LEN - 1 && w_tx_active)
        rm_axis_tx_tlast <= 'd0;
    else
        rm_axis_tx_tlast <= rm_axis_tx_tlast;
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        rm_axis_tx_tkeep <= 'd0;
    else
        rm_axis_tx_tkeep <= 64'hffff_ffff_ffff_ffff;
end

endmodule
