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

localparam reg[31:0] RS232_BIT_TICKS = 50000000 / 115200; // == 434

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
    // start bit
    if (counter == 100)
    begin
        rx <= 1'b0; 
    end
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
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 4 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 5 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b5
    if (counter == 2 * 6 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 7 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 8 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 9 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 10 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // 1.2 Second SOF byte - 0xFF
    // start bit
    if (counter == 2 * 12 * RS232_BIT_TICKS + 100)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 13 * RS232_BIT_TICKS + 100)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 14 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 15 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 16 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 17 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b5
    if (counter == 2 * 18 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 19 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 20 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 21 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 22 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // 1.3 Space byte - 0x00
    // start bit
    if (counter == 2 * 24 * RS232_BIT_TICKS + 100)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 25 * RS232_BIT_TICKS + 100)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 26 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b2
    if (counter == 2 * 27 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 28 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 29 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 30 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 30 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 31 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 32 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 33 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // 1.4 Payload len byte - 0x02
    // start bit
    if (counter == 2 * 35 * RS232_BIT_TICKS + 100)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 36 * RS232_BIT_TICKS + 100)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 37 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 38 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 39 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 40 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 41 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 42 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 43 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 44 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // stop bit
    if (counter == 2 * 45 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // 1.5 Payload bytes - 0x02 0x03
    // 0x02
    // start bit
    if (counter == 2 * 47 * RS232_BIT_TICKS + 100)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 48 * RS232_BIT_TICKS + 100)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 49 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 50 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 51 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 52 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 53 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 54 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 55 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 56 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // stop bit
    if (counter == 2 * 57 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end

    // 0x03
    // start bit
    if (counter == 2 * 59 * RS232_BIT_TICKS + 100)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 60 * RS232_BIT_TICKS + 100)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 61 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 62 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 63 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 64 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 65 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 66 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 67 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 68 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 69 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // 1.6 First  EOF byte - 0xEE
    // start bit
    if (counter == 2 * 71 * RS232_BIT_TICKS + 100)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 72 * RS232_BIT_TICKS + 100)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 73 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 74 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 75 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 76 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 77 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 78 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 79 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 80 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 81 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // 1.7 Second EOF byte - 0xEE
    // start bit
    if (counter == 2 * 83 * RS232_BIT_TICKS + 100)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 84 * RS232_BIT_TICKS + 100)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 85 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 86 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 87 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 88 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 89 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 90 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 91 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 92 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 93 * RS232_BIT_TICKS + 100)
    begin
       rx <= 1'b1;
    end
end

endmodule
