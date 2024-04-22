`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/21 15:56:53
// Design Name: 
// Module Name: VCU128_100g_eth_top
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


module VCU128_100g_eth_top#(
    parameter                       P_CHANNEL_NUM = 2           
)(
    input                           i_gt0_refclk_p  ,
    input                           i_gt0_refclk_n  ,
    input                           i_gt1_refclk_p  ,
    input                           i_gt1_refclk_n  ,
    input                           i_sys_clk_p     ,
    input                           i_sys_clk_n     ,

    output [1:0]                    o_status_led    ,
    output                          QSFP1_MODSKLL_LS,
    output                          QSFP1_RESETL_LS ,
    output                          QSFP1_MODPRSL_LS,
    output                          QSFP1_LPMODE_LS ,
    output                          QSFP2_MODSKLL_LS,
    output                          QSFP2_RESETL_LS ,
    output                          QSFP2_MODPRSL_LS,
    output                          QSFP2_LPMODE_LS ,

    output [P_CHANNEL_NUM*4 - 1: 0] o_gt_txp        ,
    output [P_CHANNEL_NUM*4 - 1: 0] o_gt_txn        ,
    input  [P_CHANNEL_NUM*4 - 1: 0] i_gt_rxp        ,
    input  [P_CHANNEL_NUM*4 - 1: 0] i_gt_rxn        
);

assign QSFP1_MODSKLL_LS = 0;
assign QSFP1_RESETL_LS  = 1;
assign QSFP1_MODPRSL_LS = 0;
assign QSFP1_LPMODE_LS  = 0;
assign QSFP2_MODSKLL_LS = 0;
assign QSFP2_RESETL_LS  = 1;
assign QSFP2_MODPRSL_LS = 0;
assign QSFP2_LPMODE_LS  = 0;

wire            w_init_clk          ;
wire            w_sys_rst           ;
wire            w_locked            ;
wire            w_gt0_refclk        ;
wire            w_gt0_refclk_out    ;
wire            w_gt1_refclk        ;
wire            w_gt1_refclk_out    ;

wire            w_0_tx_clk          ;
wire            w_0_usr_tx_reset    ;
wire            w_0_usr_rx_reset    ;
wire            w_0_stat_rx_status  ;
wire            w_0_gt_powergood    ;
wire            rx0_axis_tvalid     ;
wire [511 : 0]  rx0_axis_tdata      ;
wire            rx0_axis_tlast      ;
wire [63 : 0]   rx0_axis_tkeep      ;
wire            rx0_axis_tuser      ;
wire            tx0_axis_tready     ;
wire            tx0_axis_tvalid     ;
wire [511 : 0]  tx0_axis_tdata      ;
wire            tx0_axis_tlast      ;
wire [63 : 0]   tx0_axis_tkeep      ;
wire            tx0_axis_tuser      ;

wire            w_1_tx_clk          ;
wire            w_1_usr_tx_reset    ;
wire            w_1_usr_rx_reset    ;
wire            w_1_stat_rx_status  ;
wire            w_1_gt_powergood    ;
wire            rx1_axis_tvalid     ;
wire [511 : 0]  rx1_axis_tdata      ;
wire            rx1_axis_tlast      ;
wire [63 : 0]   rx1_axis_tkeep      ;
wire            rx1_axis_tuser      ;
wire            tx1_axis_tready     ;
wire            tx1_axis_tvalid     ;
wire [511 : 0]  tx1_axis_tdata      ;
wire            tx1_axis_tlast      ;
wire [63 : 0]   tx1_axis_tkeep      ;
wire            tx1_axis_tuser      ;

assign o_status_led = {w_0_stat_rx_status,w_1_stat_rx_status};


ila_axi_tx ila_axi_tx0 (
	.clk(w_0_tx_clk), // input wire clk
	.probe0(tx0_axis_tvalid), // input wire [0:0]  probe0  
	.probe1(tx0_axis_tdata ), // input wire [511:0]  probe1 
	.probe2(tx0_axis_tlast ), // input wire [0:0]  probe2 
	.probe3(tx0_axis_tkeep ), // input wire [63:0]  probe3 
	.probe4(tx0_axis_tuser ), // input wire [0:0]  probe4 
	.probe5(tx0_axis_tready) // input wire [0:0]  probe5
);
ila_axis_rx ila_axi_rx0 (
	.clk(w_0_tx_clk), // input wire clk
	.probe0(rx0_axis_tvalid), // input wire [0:0]  probe0  
	.probe1(rx0_axis_tdata ), // input wire [511:0]  probe1 
	.probe2(rx0_axis_tlast ), // input wire [0:0]  probe2 
	.probe3(rx0_axis_tkeep ), // input wire [63:0]  probe3 
	.probe4(rx0_axis_tuser ) // input wire [0:0]  probe4
);

ila_axi_tx ila_axi_tx1 (
	.clk(w_1_tx_clk), // input wire clk
	.probe0(tx1_axis_tvalid), // input wire [0:0]  probe0  
	.probe1(tx1_axis_tdata ), // input wire [511:0]  probe1 
	.probe2(tx1_axis_tlast ), // input wire [0:0]  probe2 
	.probe3(tx1_axis_tkeep ), // input wire [63:0]  probe3 
	.probe4(tx1_axis_tuser ), // input wire [0:0]  probe4 
	.probe5(tx1_axis_tready) // input wire [0:0]  probe5
);
ila_axis_rx ila_axi_rx1 (
	.clk(w_1_tx_clk), // input wire clk
	.probe0(rx1_axis_tvalid), // input wire [0:0]  probe0  
	.probe1(rx1_axis_tdata ), // input wire [511:0]  probe1 
	.probe2(rx1_axis_tlast ), // input wire [0:0]  probe2 
	.probe3(rx1_axis_tkeep ), // input wire [63:0]  probe3 
	.probe4(rx1_axis_tuser ) // input wire [0:0]  probe4
);


clk_wiz_100mhz clk_wiz_100mhz_u0
(
    .clk_out1               (w_init_clk     ),   
    .locked                 (w_locked       ),       
    .clk_in1_p              (i_sys_clk_p    ), 
    .clk_in1_n              (i_sys_clk_n    )  
);

rst_gen_module#(
    .P_RST_CYCLE            (100)   
)rst_gen_module_u0(
    .i_clk                  (w_init_clk     ),
    .i_rst                  (~w_locked      ),
    .o_rst                  (w_sys_rst      ) 
);

cmac_usplus_0_clocking_wrapper i_cmac_usplus_0_clocking_wrapper0
(
    .gt_ref_clk_p           (i_gt0_refclk_p     ),
    .gt_ref_clk_n           (i_gt0_refclk_n     ),
    .gt_powergood           (w_gt0_powergood    ),
    .gt_ref_clk             (w_gt0_refclk       ),
    .gt_ref_clk_out         (w_gt0_refclk_out   )
);

cmac_usplus_0_clocking_wrapper i_cmac_usplus_0_clocking_wrapper1
(
    .gt_ref_clk_p           (i_gt1_refclk_p     ),
    .gt_ref_clk_n           (i_gt1_refclk_n     ),
    .gt_powergood           (w_gt1_powergood    ),
    .gt_ref_clk             (w_gt1_refclk       ),
    .gt_ref_clk_out         (w_gt1_refclk_out   )
);


AXIS_gen_module AXIS_gen_module_u0(
    .i_clk                  (w_0_tx_clk         ),
    .i_rst                  (w_0_usr_tx_reset   ),
    .i_stat_rx_status       (w_0_stat_rx_status ),
    .m_axis_tx_tready       (tx0_axis_tready    ),
    .m_axis_tx_tvalid       (tx0_axis_tvalid    ),
    .m_axis_tx_tdata        (tx0_axis_tdata     ),
    .m_axis_tx_tlast        (tx0_axis_tlast     ),
    .m_axis_tx_tkeep        (tx0_axis_tkeep     ),
    .m_axis_tx_tuser        (tx0_axis_tuser     ),
    .s_axis_rx_tvalid       (rx0_axis_tvalid    ),
    .s_axis_rx_tdata        (rx0_axis_tdata     ),
    .s_axis_rx_tlast        (rx0_axis_tlast     ),
    .s_axis_rx_tkeep        (rx0_axis_tkeep     ),
    .s_axis_rx_tuser        (rx0_axis_tuser     ) 
);

AXIS_gen_module AXIS_gen_module_u1(
    .i_clk                  (w_1_tx_clk         ),
    .i_rst                  (w_1_usr_tx_reset   ),
    .i_stat_rx_status       (w_1_stat_rx_status ),
    .m_axis_tx_tready       (tx1_axis_tready    ),
    .m_axis_tx_tvalid       (tx1_axis_tvalid    ),
    .m_axis_tx_tdata        (tx1_axis_tdata     ),
    .m_axis_tx_tlast        (tx1_axis_tlast     ),
    .m_axis_tx_tkeep        (tx1_axis_tkeep     ),
    .m_axis_tx_tuser        (tx1_axis_tuser     ),
    .s_axis_rx_tvalid       (rx1_axis_tvalid    ),
    .s_axis_rx_tdata        (rx1_axis_tdata     ),
    .s_axis_rx_tlast        (rx1_axis_tlast     ),
    .s_axis_rx_tkeep        (rx1_axis_tkeep     ),
    .s_axis_rx_tuser        (rx1_axis_tuser     ) 
);

Uplus_100g_eth_module Uplus_100g_eth_module_u0(
    .i_gt_refclk            (w_gt0_refclk       ),
    .i_init_clk             (w_init_clk         ),
    .i_sys_rst              (w_sys_rst          ),
    .o_tx_clk               (w_0_tx_clk         ),
    .o_usr_tx_reset         (w_0_usr_tx_reset   ),
    .o_usr_rx_reset         (w_0_usr_rx_reset   ),
    .o_stat_rx_status       (w_0_stat_rx_status ),
    .o_gt_powergood         (w_0_gt_powergood   ),
    .rx_axis_tvalid         (rx0_axis_tvalid    ),
    .rx_axis_tdata          (rx0_axis_tdata     ),
    .rx_axis_tlast          (rx0_axis_tlast     ),
    .rx_axis_tkeep          (rx0_axis_tkeep     ),
    .rx_axis_tuser          (rx0_axis_tuser     ),
    .tx_axis_tready         (tx0_axis_tready    ),
    .tx_axis_tvalid         (tx0_axis_tvalid    ),
    .tx_axis_tdata          (tx0_axis_tdata     ),
    .tx_axis_tlast          (tx0_axis_tlast     ),
    .tx_axis_tkeep          (tx0_axis_tkeep     ),
    .tx_axis_tuser          (tx0_axis_tuser     ),
    .i_gt_rxp               (i_gt_rxp[3:0]      ),
    .i_gt_rxn               (i_gt_rxn[3:0]      ),
    .o_gt_txp               (o_gt_txp[3:0]      ),
    .o_gt_txn               (o_gt_txn[3:0]      ) 
);

Uplus_100g_eth_module Uplus_100g_eth_module_u1(
    .i_gt_refclk            (w_gt1_refclk       ),
    .i_init_clk             (w_init_clk         ),
    .i_sys_rst              (w_sys_rst          ),
    .o_tx_clk               (w_1_tx_clk         ),
    .o_usr_tx_reset         (w_1_usr_tx_reset   ),
    .o_usr_rx_reset         (w_1_usr_rx_reset   ),
    .o_stat_rx_status       (w_1_stat_rx_status ),
    .o_gt_powergood         (w_1_gt_powergood   ),
    .rx_axis_tvalid         (rx1_axis_tvalid    ),
    .rx_axis_tdata          (rx1_axis_tdata     ),
    .rx_axis_tlast          (rx1_axis_tlast     ),
    .rx_axis_tkeep          (rx1_axis_tkeep     ),
    .rx_axis_tuser          (rx1_axis_tuser     ),
    .tx_axis_tready         (tx1_axis_tready    ),
    .tx_axis_tvalid         (tx1_axis_tvalid    ),
    .tx_axis_tdata          (tx1_axis_tdata     ),
    .tx_axis_tlast          (tx1_axis_tlast     ),
    .tx_axis_tkeep          (tx1_axis_tkeep     ),
    .tx_axis_tuser          (tx1_axis_tuser     ),
    .i_gt_rxp               (i_gt_rxp[7:4]      ),
    .i_gt_rxn               (i_gt_rxn[7:4]      ),
    .o_gt_txp               (o_gt_txp[7:4]      ),
    .o_gt_txn               (o_gt_txn[7:4]      ) 
);


endmodule
