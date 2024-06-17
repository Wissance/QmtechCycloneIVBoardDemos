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
wire [7:0] data;
wire cmd_decode_success;
wire [7:0] r0, r1, r2, r3, r4, r5, r6, r7;
reg push;
reg [7:0] in_data;
reg [31:0] counter;

fifo #(.DATA_WIDTH(8), .FIFO_SIZE(16)) data_storage(.clear(rst), .clk(clk), 
                                                    .push(push), .pop(cmd_read_clk),
                                                    .in_data(in_data), .out_data(data));

serial_cmd_decoder decoder(.rst(rst), .clk(clk), .cmd_ready(cmd_ready), .data(data),
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
    in_data <= 0;
    cmd_ready <= 1'b0;
    #100
    rst <= 1'b1;
    #100
    rst <= 1'b0;
end

always
begin
    #10 clk <= ~clk; // 50 MHz
    counter <= counter + 1;
    // 1.1 init valid cmd
    // SOF=0xFF
    if (counter == 2 * 16)
    begin
        in_data <= 255;
    end
    if (counter == 2 * 20)
    begin
        push <= 1'b1;
    end
    if (counter == 2 * 24)
    begin
        push <= 1'b0;
    end

    // SOF=0xFF
    if (counter == 2 * 28)
    begin
        in_data <= 255;
    end
    if (counter == 2 * 32)
    begin
        push <= 1'b1;
    end
    if (counter == 2 * 36)
    begin
        push <= 1'b0;
    end

    // SPACE=0x00
    if (counter == 2 * 40)
    begin
        in_data <= 0;
    end
    if (counter == 2 * 44)
    begin
        push <= 1'b1;
    end
    if (counter == 2 * 48)
    begin
        push <= 1'b0;
    end

    // PAYLOAD_LEN=0x06
    if (counter == 2 * 52)
    begin
        in_data <= 6;
    end
    if (counter == 2 * 56)
    begin
        push <= 1'b1;
    end
    if (counter == 2 * 60)
    begin
        push <= 1'b0;
    end

    // PAYLOAD_BYTE 0
    if (counter == 2 * 64)
    begin
        in_data <= 1;
    end
    if (counter == 2 * 68)
    begin
        push <= 1'b1;
    end
    if (counter == 2 * 72)
    begin
        push <= 1'b0;
    end

    // PAYLOAD_BYTE 1
    if (counter == 2 * 76)
    begin
        in_data <= 3;
    end
    if (counter == 2 * 80)
    begin
        push <= 1'b1;
    end
    if (counter == 2 * 84)
    begin
        push <= 1'b0;
    end

    // PAYLOAD_BYTE 2
    if (counter == 2 * 88)
    begin
        in_data <= 11;
    end
    if (counter == 2 * 92)
    begin
        push <= 1'b1;
    end
    if (counter == 2 * 96)
    begin
        push <= 1'b0;
    end

    // PAYLOAD_BYTE 3
    if (counter == 2 * 100)
    begin
        in_data <= 22;
    end
    if (counter == 2 * 104)
    begin
        push <= 1'b1;
    end
    if (counter == 2 * 108)
    begin
        push <= 1'b0;
    end

    // PAYLOAD_BYTE 4
    if (counter == 2 * 112)
    begin
        in_data <= 33;
    end
    if (counter == 2 * 116)
    begin
        push <= 1'b1;
    end
    if (counter == 2 * 120)
    begin
        push <= 1'b0;
    end

    // PAYLOAD_BYTE 5
    if (counter == 2 * 124)
    begin
        in_data <= 33;
    end
    if (counter == 2 * 128)
    begin
        push <= 1'b1;
    end
    if (counter == 2 * 132)
    begin
        push <= 1'b0;
    end

    // EOF=0xEE
    if (counter == 2 * 136)
    begin
        in_data <= 238;
    end
    if (counter == 2 * 140)
    begin
        push <= 1'b1;
    end
    if (counter == 2 * 144)
    begin
        push <= 1'b0;
    end

    // EOF=0xEE
    if (counter == 2 * 148)
    begin
        in_data <= 238;
    end
    if (counter == 2 * 152)
    begin
        push <= 1'b1;
    end
    if (counter == 2 * 156)
    begin
        push <= 1'b0;
    end

    // 1.2 start decode
    // 1.2.1 notify that we've received command
    if (counter == 2 * 160)
    begin
        cmd_ready <= 1'b1;
    end
    // 1.2.2 notify that we've received command
    if (counter == 2 * 170)
    begin
        cmd_ready <= 1'b0;
    end

    // 1.3 check regs r0-r7 + decode success
    // 2.1 init another valid cmd
    // 2.2 start decode
    // 2.3 check regs r0-r7 + decode success
    // 3.1 init invalid cmd by format sof missing
    // 3.2 start decode
    // 3.3 check decode fails
    // 3.4 cleanup fifo
    // 4.1 init invalid cmd by format space missing
    // 4.2 start decode
    // 4.3 check decode fails
    // 4.4 cleanup fifo
    // 5.1 init invalid cmd by more data than decoder could process (> .MAX_CMD_PAYLOAD_BYTES)
    // 5.2 start decode
    // 5.3 check decode fails
    // 5.4 cleanup fifo
    // 6.1 init invalid cmd by format eof missing
    // 6.2 start decode
    // 6.3 check decode fails
    // 6.4 cleanup fifo
end

endmodule
