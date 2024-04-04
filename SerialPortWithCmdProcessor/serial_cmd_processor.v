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
//                      A CMD Format: |CMD Start (2 bytes of 0xFF)|Zero Byte (0x00)|Payload Len (1 byte)|Payload (up to 255 bytes, LSB)|CMD END (2 bytes of 0xFF)
//                      Consider we have 2 COMMANDS (SET_REG = 0x01), (GET_REG = 0x02)
//                      We assume that we deal with 4 REGISTERS (0, 1, 2, 3) each register is a 32 bit
//                                                                    Start     Zero  PayLen                 Payload                  End
//                      CMD to set Reg2 Value to 1A2B3C4D looks : | 0xFF 0xFF | 0x00 | 0x07 | 0x01 0x02 0xDD 0x4D 0x3C 0x2B 0x1A | 0xEE 0xEE |
//                                                                    Start     Zero  PayLen   Payload       End
//                      CMD to get Reg3 Value                     | 0xFF 0xFF | 0x00 | 0x02 | 0x02 0x03 | 0xEE 0xEE |
//                      Device should respond on every CMD, on GET -> Value, On SET that Command Approved (0x01) OR Rejected (0x02)
//                      CMD Approved:
//                      CMD Rejected: 
// Dependencies:        Depends on QuickRS232 sources (quick_rs232 && fifo modules), https://github.com/Wissance/QuickRS232
//
// Revision:            1.0
// Additional Comments: Actualy we are testing here 1 mode: (115200 bod/s, 1 stop bit, even parity, no flow control)
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

localparam reg [1:0]  BLINK_EVENT_AWAIT = 0;
localparam reg [1:0]  BLINK_ZERO_STATE = 1;
localparam reg [1:0]  BLINK_ONE_STATE = 2;
localparam reg [31:0] LED_DELAY_COUNTER = 10000000; // 200 ms for 50 MHz

localparam reg [3:0] AWAIT_INPUT_DATA_STATE = 4'b0000;
localparam reg [3:0] INPUT_DATA_RECEIVED_STATE = 4'b0001;
localparam reg [3:0] CMD_CHECK_STATE = 4'b0010;
localparam reg [3:0] CMD_DETECTED_STATE = 4'b0011;
localparam reg [3:0] CMD_EXECUTE_STATE = 4'b0100;
localparam reg [3:0] SEND_RESPONSE_STATE = 4'b0101;
localparam reg [3:0] RESPONSE_SENT_STATE = 4'b0110;
localparam reg [3:0] OPERATION_TIMEOUT_STATE = 4'b1111;


localparam reg [3:0] CMD_LENGTH = 8;


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
reg  [3:0] device_state;

quick_rs232 #(.CLK_TICKS_PER_RS232_BIT(434), .DEFAULT_BYTE_LEN(8), .DEFAULT_PARITY(1), .DEFAULT_STOP_BITS(0),
              .DEFAULT_RECV_BUFFER_LEN(8), .DEFAULT_FLOW_CONTROL(0)) 
serial_dev (.clk(clk), .rst(rst), .rx(rx), .tx(tx), .rts(rts), .cts(cts),
            .rx_read(rx_read), .rx_err(rx_err), .rx_data(rx_data), .rx_byte_received(rx_byte_received),
            .tx_transaction(tx_transaction), .tx_data(tx_data), .tx_data_ready(tx_data_ready), 
            .tx_data_copied(tx_data_copied), .tx_busy(tx_busy));

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

// received and non send bytes counter
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

// main cycle -> accumulate rx bytes -> process -> handle cmd -> send response
always @(posedge clk)
begin
    if (rst == 1'b1)
    begin
	     device_state <= AWAIT_INPUT_DATA_STATE;
	 end
	 else
	 begin
	     case (device_state)
		  AWAIT_INPUT_DATA_STATE:
		  begin
		  end
        INPUT_DATA_RECEIVED_STATE:
		  begin
		  end
        CMD_CHECK_STATE:
		  begin
		  end
        CMD_DETECTED_STATE:
		  begin
		  end
        CMD_EXECUTE_STATE:
		  begin
		  end
        SEND_RESPONSE_STATE:
		  begin
		  end
        RESPONSE_SENT_STATE:
		  begin
		  end
		  OPERATION_TIMEOUT_STATE:
		  begin
		  end
		  default:
		  begin
		  end
		  endcase
	 end
end

endmodule
