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
localparam reg [3:0] RST_DELAY_CYCLES = 20;

localparam reg [3:0] SERIAL_INPUT_DATA_AWAIT_STATE = 0;
localparam reg [3:0] SERIAL_INPUT_DATA_RECEIVED_STATE = 1;
localparam reg [3:0] SERIAL_INPUT_DATA_PROCESSING_STATE = 2;
localparam reg [3:0] SERIAL_INPUT_DATA_CLR_STATE = 3;
localparam reg [3:0] SERIAL_OUTPUT_DATA_READY_STATE = 4;
localparam reg [3:0] SERIAL_OUTPUT_DATA_SEND_STATE = 5;
localparam reg [3:0] SERIAL_OUTPUT_DATA_CLR_STATE = 6;
localparam reg [3:0] SERIAL_OUTPUT_DATA_FIN_STATE = 7;

localparam reg [1:0]  BLINK_EVENT_AWAIT = 0;
localparam reg [1:0]  BLINK_ZERO_STATE = 1;
localparam reg [1:0]  BLINK_ONE_STATE = 2;
localparam reg [31:0] LED_DELAY_COUNTER = 10000000; // 200 ms for 50 MHz

reg  rst = 1'b0;
reg  rst_generated = 1'b0;
reg  [7:0] rst_counter;
reg  rx_read;
wire rx_err;
wire [7:0] rx_data;
wire rx_byte_received;
reg  tx_transaction;
reg  [7:0] tx_data;
reg  tx_data_ready;
wire tx_data_copied;
wire tx_busy;
wire has_rx_data;
reg  [7:0] data_buffer;
reg  [3:0] serial_data_exchange_state;
reg  [7:0] delay_counter;
reg  tx_blink;
reg  [1:0]  tx_blink_state;
reg  [31:0] tx_blink_counter;
reg  rx_blink;
reg  [1:0]  rx_blink_state;
reg  [31:0] rx_blink_counter;
reg  rx_data_ready_trig;
reg  [7:0] received_bytes_counter;

quick_rs232 #(.CLK_TICKS_PER_RS232_BIT(434), .DEFAULT_BYTE_LEN(8), .DEFAULT_PARITY(1), .DEFAULT_STOP_BITS(0),
              .DEFAULT_RECV_BUFFER_LEN(16), .DEFAULT_FLOW_CONTROL(0)) 
serial_dev (.clk(clk), .rst(rst), .rx(rx), .tx(tx), .rts(rts), .cts(cts),
            .rx_read(rx_read), .rx_err(rx_err), .rx_data(rx_data), .rx_byte_received(rx_byte_received),
            .tx_transaction(tx_transaction), .tx_data(tx_data), .tx_data_ready(tx_data_ready), 
            .tx_data_copied(tx_data_copied), .tx_busy(tx_busy)/*, .debug_led_bus(led_bus)*/);

