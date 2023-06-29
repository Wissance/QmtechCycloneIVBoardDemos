//////////////////////////////////////////////////////////////////////////////////
// Company:             Wissance (https://wissance.com)
// Engineer:            EvilLord666 (Ushakov MV - https://github.com/EvilLord666)
// 
// Create Date:         29.06.2023 
// Design Name:         SerialPortEcho
// Module Name:         serial_echo
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

module serial_echo(
    // Global Signals
    input wire clk,                                      // clk is a clock 
    input wire rst,                                      // rst is a global reset system
    // External RS232 Interface
    input wire rx,                                       // rx  - receive  (1 bit line for receive data)
    output reg tx,                                       // tx  - transmit (1 bit line for transmit data)
    input wire rts,                                      // rts - request to send PC sets rts == 1'b1 that indicates that there is a data for receive
    output reg cts
);

always @(posedge clk)
begin
end
endmodule
