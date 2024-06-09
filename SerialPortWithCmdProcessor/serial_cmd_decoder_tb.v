`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:             Wissance (https://wissance.com)
// Engineer:            EvilLord666 (Ushakov MV - https://github.com/EvilLord666)
// 
// Create Date:         29.06.2023 
// Design Name:         SerialPortEcho
// Design Name:         SerialCmdProcessor
// Module Name:         serial_cmd_decoder_tb
// Project Name:        SerialCmdProcessor
// Target Devices:      QMTECH CycloneIV Core Board (EP4CE15F23C8N)
// Tool versions:       Quartus Prime Lite 18.1
// Description:         A Testbench for testing serial_cmd_decoder
//
// Dependencies:        Depends on serial_cmd_decoder && fifo (lib/fifo)
//
// Revision:            1.0
// Additional Comments: A minimal set of tests
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


module serial_cmd_decoder_tb();

reg  clk;
reg  rst;
reg  cmd_ready;
reg  cmd_processed_received;
wire cmd_read_clk;
wire cmd_processed;
wire [7:0] cmd_bytes_processed;
wire cmd_decode_success;
wire [7:0] r0, r1, r2, r3, r4, r5, r6, r7;
reg push;
reg [31:0] counter;

fifo #(.DATA_WIDTH(8), .FIFO_SIZE(16)) data_storage(.clear(rst), .clk(clk), 
                                                    .push(push), .pop(cmd_read_clk),
                                                    .in_data(),  .out_data());

serial_cmd_decoder decoder(.rst(rst), .clk(clk), .cmd_ready(cmd_ready), 
                           .cmd_processed_received(cmd_processed_received),
                           .cmd_read_clk(cmd_read_clk), .cmd_processed(cmd_processed),
                           .cmd_bytes_processed(cmd_bytes_processed), .cmd_decode_success(cmd_decode_success),
                           .cmd_payload_r0(r0), .cmd_payload_r1(r1),  .cmd_payload_r2(r2),
                           .cmd_payload_r3(r3), .cmd_payload_r4(r4),  .cmd_payload_r5(r5),
                           .cmd_payload_r6(r6), .cmd_payload_r7(r7));

initial
begin
    clk <= 1'b0;
    rst <= 1'b0;
    counter <= 0;
    push <= 1'b0;
    #200
    rst <= 1'b1;
    #200
    rst <= 1'b0;
end

always
begin
    #10 clk <= ~clk; // 50 MHz
    counter <= counter + 1;
end




endmodule