assign rx_led = (rst_generated == 1'b1) ? rx_blink : 1'b1;
assign tx_led = (rst_generated == 1'b1) ? tx_blink : 1'b1;
assign has_rx_data = received_bytes_counter[0]|received_bytes_counter[1]|received_bytes_counter[2]|
                     received_bytes_counter[3]|received_bytes_counter[4]|received_bytes_counter[5]|
                     received_bytes_counter[6]|received_bytes_counter[7];

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
                rst_generated = 1'b1;
            end
        end
    end
end

// this always implements LED lighting on Rx (Receive) -  D5 diode
always @(posedge clk)
begin
    if (rst)
    begin
        rx_blink_state <= BLINK_EVENT_AWAIT;
        rx_blink_counter <= 0;
        rx_blink <= 0;
    end
    else
    begin
        case (rx_blink_state)
        BLINK_EVENT_AWAIT:
        begin
            if (rx_byte_received)
            begin
                rx_blink_counter <= 0;
                rx_blink_state <= BLINK_ONE_STATE;
                rx_blink <= 0;
            end
        end
        BLINK_ONE_STATE:
        begin
            rx_blink_counter <= rx_blink_counter + 1;
            rx_blink <= 1;
            if (rx_blink_counter == LED_DELAY_COUNTER)
            begin
                rx_blink_counter <= 0;
                rx_blink_state <= BLINK_ZERO_STATE;
            end
        end
        BLINK_ZERO_STATE:
        begin
            rx_blink_counter <= rx_blink_counter + 1;
            rx_blink <= 0;
            if (rx_blink_counter == LED_DELAY_COUNTER)
            begin
                rx_blink_counter <= 0;
                rx_blink_state <= BLINK_EVENT_AWAIT;
            end
        end
        endcase
    end
end

// this always implements LED lighting on Tx (Transmit) - can't use D4
always @(posedge clk)
begin
   if (rst)
    begin
        tx_blink_state <= BLINK_EVENT_AWAIT;
        tx_blink_counter <= 0;
        tx_blink <= 0;
    end
    else
    begin
        case (tx_blink_state)
        BLINK_EVENT_AWAIT:
        begin
            if (tx_data_ready)
            begin
                tx_blink_counter <= 0;
                tx_blink_state <= BLINK_ONE_STATE;
                tx_blink <= 0;
            end
        end
        BLINK_ONE_STATE:
        begin
            tx_blink_counter <= tx_blink_counter + 1;
            tx_blink <= 1;
            if (tx_blink_counter == LED_DELAY_COUNTER)
            begin
                tx_blink_counter <= 0;
                tx_blink_state <= BLINK_ZERO_STATE;
            end
        end
        BLINK_ZERO_STATE:
        begin
            tx_blink_counter <= tx_blink_counter + 1;
            tx_blink <= 0;
            if (tx_blink_counter == LED_DELAY_COUNTER)
            begin
                tx_blink_counter <= 0;
                tx_blink_state <= BLINK_EVENT_AWAIT;
            end
        end
        endcase
    end
end



always @(posedge rst or negedge rx_byte_received or posedge rx_read)
begin
    if (rst == 1'b1)
    begin
        rx_data_ready_trig <= 1'b0;
        received_bytes_counter <= 0;
    end
    else
    begin
        if (rx_read == 1'b1)
        begin
            rx_data_ready_trig <= 1'b0;
            if (received_bytes_counter > 0)
            begin
                received_bytes_counter <= received_bytes_counter - 1;
            end
        end
        else
        begin
            if (rx_byte_received == 1'b0) 
            begin
                rx_data_ready_trig <= 1'b1;
                received_bytes_counter <= received_bytes_counter + 1;
            end
        end
    end
end

// this always implements tcp echo mode            
always @(posedge clk)
begin
    if (rst)
    begin
        tx_transaction <= 1'b0;
        rx_read <= 1'b0;
        tx_data <= 0;
        tx_data_ready <= 1'b0;
        serial_data_exchange_state <= SERIAL_INPUT_DATA_AWAIT_STATE;
        delay_counter <= 0;
        data_buffer <= 0;
        led_bus <= 8'b11111111;
    end
    else
    begin
        case (serial_data_exchange_state)
            SERIAL_INPUT_DATA_AWAIT_STATE:
            begin
                if (has_rx_data == 1'b1)
                begin
                    serial_data_exchange_state <= SERIAL_INPUT_DATA_RECEIVED_STATE;
                    delay_counter <= 0;
                end
            end
            SERIAL_INPUT_DATA_RECEIVED_STATE:
            begin
                rx_read <= 1'b1;
                delay_counter <= delay_counter + 1;
                if (delay_counter == 16)
                begin
                    delay_counter <= 0;
                    serial_data_exchange_state <= SERIAL_INPUT_DATA_PROCESSING_STATE;
                end
            end
            SERIAL_INPUT_DATA_PROCESSING_STATE:
            begin
                rx_read <= 1'b0;
                led_bus <= ~rx_data;
                data_buffer <= rx_data + 1;
                delay_counter <= 0;
                serial_data_exchange_state <= SERIAL_INPUT_DATA_CLR_STATE;
            end
            SERIAL_INPUT_DATA_CLR_STATE:
            begin
                delay_counter <= delay_counter + 1;
                if (delay_counter == DEFAULT_PROCESSES_DELAY_CYCLES)
                begin
                    delay_counter <= 0;
                    rx_read <= 1'b0;
                    serial_data_exchange_state <= SERIAL_OUTPUT_DATA_READY_STATE;
                end
            end
            SERIAL_OUTPUT_DATA_READY_STATE:
            begin
                tx_transaction <= 1'b1;
                tx_data <= data_buffer;
                tx_data_ready <= 1'b1;
                if (tx_data_copied == 1'b1)
                begin
                    serial_data_exchange_state <= SERIAL_OUTPUT_DATA_SEND_STATE;
                end
            end
            SERIAL_OUTPUT_DATA_SEND_STATE:
            begin
                //delay_counter <= delay_counter + 1;
                //if (delay_counter == DEFAULT_PROCESSES_DELAY_CYCLES)
                if (tx_data_copied == 1'b1)
                begin
                    // tx_data_ready <= 1'b0;
                    delay_counter <= 0;
                    serial_data_exchange_state <= SERIAL_OUTPUT_DATA_CLR_STATE;
                end
            end
            SERIAL_OUTPUT_DATA_CLR_STATE:
            begin
                delay_counter <= delay_counter + 1;
                if (delay_counter == DEFAULT_PROCESSES_DELAY_CYCLES)
                begin
                    delay_counter <= 0;
                    tx_data_ready <= 1'b0;
                    serial_data_exchange_state <= SERIAL_OUTPUT_DATA_FIN_STATE;
                end
            end
            SERIAL_OUTPUT_DATA_FIN_STATE:
            begin
                //delay_counter <= delay_counter + 1;
                if (tx_busy == 1'b0/*delay_counter == DEFAULT_PROCESSES_DELAY_CYCLES*/)
                begin
                    delay_counter <= 0;
                    tx_transaction <= 1'b0;
                    serial_data_exchange_state <= SERIAL_INPUT_DATA_AWAIT_STATE;
                end
            end
        endcase
    end
    
end

endmodule
