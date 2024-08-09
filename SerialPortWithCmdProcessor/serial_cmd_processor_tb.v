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
localparam reg[31:0] EXCHANGE_OFFSET = 1000;

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
    if (counter == EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 1 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 2 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 3 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 4 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 5 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b5
    if (counter == 2 * 6 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 7 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 8 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 9 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 10 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 1.2 Second SOF byte - 0xFF
    // start bit
    if (counter == 2 * 11 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 12 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 13 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 14 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 15 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 16 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b5
    if (counter == 2 * 17 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 18 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 19 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 20 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 21 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 1.3 Space byte - 0x00
    // start bit
    if (counter == 2 * 22 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 23 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 24 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b2
    if (counter == 2 * 25 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 26 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 27 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 28 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 29 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 30 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 31 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 32 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 1.4 Payload len byte - 0x02
    // start bit
    if (counter == 2 * 33 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 34 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 35 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 36 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 37 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 38 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 39 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 40 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 41 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 42 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // stop bit
    if (counter == 2 * 43 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 1.5 Payload bytes - 0x02 0x03
    // 0x02
    // start bit
    if (counter == 2 * 44 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 45 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 46 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 47 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 48 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 49 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 50 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 51 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 52 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 53 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // stop bit
    if (counter == 2 * 54 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end

    // 0x03
    // start bit
    if (counter == 2 * 55 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 56 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 57 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 58 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 59 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 60 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 61 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 62 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 63 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 64 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 65 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 1.6 First  EOF byte - 0xEE
    // start bit
    if (counter == 2 * 66 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 67 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 68 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 69 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 70 * RS232_BIT_TICKS +EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 71 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 72 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 73 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 74 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 75 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 76 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 1.7 Second EOF byte - 0xEE
    // start bit
    if (counter == 2 * 77 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 78 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 79 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 80 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 81 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 82 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 83 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 84 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 85 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 86 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 87 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    
    // 2. Send command 0xFF 0xFF 0x00 0x02 0x02 0x01 0xEE 0xEE (Read Reg 1)
    // 2.1 First  SOF byte - 0xFF
    // start bit
    if (counter == 2 * 399 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 400 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 401 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 402 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 403 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 404 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b5
    if (counter == 2 * 405 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 406 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 407 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 408 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 409 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 2.2 Second SOF byte - 0xFF
    // start bit
    if (counter == 2 * 410 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 411 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 412 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 413 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 414 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 415 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b5
    if (counter == 2 * 416 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 417 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 418 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 419 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 420 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 2.3 Space byte - 0x00
    // start bit
    if (counter == 2 * 421 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 422 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 423 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b2
    if (counter == 2 * 424 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 425 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 426 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 427 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 428 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 429 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 430 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 431 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 2.4 Payload len byte - 0x02
    // start bit
    if (counter == 2 * 432 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 433 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 434 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 435 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 436 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 437 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 438 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 439 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 440 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 441 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // stop bit
    if (counter == 2 * 442 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 2.5 Payload bytes - 0x02 0x03
    // 0x02
    // start bit
    if (counter == 2 * 443 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 444 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 445 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 446 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 447 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 448 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 449 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 450 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 451 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 452 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // stop bit
    if (counter == 2 * 453 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end

    // 0x01
    // start bit
    if (counter == 2 * 454 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 455 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 456 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b2
    if (counter == 2 * 457 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 458 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 459 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 460 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 461 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 462 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 463 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // stop bit
    if (counter == 2 * 464 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 2.6 First  EOF byte - 0xEE
    // start bit
    if (counter == 2 * 465 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 466 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 467 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 468 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 469 * RS232_BIT_TICKS +EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 470 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 471 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 472 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 473 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 474 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 475 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 2.7 Second EOF byte - 0xEE
    // start bit
    if (counter == 2 * 476 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 477 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 478 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 479 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 480 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 481 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 482 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 483 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 484 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 485 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 486 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 3. Badly encoded CMD and Valid CMD after 0xFF 0xFF 0x00 0x06 0x01 0x03 0x10 0x20 0x30 0x40
    // 3.1 First  SOF byte - 0xFF
    // start bit
    if (counter == 2 * 699 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 700 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 701 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 702 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 703 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 704 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b5
    if (counter == 2 * 705 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 706 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 707 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 708 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 709 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 3.2 Second SOF byte - 0xFF
    // start bit
    if (counter == 2 * 710 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 711 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 712 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 713 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 714 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 715 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b5
    if (counter == 2 * 716 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 717 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 718 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 719 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 720 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 3.3 Space byte - 0x00
    // start bit
    if (counter == 2 * 721 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 722 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 723 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b2
    if (counter == 2 * 724 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 725 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 726 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 727 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 728 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 729 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 730 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 731 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 3.4 Payload len byte - 0x06
    // start bit
    if (counter == 2 * 732 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 733 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 734 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 735 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 736 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 737 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 738 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 739 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 740 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 741 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 742 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 3.5 Payload bytes - 0x01 0x03 0x10 0x20 0x30 0x40
    // 0x01
    // start bit
    if (counter == 2 * 743 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 744 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 745 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b2
    if (counter == 2 * 746 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 747 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 748 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 749 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 750 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 751 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 752 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // stop bit
    if (counter == 2 * 753 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end

    // 0x03
    // start bit
    if (counter == 2 * 754 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 755 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 756 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 757 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 758 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 759 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 760 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 761 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 762 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 763 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 764 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end

    // 0x10
    // start bit
    if (counter == 2 * 765 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 766 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 767 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b2
    if (counter == 2 * 768 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 769 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 770 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b5
    if (counter == 2 * 771 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 772 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 773 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 774 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // stop bit
    if (counter == 2 * 775 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end

    // 0x20
    // start bit
    if (counter == 2 * 776 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 777 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 778 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b2
    if (counter == 2 * 779 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 780 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 781 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 782 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 783 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 784 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 785 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // stop bit
    if (counter == 2 * 786 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end

    // 0x30
    // start bit
    if (counter == 2 * 787 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 788 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 789 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b2
    if (counter == 2 * 790 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 791 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 792 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b5
    if (counter == 2 * 793 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 794 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 795 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 796 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 797 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end

    // 0x40
    // start bit
    if (counter == 2 * 798 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 799 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 800 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b2
    if (counter == 2 * 801 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 802 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 803 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 804 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 805 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 806 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 807 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // stop bit
    if (counter == 2 * 808 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end

    // 4. Send command 0xFF 0xFF 0x00 0x02 0x02 0x01 0xEE 0xEE (Read Reg 1)
    // 4.1 First  SOF byte - 0xFF
    // start bit
    if (counter == 2 * 1000 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 1001 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 1002 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 1003 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 1004 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 1005 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b5
    if (counter == 2 * 1006 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 1007 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 1008 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 1009 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 1010 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 4.2 Second SOF byte - 0xFF
    // start bit
    if (counter == 2 * 1011 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 1012 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 1013 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 1014 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 1015 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 1016 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b5
    if (counter == 2 * 1017 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 1018 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 1019 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 1020 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 1021 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 4.3 Space byte - 0x00
    // start bit
    if (counter == 2 * 1022 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 1023 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 1024 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b2
    if (counter == 2 * 1025 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 1026 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 1027 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 1028 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 1029 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 1030 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 1031 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 1032 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 4.4 Payload len byte - 0x02
    // start bit
    if (counter == 2 * 1033 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 1034 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 1035 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 1036 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 1037 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 1038 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 1039 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 1040 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 1041 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 1042 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // stop bit
    if (counter == 2 * 1043 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 4.5 Payload bytes - 0x02 0x03
    // 0x02
    // start bit
    if (counter == 2 * 1044 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 1045 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 1046 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 1047 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 1048 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 1049 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 1050 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 1051 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 1052 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 1053 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // stop bit
    if (counter == 2 * 1054 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end

    // 0x01
    // start bit
    if (counter == 2 * 1055 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 1056 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b1;
    end
    // b1
    if (counter == 2 * 1057 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b2
    if (counter == 2 * 1058 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b3
    if (counter == 2 * 1059 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b4
    if (counter == 2 * 1060 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 1061 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b6
    if (counter == 2 * 1062 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b7
    if (counter == 2 * 1063 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // parity (even)
    if (counter == 2 * 1064 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // stop bit
    if (counter == 2 * 1065 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 4.6 First  EOF byte - 0xEE
    // start bit
    if (counter == 2 * 1066 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 1067 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 1068 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 1069 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 1070 * RS232_BIT_TICKS +EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 1071 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 1072 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 1073 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 1074 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 1075 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 1076 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // 4.7 Second EOF byte - 0xEE
    // start bit
    if (counter == 2 * 1077 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
        rx <= 1'b0; 
    end
    // b0
    if (counter == 2 * 1078 * RS232_BIT_TICKS + EXCHANGE_OFFSET)  // we multiply on 2 because counter changes twice a period
    begin
       rx <= 1'b0;
    end
    // b1
    if (counter == 2 * 1079 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b2
    if (counter == 2 * 1080 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b3
    if (counter == 2 * 1081 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b4
    if (counter == 2 * 1082 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // b5
    if (counter == 2 * 1083 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b6
    if (counter == 2 * 1084 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // b7
    if (counter == 2 * 1085 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
    // parity (even)
    if (counter == 2 * 1086 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b0;
    end
    // stop bit
    if (counter == 2 * 1087 * RS232_BIT_TICKS + EXCHANGE_OFFSET)
    begin
       rx <= 1'b1;
    end
end

endmodule
