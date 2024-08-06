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
    // 1.2 Second SOF byte - 0xFF
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
    // 1.3 Space byte - 0x00
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
    // 1.4 Payload len byte - 0x02
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
    // 1.5 Payload bytes - 0x02 0x03
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
    // 1.6 First  EOF byte - 0xEE
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
    // 1.7 Second EOF byte - 0xEE
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
end

endmodule
