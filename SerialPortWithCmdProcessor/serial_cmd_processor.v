//////////////////////////////////////////////////////////////////////////////////
// Company:             Wissance (https://wissance.com)
// Engineer:            EvilLord666 (Ushakov MV - https://github.com/EvilLord666)
// 
// Create Date:         09.03.2024
// Design Name:         SerialCmdProcessor
// Module Name:         serial_cmd_processor
// Project Name:        SerialCmdProcessor
// Target Devices:      QMTECH CycloneIV Core Board (EP4CE15F23C8N)
// Tool versions:       Quartus Prime Lite 18.1
// Description:         A hardware Serial Cmd Processor: RS232 Cmd to Read and Write Specific internal Register
//
// Dependencies:        Depends on QuickRS232 sources (quick_rs232 && fifo modules), https://github.com/Wissance/QuickRS232
//
// Revision:            1.0
// Additional Comments: Actualy we are testing here 1 mode: (115200 bod/s, 1 stop bit, even parity, no flow control)
//
//////////////////////////////////////////////////////////////////////////////////

module serial_cmd_processor(
    // Global Signals
    input  wire clk,                                     // clk is a clock 
    // input wire rst,                                      // rst is a global reset system
    // External RS232 Interface
    input  wire rx,                                      // rx  - receive  (1 bit line for receive data)
    output wire tx,                                      // tx  - transmit (1 bit line for transmit data)
    input  wire rts,                                     // rts - request to send PC sets rts == 1'b1 that indicates that there is a data for receive
    output wire cts,                                     // cts - clear to send
    output wire rx_led,                                  // rx_led - receive indicator
    output wire tx_led,                                  // tx_led - transmission indicator
    output reg  [7:0] led_bus                            // for debug only
);

localparam reg [3:0] DEFAULT_PROCESSES_DELAY_CYCLES = 10;
localparam reg [4:0] RST_DELAY_CYCLES = 20;

reg  rst = 1'b0;
reg  rst_generated = 1'b0;
reg  [7:0] rst_counter;

//this always implements the global reset that board generates at start
always @(posedge clk)
begin
    if (rst_generated != 1'b1)
    begin
        if (rst != 1'b1)
        begin
            rst <= 1'b1;
            rst_counter <= 0;
        end
        else
        begin
            rst_counter <= rst_counter + 1;
            if (rst_counter == RST_DELAY_CYCLES)
            begin
                rst <= 1'b0;
                rst_generated <= 1'b1;
            end
        end
    end
end

endmodule
