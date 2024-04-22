`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/21 15:49:06
// Design Name: 
// Module Name: Uplus_100g_eth_channel
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


module Uplus_100g_eth_channel(
    input               i_init_clk          ,
    input               i_sys_rst           ,
    output              o_tx_clk            ,
    output              o_usr_tx_reset      ,
    output              o_usr_rx_reset      ,
    output              o_stat_rx_status    ,
    output              o_gt_powergood      ,

    output              o_qpll0reset        ,
    input               i_qpll0lock         ,
    input               i_qpll0outclk       ,
    input               i_qpll0outrefclk    ,

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

wire [3 :0]     w_gt_powergoodout           ;
wire [3 :0]     w_gt_rxrecclkout            ;
wire [11 : 0]   w_gt_loopback_in            ;
wire            w_gtwiz_reset_tx_datapath   ;
wire            w_gtwiz_reset_rx_datapath   ;

wire [7 : 0]    rx_otn_bip8_0               ;
wire [7 : 0]    rx_otn_bip8_1               ;
wire [7 : 0]    rx_otn_bip8_2               ;
wire [7 : 0]    rx_otn_bip8_3               ;
wire [7 : 0]    rx_otn_bip8_4               ;
wire [65 : 0]   rx_otn_data_0               ;
wire [65 : 0]   rx_otn_data_1               ;
wire [65 : 0]   rx_otn_data_2               ;
wire [65 : 0]   rx_otn_data_3               ;
wire [65 : 0]   rx_otn_data_4               ;

wire            rx_otn_ena                      ;
wire            rx_otn_lane0                    ;
wire            rx_otn_vlmarker                 ;
wire [55 : 0]   rx_preambleout                  ;
wire            gt_rxusrclk2                    ;
wire            stat_rx_aligned                 ;
wire            stat_rx_aligned_err             ;
wire [2 : 0]    stat_rx_bad_code                ;
wire [2 : 0]    stat_rx_bad_fcs                 ;
wire            stat_rx_bad_preamble            ;
wire            stat_rx_bad_sfd                 ;
wire            stat_rx_bip_err_0               ;
wire            stat_rx_bip_err_1               ;
wire            stat_rx_bip_err_10              ;
wire            stat_rx_bip_err_11              ;
wire            stat_rx_bip_err_12              ;
wire            stat_rx_bip_err_13              ;
wire            stat_rx_bip_err_14              ;
wire            stat_rx_bip_err_15              ;
wire            stat_rx_bip_err_16              ;
wire            stat_rx_bip_err_17              ;
wire            stat_rx_bip_err_18              ;
wire            stat_rx_bip_err_19              ;
wire            stat_rx_bip_err_2               ;
wire            stat_rx_bip_err_3               ;
wire            stat_rx_bip_err_4               ;
wire            stat_rx_bip_err_5               ;
wire            stat_rx_bip_err_6               ;
wire            stat_rx_bip_err_7               ;
wire            stat_rx_bip_err_8               ;
wire            stat_rx_bip_err_9               ;
wire [19 : 0]   stat_rx_block_lock              ;
wire            stat_rx_broadcast               ;
wire [2 : 0]    stat_rx_fragment                ;
wire [1 : 0]    stat_rx_framing_err_0           ;
wire [1 : 0]    stat_rx_framing_err_1           ;
wire [1 : 0]    stat_rx_framing_err_10          ;
wire [1 : 0]    stat_rx_framing_err_11          ;
wire [1 : 0]    stat_rx_framing_err_12          ;
wire [1 : 0]    stat_rx_framing_err_13          ;
wire [1 : 0]    stat_rx_framing_err_14          ;
wire [1 : 0]    stat_rx_framing_err_15          ;
wire [1 : 0]    stat_rx_framing_err_16          ;
wire [1 : 0]    stat_rx_framing_err_17          ;
wire [1 : 0]    stat_rx_framing_err_18          ;
wire [1 : 0]    stat_rx_framing_err_19          ;
wire [1 : 0]    stat_rx_framing_err_2           ;
wire [1 : 0]    stat_rx_framing_err_3           ;
wire [1 : 0]    stat_rx_framing_err_4           ;
wire [1 : 0]    stat_rx_framing_err_5           ;
wire [1 : 0]    stat_rx_framing_err_6           ;
wire [1 : 0]    stat_rx_framing_err_7           ;
wire [1 : 0]    stat_rx_framing_err_8           ;
wire [1 : 0]    stat_rx_framing_err_9           ;
wire            stat_rx_framing_err_valid_0     ;
wire            stat_rx_framing_err_valid_1     ;
wire            stat_rx_framing_err_valid_10    ;
wire            stat_rx_framing_err_valid_11    ;
wire            stat_rx_framing_err_valid_12    ;
wire            stat_rx_framing_err_valid_13    ;
wire            stat_rx_framing_err_valid_14    ;
wire            stat_rx_framing_err_valid_15    ;
wire            stat_rx_framing_err_valid_16    ;
wire            stat_rx_framing_err_valid_17    ;
wire            stat_rx_framing_err_valid_18    ;
wire            stat_rx_framing_err_valid_19    ;
wire            stat_rx_framing_err_valid_2     ;
wire            stat_rx_framing_err_valid_3     ;
wire            stat_rx_framing_err_valid_4     ;
wire            stat_rx_framing_err_valid_5     ;
wire            stat_rx_framing_err_valid_6     ;
wire            stat_rx_framing_err_valid_7     ;
wire            stat_rx_framing_err_valid_8     ;
wire            stat_rx_framing_err_valid_9     ;
wire            stat_rx_got_signal_os           ;
wire            stat_rx_hi_ber                  ;
wire            stat_rx_inrangeerr              ;
wire            stat_rx_internal_local_fault    ;
wire            stat_rx_jabber                  ;
wire            stat_rx_local_fault             ;
wire [19 : 0]   stat_rx_mf_err                  ;
wire [19 : 0]   stat_rx_mf_len_err              ;
wire [19 : 0]   stat_rx_mf_repeat_err           ;
wire            stat_rx_misaligned              ;
wire            stat_rx_multicast               ;
wire            stat_rx_oversize                ;
wire            stat_rx_packet_1024_1518_bytes  ;
wire            stat_rx_packet_128_255_bytes    ;
wire            stat_rx_packet_1519_1522_bytes  ;
wire            stat_rx_packet_1523_1548_bytes  ;
wire            stat_rx_packet_1549_2047_bytes  ;
wire            stat_rx_packet_2048_4095_bytes  ;
wire            stat_rx_packet_256_511_bytes    ;
wire            stat_rx_packet_4096_8191_bytes  ;
wire            stat_rx_packet_512_1023_bytes   ;
wire            stat_rx_packet_64_bytes         ;
wire            stat_rx_packet_65_127_bytes     ;
wire            stat_rx_packet_8192_9215_bytes  ;
wire            stat_rx_packet_bad_fcs          ;
wire            stat_rx_packet_large            ;
wire [2 : 0]    stat_rx_packet_small            ;

wire            ctl_rx_enable                   ;
wire            ctl_rx_force_resync             ;
wire            ctl_rx_test_pattern             ;

wire            stat_rx_received_local_fault    ;
wire            stat_rx_remote_fault            ;
wire [2 : 0]    stat_rx_stomped_fcs             ;
wire [19 : 0]   stat_rx_synced                  ;
wire [19 : 0]   stat_rx_synced_err              ;
wire [2 : 0]    stat_rx_test_pattern_mismatch   ;
wire            stat_rx_toolong                 ;
wire [6 : 0]    stat_rx_total_bytes             ;
wire [13 : 0]   stat_rx_total_good_bytes        ;
wire            stat_rx_total_good_packets      ;
wire [2 : 0]    stat_rx_total_packets           ;
wire            stat_rx_truncated               ;
wire [2 : 0]    stat_rx_undersize               ;
wire            stat_rx_unicast                 ;
wire            stat_rx_vlan                    ;
wire [19 : 0]   stat_rx_pcsl_demuxed            ;
wire [4 : 0]    stat_rx_pcsl_number_0           ;
wire [4 : 0]    stat_rx_pcsl_number_1           ;
wire [4 : 0]    stat_rx_pcsl_number_10          ;
wire [4 : 0]    stat_rx_pcsl_number_11          ;
wire [4 : 0]    stat_rx_pcsl_number_12          ;
wire [4 : 0]    stat_rx_pcsl_number_13          ;
wire [4 : 0]    stat_rx_pcsl_number_14          ;
wire [4 : 0]    stat_rx_pcsl_number_15          ;
wire [4 : 0]    stat_rx_pcsl_number_16          ;
wire [4 : 0]    stat_rx_pcsl_number_17          ;
wire [4 : 0]    stat_rx_pcsl_number_18          ;
wire [4 : 0]    stat_rx_pcsl_number_19          ;
wire [4 : 0]    stat_rx_pcsl_number_2           ;
wire [4 : 0]    stat_rx_pcsl_number_3           ;
wire [4 : 0]    stat_rx_pcsl_number_4           ;
wire [4 : 0]    stat_rx_pcsl_number_5           ;
wire [4 : 0]    stat_rx_pcsl_number_6           ;
wire [4 : 0]    stat_rx_pcsl_number_7           ;
wire [4 : 0]    stat_rx_pcsl_number_8           ;
wire [4 : 0]    stat_rx_pcsl_number_9           ;
wire            stat_tx_bad_fcs                 ;
wire            stat_tx_broadcast               ;
wire            stat_tx_frame_error             ;
wire            stat_tx_local_fault             ;
wire            stat_tx_multicast               ;
wire            stat_tx_packet_1024_1518_bytes  ;
wire            stat_tx_packet_128_255_bytes    ;
wire            stat_tx_packet_1519_1522_bytes  ;
wire            stat_tx_packet_1523_1548_bytes  ;
wire            stat_tx_packet_1549_2047_bytes  ;
wire            stat_tx_packet_2048_4095_bytes  ;
wire            stat_tx_packet_256_511_bytes    ;
wire            stat_tx_packet_4096_8191_bytes  ;
wire            stat_tx_packet_512_1023_bytes   ;
wire            stat_tx_packet_64_bytes         ;
wire            stat_tx_packet_65_127_bytes     ;
wire            stat_tx_packet_8192_9215_bytes  ;
wire            stat_tx_packet_large            ;
wire            stat_tx_packet_small            ;
wire [5 : 0]    stat_tx_total_bytes             ;
wire [13 : 0]   stat_tx_total_good_bytes        ;
wire            stat_tx_total_good_packets      ;
wire            stat_tx_total_packets           ;
wire            stat_tx_unicast                 ;
wire            stat_tx_vlan                    ;

wire            ctl_tx_enable                   ;
wire            ctl_tx_send_idle                ;
wire            ctl_tx_send_rfi                 ;
wire            ctl_tx_send_lfi                 ;
wire            ctl_tx_test_pattern             ;
wire            tx_ovfout                       ;
wire            tx_unfout                       ;
wire [55 : 0]   tx_preamblein                   ;
wire            w_tx_reset_done                 ;
wire            w_rx_reset_done                 ;
wire [9 : 0]    w_rx_serdes_reset_done          ;
wire [9 : 0]    w_rx_serdes_clk                 ;

wire [3 : 0]    w_qpll0clk_in                   ;
wire [3 : 0]    w_qpll0refclk_in                ;
wire [3 : 0]    w_qpll1clk_in                   ;
wire [3 : 0]    w_qpll1refclk_in                ;

cmac_usplus_0_shared_logic_wrapper i_cmac_usplus_0_shared_logic_wrapper
(
    .gt_txusrclk2                         (o_tx_clk                 ),
    .gt_rxusrclk2                         (gt_rxusrclk2             ),
    .rx_clk                               (o_tx_clk                 ),//rx_clk要与tx_clk同频率，直接赋值就行
    .gt_tx_reset_in                       (w_gt_reset_tx_done_out   ),
    .gt_rx_reset_in                       (w_gt_reset_rx_done_out   ),
    .core_drp_reset                       ('d0                      ),
    .core_tx_reset                        ('d0                      ),
    .tx_reset_out                         (w_tx_reset_done          ),
    .core_rx_reset                        ('d0                      ),
    .rx_reset_out                         (w_rx_reset_done          ),
    .rx_serdes_reset_out                  (w_rx_serdes_reset_done   ),
    .usr_tx_reset                         (o_usr_tx_reset           ),
    .usr_rx_reset                         (o_usr_rx_reset           )
);

cmac_usplus_0 cmac_usplus_0_u0 (
  .gt_txp_out                       (o_gt_txp                       ),  // output wire [3 : 0] gt_txp_out
  .gt_txn_out                       (o_gt_txn                       ),  // output wire [3 : 0] gt_txn_out
  .gt_rxp_in                        (i_gt_rxp                       ),  // input wire [3 : 0] gt_rxp_in
  .gt_rxn_in                        (i_gt_rxn                       ),  // input wire [3 : 0] gt_rxn_in
  .gt_txusrclk2                     (o_tx_clk                       ),  // output wire gt_txusrclk2
  .gt_loopback_in                   (w_gt_loopback_in               ),  // input wire [11 : 0] gt_loopback_in
  .gt_rxrecclkout                   (w_gt_rxrecclkout               ),  // output wire [3 : 0] gt_rxrecclkout
  .gt_powergoodout                  (w_gt_powergoodout              ),  // output wire [3 : 0] gt_powergoodout
  .gtwiz_reset_tx_datapath          (w_gtwiz_reset_tx_datapath      ),  // input wire gtwiz_reset_tx_datapath
  .gtwiz_reset_rx_datapath          (w_gtwiz_reset_rx_datapath      ),  // input wire gtwiz_reset_rx_datapath
  .sys_reset                        (i_sys_rst                      ),  // input wire sys_reset
  .init_clk                         (i_init_clk                     ),  // input wire init_clk
  .rx_axis_tvalid                   (rx_axis_tvalid                 ),  // output wire rx_axis_tvalid
  .rx_axis_tdata                    (rx_axis_tdata                  ),  // output wire [511 : 0] rx_axis_tdata
  .rx_axis_tlast                    (rx_axis_tlast                  ),  // output wire rx_axis_tlast
  .rx_axis_tkeep                    (rx_axis_tkeep                  ),  // output wire [63 : 0] rx_axis_tkeep
  .rx_axis_tuser                    (rx_axis_tuser                  ),  // output wire rx_axis_tuser
  .rx_otn_bip8_0                    (rx_otn_bip8_0                  ),  // output wire [7 : 0] rx_otn_bip8_0
  .rx_otn_bip8_1                    (rx_otn_bip8_1                  ),  // output wire [7 : 0] rx_otn_bip8_1
  .rx_otn_bip8_2                    (rx_otn_bip8_2                  ),  // output wire [7 : 0] rx_otn_bip8_2
  .rx_otn_bip8_3                    (rx_otn_bip8_3                  ),  // output wire [7 : 0] rx_otn_bip8_3
  .rx_otn_bip8_4                    (rx_otn_bip8_4                  ),  // output wire [7 : 0] rx_otn_bip8_4
  .rx_otn_data_0                    (rx_otn_data_0                  ),  // output wire [65 : 0] rx_otn_data_0
  .rx_otn_data_1                    (rx_otn_data_1                  ),  // output wire [65 : 0] rx_otn_data_1
  .rx_otn_data_2                    (rx_otn_data_2                  ),  // output wire [65 : 0] rx_otn_data_2
  .rx_otn_data_3                    (rx_otn_data_3                  ),  // output wire [65 : 0] rx_otn_data_3
  .rx_otn_data_4                    (rx_otn_data_4                  ),  // output wire [65 : 0] rx_otn_data_4
  .rx_otn_ena                       (rx_otn_ena                     ),  // output wire rx_otn_ena
  .rx_otn_lane0                     (rx_otn_lane0                   ),  // output wire rx_otn_lane0
  .rx_otn_vlmarker                  (rx_otn_vlmarker                ),  // output wire rx_otn_vlmarker
  .rx_preambleout                   (rx_preambleout                 ),  // output wire [55 : 0] rx_preambleout
  .gt_rxusrclk2                     (gt_rxusrclk2                   ),  // output wire gt_rxusrclk2
  .stat_rx_aligned                  (stat_rx_aligned                ),  // output wire stat_rx_aligned
  .stat_rx_aligned_err              (stat_rx_aligned_err            ),  // output wire stat_rx_aligned_err
  .stat_rx_bad_code                 (stat_rx_bad_code               ),  // output wire [2 : 0] stat_rx_bad_code
  .stat_rx_bad_fcs                  (stat_rx_bad_fcs                ),  // output wire [2 : 0] stat_rx_bad_fcs
  .stat_rx_bad_preamble             (stat_rx_bad_preamble           ),  // output wire stat_rx_bad_preamble
  .stat_rx_bad_sfd                  (stat_rx_bad_sfd                ),  // output wire stat_rx_bad_sfd
  .stat_rx_bip_err_0                (stat_rx_bip_err_0              ),  // output wire stat_rx_bip_err_0
  .stat_rx_bip_err_1                (stat_rx_bip_err_1              ),  // output wire stat_rx_bip_err_1
  .stat_rx_bip_err_10               (stat_rx_bip_err_10             ),  // output wire stat_rx_bip_err_10
  .stat_rx_bip_err_11               (stat_rx_bip_err_11             ),  // output wire stat_rx_bip_err_11
  .stat_rx_bip_err_12               (stat_rx_bip_err_12             ),  // output wire stat_rx_bip_err_12
  .stat_rx_bip_err_13               (stat_rx_bip_err_13             ),  // output wire stat_rx_bip_err_13
  .stat_rx_bip_err_14               (stat_rx_bip_err_14             ),  // output wire stat_rx_bip_err_14
  .stat_rx_bip_err_15               (stat_rx_bip_err_15             ),  // output wire stat_rx_bip_err_15
  .stat_rx_bip_err_16               (stat_rx_bip_err_16             ),  // output wire stat_rx_bip_err_16
  .stat_rx_bip_err_17               (stat_rx_bip_err_17             ),  // output wire stat_rx_bip_err_17
  .stat_rx_bip_err_18               (stat_rx_bip_err_18             ),  // output wire stat_rx_bip_err_18
  .stat_rx_bip_err_19               (stat_rx_bip_err_19             ),  // output wire stat_rx_bip_err_19
  .stat_rx_bip_err_2                (stat_rx_bip_err_2              ),  // output wire stat_rx_bip_err_2
  .stat_rx_bip_err_3                (stat_rx_bip_err_3              ),  // output wire stat_rx_bip_err_3
  .stat_rx_bip_err_4                (stat_rx_bip_err_4              ),  // output wire stat_rx_bip_err_4
  .stat_rx_bip_err_5                (stat_rx_bip_err_5              ),  // output wire stat_rx_bip_err_5
  .stat_rx_bip_err_6                (stat_rx_bip_err_6              ),  // output wire stat_rx_bip_err_6
  .stat_rx_bip_err_7                (stat_rx_bip_err_7              ),  // output wire stat_rx_bip_err_7
  .stat_rx_bip_err_8                (stat_rx_bip_err_8              ),  // output wire stat_rx_bip_err_8
  .stat_rx_bip_err_9                (stat_rx_bip_err_9              ),  // output wire stat_rx_bip_err_9
  .stat_rx_block_lock               (stat_rx_block_lock             ),  // output wire [19 : 0] stat_rx_block_lock
  .stat_rx_broadcast                (stat_rx_broadcast              ),  // output wire stat_rx_broadcast
  .stat_rx_fragment                 (stat_rx_fragment               ),  // output wire [2 : 0] stat_rx_fragment
  .stat_rx_framing_err_0            (stat_rx_framing_err_0          ),  // output wire [1 : 0] stat_rx_framing_err_0
  .stat_rx_framing_err_1            (stat_rx_framing_err_1          ),  // output wire [1 : 0] stat_rx_framing_err_1
  .stat_rx_framing_err_10           (stat_rx_framing_err_10         ),  // output wire [1 : 0] stat_rx_framing_err_10
  .stat_rx_framing_err_11           (stat_rx_framing_err_11         ),  // output wire [1 : 0] stat_rx_framing_err_11
  .stat_rx_framing_err_12           (stat_rx_framing_err_12         ),  // output wire [1 : 0] stat_rx_framing_err_12
  .stat_rx_framing_err_13           (stat_rx_framing_err_13         ),  // output wire [1 : 0] stat_rx_framing_err_13
  .stat_rx_framing_err_14           (stat_rx_framing_err_14         ),  // output wire [1 : 0] stat_rx_framing_err_14
  .stat_rx_framing_err_15           (stat_rx_framing_err_15         ),  // output wire [1 : 0] stat_rx_framing_err_15
  .stat_rx_framing_err_16           (stat_rx_framing_err_16         ),  // output wire [1 : 0] stat_rx_framing_err_16
  .stat_rx_framing_err_17           (stat_rx_framing_err_17         ),  // output wire [1 : 0] stat_rx_framing_err_17
  .stat_rx_framing_err_18           (stat_rx_framing_err_18         ),  // output wire [1 : 0] stat_rx_framing_err_18
  .stat_rx_framing_err_19           (stat_rx_framing_err_19         ),  // output wire [1 : 0] stat_rx_framing_err_19
  .stat_rx_framing_err_2            (stat_rx_framing_err_2          ),  // output wire [1 : 0] stat_rx_framing_err_2
  .stat_rx_framing_err_3            (stat_rx_framing_err_3          ),  // output wire [1 : 0] stat_rx_framing_err_3
  .stat_rx_framing_err_4            (stat_rx_framing_err_4          ),  // output wire [1 : 0] stat_rx_framing_err_4
  .stat_rx_framing_err_5            (stat_rx_framing_err_5          ),  // output wire [1 : 0] stat_rx_framing_err_5
  .stat_rx_framing_err_6            (stat_rx_framing_err_6          ),  // output wire [1 : 0] stat_rx_framing_err_6
  .stat_rx_framing_err_7            (stat_rx_framing_err_7          ),  // output wire [1 : 0] stat_rx_framing_err_7
  .stat_rx_framing_err_8            (stat_rx_framing_err_8          ),  // output wire [1 : 0] stat_rx_framing_err_8
  .stat_rx_framing_err_9            (stat_rx_framing_err_9          ),  // output wire [1 : 0] stat_rx_framing_err_9
  .stat_rx_framing_err_valid_0      (stat_rx_framing_err_valid_0    ),  // output wire stat_rx_framing_err_valid_0
  .stat_rx_framing_err_valid_1      (stat_rx_framing_err_valid_1    ),  // output wire stat_rx_framing_err_valid_1
  .stat_rx_framing_err_valid_10     (stat_rx_framing_err_valid_10   ),  // output wire stat_rx_framing_err_valid_10
  .stat_rx_framing_err_valid_11     (stat_rx_framing_err_valid_11   ),  // output wire stat_rx_framing_err_valid_11
  .stat_rx_framing_err_valid_12     (stat_rx_framing_err_valid_12   ),  // output wire stat_rx_framing_err_valid_12
  .stat_rx_framing_err_valid_13     (stat_rx_framing_err_valid_13   ),  // output wire stat_rx_framing_err_valid_13
  .stat_rx_framing_err_valid_14     (stat_rx_framing_err_valid_14   ),  // output wire stat_rx_framing_err_valid_14
  .stat_rx_framing_err_valid_15     (stat_rx_framing_err_valid_15   ),  // output wire stat_rx_framing_err_valid_15
  .stat_rx_framing_err_valid_16     (stat_rx_framing_err_valid_16   ),  // output wire stat_rx_framing_err_valid_16
  .stat_rx_framing_err_valid_17     (stat_rx_framing_err_valid_17   ),  // output wire stat_rx_framing_err_valid_17
  .stat_rx_framing_err_valid_18     (stat_rx_framing_err_valid_18   ),  // output wire stat_rx_framing_err_valid_18
  .stat_rx_framing_err_valid_19     (stat_rx_framing_err_valid_19   ),  // output wire stat_rx_framing_err_valid_19
  .stat_rx_framing_err_valid_2      (stat_rx_framing_err_valid_2    ),  // output wire stat_rx_framing_err_valid_2
  .stat_rx_framing_err_valid_3      (stat_rx_framing_err_valid_3    ),  // output wire stat_rx_framing_err_valid_3
  .stat_rx_framing_err_valid_4      (stat_rx_framing_err_valid_4    ),  // output wire stat_rx_framing_err_valid_4
  .stat_rx_framing_err_valid_5      (stat_rx_framing_err_valid_5    ),  // output wire stat_rx_framing_err_valid_5
  .stat_rx_framing_err_valid_6      (stat_rx_framing_err_valid_6    ),  // output wire stat_rx_framing_err_valid_6
  .stat_rx_framing_err_valid_7      (stat_rx_framing_err_valid_7    ),  // output wire stat_rx_framing_err_valid_7
  .stat_rx_framing_err_valid_8      (stat_rx_framing_err_valid_8    ),  // output wire stat_rx_framing_err_valid_8
  .stat_rx_framing_err_valid_9      (stat_rx_framing_err_valid_9    ),  // output wire stat_rx_framing_err_valid_9
  .stat_rx_got_signal_os            (stat_rx_got_signal_os          ),  // output wire stat_rx_got_signal_os
  .stat_rx_hi_ber                   (stat_rx_hi_ber                 ),  // output wire stat_rx_hi_ber
  .stat_rx_inrangeerr               (stat_rx_inrangeerr             ),  // output wire stat_rx_inrangeerr
  .stat_rx_internal_local_fault     (stat_rx_internal_local_fault   ),  // output wire stat_rx_internal_local_fault
  .stat_rx_jabber                   (stat_rx_jabber                 ),  // output wire stat_rx_jabber
  .stat_rx_local_fault              (stat_rx_local_fault            ),  // output wire stat_rx_local_fault
  .stat_rx_mf_err                   (stat_rx_mf_err                 ),  // output wire [19 : 0] stat_rx_mf_err
  .stat_rx_mf_len_err               (stat_rx_mf_len_err             ),  // output wire [19 : 0] stat_rx_mf_len_err
  .stat_rx_mf_repeat_err            (stat_rx_mf_repeat_err          ),  // output wire [19 : 0] stat_rx_mf_repeat_err
  .stat_rx_misaligned               (stat_rx_misaligned             ),  // output wire stat_rx_misaligned
  .stat_rx_multicast                (stat_rx_multicast              ),  // output wire stat_rx_multicast
  .stat_rx_oversize                 (stat_rx_oversize               ),  // output wire stat_rx_oversize
  .stat_rx_packet_1024_1518_bytes   (stat_rx_packet_1024_1518_bytes ),  // output wire stat_rx_packet_1024_1518_bytes
  .stat_rx_packet_128_255_bytes     (stat_rx_packet_128_255_bytes   ),  // output wire stat_rx_packet_128_255_bytes
  .stat_rx_packet_1519_1522_bytes   (stat_rx_packet_1519_1522_bytes ),  // output wire stat_rx_packet_1519_1522_bytes
  .stat_rx_packet_1523_1548_bytes   (stat_rx_packet_1523_1548_bytes ),  // output wire stat_rx_packet_1523_1548_bytes
  .stat_rx_packet_1549_2047_bytes   (stat_rx_packet_1549_2047_bytes ),  // output wire stat_rx_packet_1549_2047_bytes
  .stat_rx_packet_2048_4095_bytes   (stat_rx_packet_2048_4095_bytes ),  // output wire stat_rx_packet_2048_4095_bytes
  .stat_rx_packet_256_511_bytes     (stat_rx_packet_256_511_bytes   ),  // output wire stat_rx_packet_256_511_bytes
  .stat_rx_packet_4096_8191_bytes   (stat_rx_packet_4096_8191_bytes ),  // output wire stat_rx_packet_4096_8191_bytes
  .stat_rx_packet_512_1023_bytes    (stat_rx_packet_512_1023_bytes  ),  // output wire stat_rx_packet_512_1023_bytes
  .stat_rx_packet_64_bytes          (stat_rx_packet_64_bytes        ),  // output wire stat_rx_packet_64_bytes
  .stat_rx_packet_65_127_bytes      (stat_rx_packet_65_127_bytes    ),  // output wire stat_rx_packet_65_127_bytes
  .stat_rx_packet_8192_9215_bytes   (stat_rx_packet_8192_9215_bytes ),  // output wire stat_rx_packet_8192_9215_bytes
  .stat_rx_packet_bad_fcs           (stat_rx_packet_bad_fcs         ),  // output wire stat_rx_packet_bad_fcs
  .stat_rx_packet_large             (stat_rx_packet_large           ),  // output wire stat_rx_packet_large
  .stat_rx_packet_small             (stat_rx_packet_small           ),  // output wire [2 : 0] stat_rx_packet_small
  .ctl_rx_enable                    (ctl_rx_enable                  ),  // input wire ctl_rx_enable
  .ctl_rx_force_resync              (ctl_rx_force_resync            ),  // input wire ctl_rx_force_resync
  .ctl_rx_test_pattern              (ctl_rx_test_pattern            ),  // input wire ctl_rx_test_pattern
  .rx_clk                           (o_tx_clk                       ),  // input wire rx_clk
  .stat_rx_received_local_fault     (stat_rx_received_local_fault   ),  // output wire stat_rx_received_local_fault
  .stat_rx_remote_fault             (stat_rx_remote_fault           ),  // output wire stat_rx_remote_fault
  .stat_rx_status                   (o_stat_rx_status               ),  // output wire stat_rx_status
  .stat_rx_stomped_fcs              (stat_rx_stomped_fcs            ),  // output wire [2 : 0] stat_rx_stomped_fcs
  .stat_rx_synced                   (stat_rx_synced                 ),  // output wire [19 : 0] stat_rx_synced
  .stat_rx_synced_err               (stat_rx_synced_err             ),  // output wire [19 : 0] stat_rx_synced_err
  .stat_rx_test_pattern_mismatch    (stat_rx_test_pattern_mismatch  ),  // output wire [2 : 0] stat_rx_test_pattern_mismatch
  .stat_rx_toolong                  (stat_rx_toolong                ),  // output wire stat_rx_toolong
  .stat_rx_total_bytes              (stat_rx_total_bytes            ),  // output wire [6 : 0] stat_rx_total_bytes
  .stat_rx_total_good_bytes         (stat_rx_total_good_bytes       ),  // output wire [13 : 0] stat_rx_total_good_bytes
  .stat_rx_total_good_packets       (stat_rx_total_good_packets     ),  // output wire stat_rx_total_good_packets
  .stat_rx_total_packets            (stat_rx_total_packets          ),  // output wire [2 : 0] stat_rx_total_packets
  .stat_rx_truncated                (stat_rx_truncated              ),  // output wire stat_rx_truncated
  .stat_rx_undersize                (stat_rx_undersize              ),  // output wire [2 : 0] stat_rx_undersize
  .stat_rx_unicast                  (stat_rx_unicast                ),  // output wire stat_rx_unicast
  .stat_rx_vlan                     (stat_rx_vlan                   ),  // output wire stat_rx_vlan
  .stat_rx_pcsl_demuxed             (stat_rx_pcsl_demuxed           ),  // output wire [19 : 0] stat_rx_pcsl_demuxed
  .stat_rx_pcsl_number_0            (stat_rx_pcsl_number_0          ),  // output wire [4 : 0] stat_rx_pcsl_number_0
  .stat_rx_pcsl_number_1            (stat_rx_pcsl_number_1          ),  // output wire [4 : 0] stat_rx_pcsl_number_1
  .stat_rx_pcsl_number_10           (stat_rx_pcsl_number_10         ),  // output wire [4 : 0] stat_rx_pcsl_number_10
  .stat_rx_pcsl_number_11           (stat_rx_pcsl_number_11         ),  // output wire [4 : 0] stat_rx_pcsl_number_11
  .stat_rx_pcsl_number_12           (stat_rx_pcsl_number_12         ),  // output wire [4 : 0] stat_rx_pcsl_number_12
  .stat_rx_pcsl_number_13           (stat_rx_pcsl_number_13         ),  // output wire [4 : 0] stat_rx_pcsl_number_13
  .stat_rx_pcsl_number_14           (stat_rx_pcsl_number_14         ),  // output wire [4 : 0] stat_rx_pcsl_number_14
  .stat_rx_pcsl_number_15           (stat_rx_pcsl_number_15         ),  // output wire [4 : 0] stat_rx_pcsl_number_15
  .stat_rx_pcsl_number_16           (stat_rx_pcsl_number_16         ),  // output wire [4 : 0] stat_rx_pcsl_number_16
  .stat_rx_pcsl_number_17           (stat_rx_pcsl_number_17         ),  // output wire [4 : 0] stat_rx_pcsl_number_17
  .stat_rx_pcsl_number_18           (stat_rx_pcsl_number_18         ),  // output wire [4 : 0] stat_rx_pcsl_number_18
  .stat_rx_pcsl_number_19           (stat_rx_pcsl_number_19         ),  // output wire [4 : 0] stat_rx_pcsl_number_19
  .stat_rx_pcsl_number_2            (stat_rx_pcsl_number_2          ),  // output wire [4 : 0] stat_rx_pcsl_number_2
  .stat_rx_pcsl_number_3            (stat_rx_pcsl_number_3          ),  // output wire [4 : 0] stat_rx_pcsl_number_3
  .stat_rx_pcsl_number_4            (stat_rx_pcsl_number_4          ),  // output wire [4 : 0] stat_rx_pcsl_number_4
  .stat_rx_pcsl_number_5            (stat_rx_pcsl_number_5          ),  // output wire [4 : 0] stat_rx_pcsl_number_5
  .stat_rx_pcsl_number_6            (stat_rx_pcsl_number_6          ),  // output wire [4 : 0] stat_rx_pcsl_number_6
  .stat_rx_pcsl_number_7            (stat_rx_pcsl_number_7          ),  // output wire [4 : 0] stat_rx_pcsl_number_7
  .stat_rx_pcsl_number_8            (stat_rx_pcsl_number_8          ),  // output wire [4 : 0] stat_rx_pcsl_number_8
  .stat_rx_pcsl_number_9            (stat_rx_pcsl_number_9          ),  // output wire [4 : 0] stat_rx_pcsl_number_9
  .stat_tx_bad_fcs                  (stat_tx_bad_fcs                ),  // output wire stat_tx_bad_fcs
  .stat_tx_broadcast                (stat_tx_broadcast              ),  // output wire stat_tx_broadcast
  .stat_tx_frame_error              (stat_tx_frame_error            ),  // output wire stat_tx_frame_error
  .stat_tx_local_fault              (stat_tx_local_fault            ),  // output wire stat_tx_local_fault
  .stat_tx_multicast                (stat_tx_multicast              ),  // output wire stat_tx_multicast
  .stat_tx_packet_1024_1518_bytes   (stat_tx_packet_1024_1518_bytes ),  // output wire stat_tx_packet_1024_1518_bytes
  .stat_tx_packet_128_255_bytes     (stat_tx_packet_128_255_bytes   ),  // output wire stat_tx_packet_128_255_bytes
  .stat_tx_packet_1519_1522_bytes   (stat_tx_packet_1519_1522_bytes ),  // output wire stat_tx_packet_1519_1522_bytes
  .stat_tx_packet_1523_1548_bytes   (stat_tx_packet_1523_1548_bytes ),  // output wire stat_tx_packet_1523_1548_bytes
  .stat_tx_packet_1549_2047_bytes   (stat_tx_packet_1549_2047_bytes ),  // output wire stat_tx_packet_1549_2047_bytes
  .stat_tx_packet_2048_4095_bytes   (stat_tx_packet_2048_4095_bytes ),  // output wire stat_tx_packet_2048_4095_bytes
  .stat_tx_packet_256_511_bytes     (stat_tx_packet_256_511_bytes   ),  // output wire stat_tx_packet_256_511_bytes
  .stat_tx_packet_4096_8191_bytes   (stat_tx_packet_4096_8191_bytes ),  // output wire stat_tx_packet_4096_8191_bytes
  .stat_tx_packet_512_1023_bytes    (stat_tx_packet_512_1023_bytes  ),  // output wire stat_tx_packet_512_1023_bytes
  .stat_tx_packet_64_bytes          (stat_tx_packet_64_bytes        ),  // output wire stat_tx_packet_64_bytes
  .stat_tx_packet_65_127_bytes      (stat_tx_packet_65_127_bytes    ),  // output wire stat_tx_packet_65_127_bytes
  .stat_tx_packet_8192_9215_bytes   (stat_tx_packet_8192_9215_bytes ),  // output wire stat_tx_packet_8192_9215_bytes
  .stat_tx_packet_large             (stat_tx_packet_large           ),  // output wire stat_tx_packet_large
  .stat_tx_packet_small             (stat_tx_packet_small           ),  // output wire stat_tx_packet_small
  .stat_tx_total_bytes              (stat_tx_total_bytes            ),  // output wire [5 : 0] stat_tx_total_bytes
  .stat_tx_total_good_bytes         (stat_tx_total_good_bytes       ),  // output wire [13 : 0] stat_tx_total_good_bytes
  .stat_tx_total_good_packets       (stat_tx_total_good_packets     ),  // output wire stat_tx_total_good_packets
  .stat_tx_total_packets            (stat_tx_total_packets          ),  // output wire stat_tx_total_packets
  .stat_tx_unicast                  (stat_tx_unicast                ),  // output wire stat_tx_unicast
  .stat_tx_vlan                     (stat_tx_vlan                   ),  // output wire stat_tx_vlan
  .ctl_tx_enable                    (ctl_tx_enable                  ),  // input wire ctl_tx_enable
  .ctl_tx_send_idle                 (ctl_tx_send_idle               ),  // input wire ctl_tx_send_idle
  .ctl_tx_send_rfi                  (ctl_tx_send_rfi                ),  // input wire ctl_tx_send_rfi
  .ctl_tx_send_lfi                  (ctl_tx_send_lfi                ),  // input wire ctl_tx_send_lfi
  .ctl_tx_test_pattern              (ctl_tx_test_pattern            ),  // input wire ctl_tx_test_pattern
  .tx_axis_tready                   (tx_axis_tready                 ),  // output wire tx_axis_tready
  .tx_axis_tvalid                   (tx_axis_tvalid                 ),  // input wire tx_axis_tvalid
  .tx_axis_tdata                    (tx_axis_tdata                  ),  // input wire [511 : 0] tx_axis_tdata
  .tx_axis_tlast                    (tx_axis_tlast                  ),  // input wire tx_axis_tlast
  .tx_axis_tkeep                    (tx_axis_tkeep                  ),  // input wire [63 : 0] tx_axis_tkeep
  .tx_axis_tuser                    (tx_axis_tuser                  ),  // input wire tx_axis_tuser
  .tx_ovfout                        (tx_ovfout                      ),  // output wire tx_ovfout
  .tx_unfout                        (tx_unfout                      ),  // output wire tx_unfout
  .tx_preamblein                    (tx_preamblein                  ),  // input wire [55 : 0] tx_preamblein
  .tx_reset_done                    (w_tx_reset_done                ),  // input wire tx_reset_done
  .rx_reset_done                    (w_rx_reset_done                ),  // input wire rx_reset_done
  .rx_serdes_reset_done             (w_rx_serdes_reset_done         ),  // input wire [9 : 0] rx_serdes_reset_done
  .gt_reset_tx_done_out             (w_gt_reset_tx_done_out         ),  // output wire gt_reset_tx_done_out
  .gt_reset_rx_done_out             (w_gt_reset_rx_done_out         ),  // output wire gt_reset_rx_done_out
  .rx_serdes_clk                    (w_rx_serdes_clk                ),  // output wire [9 : 0] rx_serdes_clk
  .qpll0clk_in                      (w_qpll0clk_in                  ),  // input wire [3 : 0] qpll0clk_in
  .qpll0refclk_in                   (w_qpll0refclk_in               ),  // input wire [3 : 0] qpll0refclk_in
  .qpll1clk_in                      (w_qpll1clk_in                  ),  // input wire [3 : 0] qpll1clk_in
  .qpll1refclk_in                   (w_qpll1refclk_in               ),  // input wire [3 : 0] qpll1refclk_in
  .gtwiz_reset_qpll0lock_in         (i_qpll0lock                    ),  // input wire [0 : 0] gtwiz_reset_qpll0lock_in
  .gtwiz_reset_qpll0reset_out       (o_qpll0reset                   ),  // output wire [0 : 0] gtwiz_reset_qpll0reset_out
  .drp_clk                          ('d0), // input wire drp_clk
  .drp_addr                         ('d0), // input wire [9 : 0] drp_addr
  .drp_di                           ('d0), // input wire [15 : 0] drp_di
  .drp_en                           ('d0), // input wire drp_en
  .drp_do                           (),    // output wire [15 : 0] drp_do
  .drp_rdy                          (),    // output wire drp_rdy
  .drp_we                           ('d0)  // input wire drp_we
);

assign w_gt_loopback_in              = {4{3'b000}};
assign w_gtwiz_reset_tx_datapath    = 1'b0;
assign w_gtwiz_reset_rx_datapath    = 1'b0;
assign tx_preamblein                = {7{8'h55}};
assign w_qpll0clk_in                = {4{i_qpll0outclk   }};
assign w_qpll0refclk_in             = {4{i_qpll0outrefclk}};
assign w_qpll1clk_in                = 4'b0;
assign w_qpll1refclk_in             = 4'b0;

assign ctl_rx_enable                = 1'b1;
assign ctl_rx_force_resync          = 1'b0;
assign ctl_rx_test_pattern          = 1'b0;

assign ctl_tx_enable                = 1'b1;
assign ctl_tx_send_idle             = 1'b0;
assign ctl_tx_send_rfi              = 1'b0;
assign ctl_tx_send_lfi              = 1'b0;
assign ctl_tx_test_pattern          = 1'b0;

assign o_gt_powergood               = &w_gt_powergoodout;



endmodule
