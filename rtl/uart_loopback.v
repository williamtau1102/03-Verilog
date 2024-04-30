//****************************************Copyright (c)***********************************//
//ԭ�Ӹ����߽�ѧƽ̨��www.yuanzige.com
//����֧�֣�http://www.openedv.com/forum.php
//�Ա����̣�https://zhengdianyuanzi.tmall.com
//��ע΢�Ź���ƽ̨΢�źţ�"����ԭ��"����ѻ�ȡZYNQ & FPGA & STM32 & LINUX���ϡ�
//��Ȩ���У�����ؾ���
//Copyright(C) ����ԭ�� 2023-2033
//All rights reserved                                  
//----------------------------------------------------------------------------------------
// File name:           uart_loopback
// Created by:          ����ԭ��
// Created date:        2023��2��16��14:20:02
// Version:             V1.0
// Descriptions:        ���ڻػ�ʵ��
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module uart_loopback(
    input            sys_clk  ,   //�ⲿ50MHzʱ��
    input            sys_rst_n,   //ϵ�ⲿ��λ�źţ�����Ч
    
    //UART�˿�    
    input            uart_rxd ,   //UART���ն˿�
    output           uart_txd     //UART���Ͷ˿�
    );

//parameter define
parameter CLK_FREQ = 50000000;    //����ϵͳʱ��Ƶ��
parameter UART_BPS = 115200  ;    //���崮�ڲ�����

//wire define
wire         uart_rx_done;    //UART��������ź�
wire  [7:0]  uart_rx_data;    //UART��������

//*****************************************************
//**                    main code
//*****************************************************

//���ڽ���ģ��
uart_rx #(
    .CLK_FREQ  (CLK_FREQ),
    .UART_BPS  (UART_BPS)
    )    
    u_uart_rx(
    .clk           (sys_clk     ),
    .rst_n         (sys_rst_n   ),
    .uart_rxd      (uart_rxd    ),
    .uart_rx_done  (uart_rx_done),
    .uart_rx_data  (uart_rx_data)
    );

//���ڷ���ģ��
uart_tx #(
    .CLK_FREQ  (CLK_FREQ),
    .UART_BPS  (UART_BPS)
    )    
    u_uart_tx(
    .clk          (sys_clk     ),
    .rst_n        (sys_rst_n   ),
    .uart_tx_en   (uart_rx_done),
    .uart_tx_data (uart_rx_data),
    .uart_txd     (uart_txd    ),
    .uart_tx_busy (            )
    );
    
endmodule
