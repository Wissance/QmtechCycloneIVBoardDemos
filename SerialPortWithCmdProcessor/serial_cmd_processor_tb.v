`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:             Wissance (https://wissance.com)
// Engineer:            EvilLord666 (Ushakov MV - https://github.com/EvilLord666)
// 
// Create Date:         29.06.2023 
// Design Name:         SerialCmdProcessor
// Module Name:         serial_cmd_decoder_tb
// Project Name:        SerialCmdProcessor
// Target Devices:      QMTECH CycloneIV Core Board (EP4CE15F23C8N)
// Tool versions:       Quartus Prime Lite 18.1
// Description:         A Testbench for testing serial_cmd_processor
//
// Dependencies:        Depends on serial_cmd_processor
//
// Revision:            1.0
// Additional Comments: A minimal set of tests
//
//////////////////////////////////////////////////////////////////////////////////

module serial_cmd_processor_tb();

reg  clk;
reg  rx;
wire tx;
reg  rts;
wire cts;
reg  [31:0] counter;

serial_cmd_processor tty0(.clk(clk), .rx(rx), .tx(tx), .rts(rts), .cts(cts));

initial
begin
    counter <= 0;
    rx <= 1'b1;
    clk <= 1'b0;
end

always
begin
    #10 clk <= ~clk; // 50 MHz
    counter <= counter + 1;
    // 1. Send command 0xFF 0xFF 0x00 0x02 0x02 0x03 0xEE 0xEE (Read Reg 3)
    // 1.1 First  SOF byte - 0xFF
    // 1.2 Second SOF byte - 0xFF
    // 1.3 Space byte - 0x00
    // 1.4 Payload len byte - 0x02
    // 1.5 Payload bytes - 0x02 0x03
    // 1.6 First  EOF byte - 0xEE
    // 1.6 Second EOF byte - 0xEE
end

endmodule
