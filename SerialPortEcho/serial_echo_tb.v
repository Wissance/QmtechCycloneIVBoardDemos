`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:             Wissance (https://wissance.com)
// Engineer:            EvilLord666 (Ushakov MV - https://github.com/EvilLord666)
// 
// Create Date:         29.06.2023 
// Design Name:         SerialPortEcho
// Module Name:         serial_echo_tb
// Project Name:        SerialPortEcho
// Target Devices:      QMTECH CycloneIV Core Board (EP4CE15F23C8N)
// Tool versions:       Quartus Prime Lite 18.1
// Description:         A hardware Serial Echo test: we receive bytes from RS232, increment them by 1 and sending back
//
// Dependencies:        Depends on QuickRS232 sources (quick_rs232 && fifo modules), https://github.com/Wissance/QuickRS232
//
// Revision:            1.0
// Additional Comments: Actualy we are testing here 1 mode: (115200 bod/s, 1 stop bit, even parity, no flow control)
//
//////////////////////////////////////////////////////////////////////////////////

`define ASSERT(signal, value) \
        if (signal !== value) begin \
            $display("ASSERTION FAILED in %m: expected: %b, actual is : %b", value, signal); \
            $finish; \
        end \
        else \
        begin \
            $display("ASSERTION SUCCEDED"); \
        end \


module serial_echo_tb();

reg clk;
reg rst;
reg rx;
wire tx;
reg rts;
wire cts;

reg [31:0] counter;

localparam reg[31:0] RS232_BIT_TICKS = 50000000 / 115200; // == 434

serial_echo tty (.clk(clk), .rst(rst), .rx(rx), .tx(tx), .rts(rts), .cts(cts));

initial
begin
    clk <= 0;
    counter <= 0;
    rst <= 0;
    rx <= 1;
    rts <= 0;
    #200
    rst <= 1;
    #200
    rst <= 0;
end

always
begin
    #10 clk <= ~clk; // 50 MHz
    counter <= counter + 1;
    // 1. RX (reading byte without an error)
    // 1.1 Sending Start bit
    if (counter == 100)
    begin
        rx <= 1'b0;
    end
    // todo(UMV): wrap in a for cycle ...
    // 1.2 Sending Data bits 8'b01010011
    // b0
    if (counter == 2 * RS232_BIT_TICKS + 100)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 2 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 3 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 4 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 5 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b5
    if (counter == 2 * 6 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 7 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 8 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // 1.3 Sending Parity (even)
    if (counter == 2 * 9 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // 1.4 Sending Stop bit
    if (counter == 2 * 10 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    
end

endmodule
