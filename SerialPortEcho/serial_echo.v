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
    output wire tx,                                      // tx  - transmit (1 bit line for transmit data)
    input wire rts,                                      // rts - request to send PC sets rts == 1'b1 that indicates that there is a data for receive
    output wire cts                                      // cts - 
);

localparam reg [3:0] DEFAULT_PROCESSES_DELAY_CYCLES = 10;

localparam reg [3:0] SERIAL_INPUT_AWAIT_STATE = 0;
localparam reg [3:0] SERIAL_INPUT_DATA_RECEIVED_STATE = 1;
localparam reg [3:0] SERIAL_INPUT_DATA_CLR_STATE = 2;
localparam reg [3:0] SERIAL_INPUT_DATA_PROCESSING_STATE = 3;
localparam reg [3:0] SERIAL_OUTPUT_DATA_READY_STATE = 4;
localparam reg [3:0] SERIAL_OUTPUT_DATA_SEND_STATE = 5;
localparam reg [3:0] SERIAL_OUTPUT_DATA_CLR_STATE = 6;
localparam reg [3:0] SERIAL_OUTPUT_DATA_FIN_STATE = 7;

reg  rx_read;
wire rx_err;
wire [7:0] rx_data;
wire rx_byte_received;
reg  tx_transaction;
reg  [7:0] tx_data;
reg  tx_data_ready;
wire tx_data_copied;
wire tx_busy;
reg  [7:0] data_buffer;
reg  process_data;
reg [3:0] serial_data_exchange_state;
reg [3:0] delay_counter;

quick_rs232 #(.CLK_FREQ(50000000), .DEFAULT_BYTE_LEN(8), .DEFAULT_PARITY(1), .DEFAULT_STOP_BITS(0),
              .DEFAULT_BAUD_RATE(115200), .DEFAULT_RECV_BUFFER_LEN(16), .DEFAULT_FLOW_CONTROL(0)) 
serial_dev (.clk(clk), .rst(rst), .rx(rx), .tx(tx), .rts(rts), .cts(cts),
            .rx_read(rx_read), .rx_err(rx_err), .rx_data(rx_data), .rx_byte_received(rx_byte_received),
            .tx_transaction(tx_transaction), .tx_data(tx_data), .tx_data_ready(tx_data_ready), 
            .tx_data_copied(tx_data_copied), .tx_busy(tx_busy));

//todo(UMV): add global board reset ....
            
always @(posedge clk)
begin
    if (rst)
    begin
        tx_transaction <= 1'b0;
        rx_read <= 1'b0;
        tx_data <= 0;
        tx_data_ready <= 1'b0;
        serial_data_exchange_state <= SERIAL_INPUT_AWAIT_STATE;
        delay_counter <= 0;
        data_buffer <= 0;
    end
    else
    begin
        case (serial_data_exchange_state)
            SERIAL_INPUT_AWAIT_STATE:
            begin
                // this is not very reliable to await level, but this is only demo therefore it has rights to be here
                if(rx_byte_received)
                begin
                    serial_data_exchange_state <= SERIAL_INPUT_DATA_RECEIVED_STATE;
                    delay_counter <= 0;
                end
            end
            SERIAL_INPUT_DATA_RECEIVED_STATE:
            begin
                rx_read <= 1'b1;
                delay_counter <= delay_counter + 1;
                if (delay_counter == DEFAULT_PROCESSES_DELAY_CYCLES)
                begin
                    data_buffer <= rx_data + 1;
                    delay_counter <= 0;
                    serial_data_exchange_state <= SERIAL_INPUT_DATA_CLR_STATE;
                end
            end
            SERIAL_INPUT_DATA_CLR_STATE:
            begin
                if(~rx_byte_received)
                begin
                    serial_data_exchange_state <= SERIAL_INPUT_DATA_PROCESSING_STATE;
                    rx_read <= 1'b0;
                end
            end
            SERIAL_INPUT_DATA_PROCESSING_STATE:
            begin
                tx_transaction <= 1'b1;
                serial_data_exchange_state <= SERIAL_OUTPUT_DATA_READY_STATE;
            end
            SERIAL_OUTPUT_DATA_READY_STATE:
            begin
                delay_counter <= delay_counter + 1;
                tx_data <= data_buffer;
                if (delay_counter == DEFAULT_PROCESSES_DELAY_CYCLES)
                begin
                    delay_counter <= 0;
                    serial_data_exchange_state <= SERIAL_OUTPUT_DATA_SEND_STATE;
                end
            end
            SERIAL_OUTPUT_DATA_SEND_STATE:
            begin
                if (tx_busy == 1'b0)
                begin
                    tx_data_ready <= 1'b1;
                    serial_data_exchange_state <= SERIAL_OUTPUT_DATA_CLR_STATE;
                end
            end
            SERIAL_OUTPUT_DATA_CLR_STATE:
            begin
                delay_counter <= delay_counter + 1;
                if (delay_counter == DEFAULT_PROCESSES_DELAY_CYCLES)
                begin
                    delay_counter <= 0;
                    tx_data_ready <= 1'b1;
                    serial_data_exchange_state <= SERIAL_OUTPUT_DATA_FIN_STATE;
                end
            end
            SERIAL_OUTPUT_DATA_FIN_STATE:
            begin
                delay_counter <= delay_counter + 1;
                if (delay_counter == DEFAULT_PROCESSES_DELAY_CYCLES)
                begin
                    delay_counter <= 0;
                    tx_transaction <= 1'b0;
                    serial_data_exchange_state <= SERIAL_INPUT_AWAIT_STATE;
                end
            end
        endcase
    end
    
end

endmodule
