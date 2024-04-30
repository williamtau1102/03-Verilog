`timescale  1ns/1ns   //����ĵ�λ/����ľ���

module tb_uart_loopback();

//parameter define
parameter  CLK_PERIOD = 20;//ʱ������Ϊ20ns

//reg define
reg            sys_clk  ;  //ʱ���ź�
reg            sys_rst_n;  //��λ�ź�
reg            uart_rxd ;  //UART���ն˿�

//wire define
wire           uart_txd ;  //UART���Ͷ˿�

//*****************************************************
//**                    main code
//*****************************************************

//����8'h55  8'b0101_0101
initial begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b0;
    uart_rxd <= 1'b1;
    #200
    sys_rst_n <= 1'b1;  
    #1000
    uart_rxd <= 1'b0;   //��ʼλ
    #8680
    uart_rxd <= 1'b1;   //D0
    #8680
    uart_rxd <= 1'b0;   //D1
    #8680
    uart_rxd <= 1'b1;   //D2
    #8680
    uart_rxd <= 1'b0;   //D3
    #8680
    uart_rxd <= 1'b1;   //D4
    #8680
    uart_rxd <= 1'b0;   //D5
    #8680
    uart_rxd <= 1'b1;   //D6
    #8680
    uart_rxd <= 1'b0;   //D7 
    #8680
    uart_rxd <= 1'b1;   //ֹͣλ
    #8680
    uart_rxd <= 1'b1;   //����״̬   
end

//50Mhz��ʱ�ӣ�������Ϊ1/50Mhz=20ns,����ÿ10ns����ƽȡ��һ��
always #(CLK_PERIOD/2) sys_clk = ~sys_clk;

//��������ģ��
uart_loopback  u_uart_loopback(
    .sys_clk      (sys_clk  ), 
    .sys_rst_n    (sys_rst_n),
    .uart_rxd     (uart_rxd ),
    .uart_txd     (uart_txd )
    );

endmodule