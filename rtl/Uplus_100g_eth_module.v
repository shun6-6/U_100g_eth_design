`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/21 15:49:06
// Design Name: 
// Module Name: Uplus_100g_eth_module
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


module Uplus_100g_eth_module(
    input               i_gt_refclk         ,
    input               i_init_clk          ,
    input               i_sys_rst           ,
    output              o_tx_clk            ,
    output              o_usr_tx_reset      ,
    output              o_usr_rx_reset      ,
    output              o_stat_rx_status    ,
    output              o_gt_powergood      ,

    output              rx_axis_tvalid      ,
    output [511 : 0]    rx_axis_tdata       ,
    output              rx_axis_tlast       ,
    output [63 : 0]     rx_axis_tkeep       ,
    output              rx_axis_tuser       ,
    output              tx_axis_tready      ,
    input               tx_axis_tvalid      ,
    input  [511 : 0]    tx_axis_tdata       ,
    input               tx_axis_tlast       ,
    input  [63 : 0]     tx_axis_tkeep       ,
    input               tx_axis_tuser       ,

    input  [3 :0]       i_gt_rxp            ,
    input  [3 :0]       i_gt_rxn            ,
    output [3 :0]       o_gt_txp            ,
    output [3 :0]       o_gt_txn            
);

wire w_qpll0reset       ;
wire w_qpll0lock        ;
wire w_qpll0outclk      ;
wire w_qpll0outrefclk   ;

cmac_usplus_0_common_wrapper i_cmac_usplus_0_common_wrapper
(
    .refclk                 (i_gt_refclk        ),
    .qpll0reset             (w_qpll0reset       ),
    .qpll0lock              (w_qpll0lock        ),
    .qpll0outclk            (w_qpll0outclk      ),
    .qpll0outrefclk         (w_qpll0outrefclk   ),
    .qpll1reset             (1'b0               ),
    .qpll1lock              (),
    .qpll1outclk            (),
    .qpll1outrefclk         ()
);

Uplus_100g_eth_channel Uplus_100g_eth_channel_u0(
    .i_init_clk             (i_init_clk         ),
    .i_sys_rst              (i_sys_rst          ),
    .o_tx_clk               (o_tx_clk           ),
    .o_usr_tx_reset         (o_usr_tx_reset     ),
    .o_usr_rx_reset         (o_usr_rx_reset     ),
    .o_stat_rx_status       (o_stat_rx_status   ),
    .o_gt_powergood         (o_gt_powergood     ),
    .o_qpll0reset           (w_qpll0reset       ),
    .i_qpll0lock            (w_qpll0lock        ),
    .i_qpll0outclk          (w_qpll0outclk      ),
    .i_qpll0outrefclk       (w_qpll0outrefclk   ),
    .rx_axis_tvalid         (rx_axis_tvalid     ),
    .rx_axis_tdata          (rx_axis_tdata      ),
    .rx_axis_tlast          (rx_axis_tlast      ),
    .rx_axis_tkeep          (rx_axis_tkeep      ),
    .rx_axis_tuser          (rx_axis_tuser      ),
    .tx_axis_tready         (tx_axis_tready     ),
    .tx_axis_tvalid         (tx_axis_tvalid     ),
    .tx_axis_tdata          (tx_axis_tdata      ),
    .tx_axis_tlast          (tx_axis_tlast      ),
    .tx_axis_tkeep          (tx_axis_tkeep      ),
    .tx_axis_tuser          (tx_axis_tuser      ),
    .i_gt_rxp               (i_gt_rxp           ),
    .i_gt_rxn               (i_gt_rxn           ),
    .o_gt_txp               (o_gt_txp           ),
    .o_gt_txn               (o_gt_txn           ) 
);


endmodule
