//////////////////////////////////////////////////////////////////////////////////
// Company:             Wissance (https://wissance.com)
// Engineer:            EvilLord666 (Ushakov MV - https://github.com/EvilLord666)
// 
// Create Date:         10.05.2024
// Design Name:         SerialCmdProcessor
// Module Name:         serial_cmd_decoder
// Project Name:        SerialCmdProcessor
// Target Devices:      QMTECH CycloneIV Core Board (EP4CE15F23C8N)
// Tool versions:       Quartus Prime Lite 18.1
// Description:         Serial CMD Decoder, purpose is to 1. Validate data format, 2. Extract the data
//                      A CMD Format: |CMD Start (2 bytes of 0xFF)|Zero Byte (0x00)|Payload Len (1 byte)|Payload (up to 255 bytes, LSB)|CMD END (2 bytes of 0xFF)
//                      Consider we have 2 COMMANDS (SET_REG = 0x01), (GET_REG = 0x02)
//                      We assume that we deal with 4 REGISTERS (0, 1, 2, 3) each register is a 32 bit
//                                                                    Start     Zero  PayLen                 Payload                  End
//                      CMD to set Reg2 Value to 1A2B3C4D looks : | 0xFF 0xFF | 0x00 | 0x06 | 0x01 0x02 0x4D 0x3C 0x2B 0x1A | 0xEE 0xEE |
//                                                                    Start     Zero  PayLen   Payload       End
//                      CMD to get Reg3 Value                     | 0xFF 0xFF | 0x00 | 0x02 | 0x02 0x03 | 0xEE 0xEE |
//                      Device should respond on every CMD, on GET -> Value, On SET that Command Approved (0x01) OR Rejected (0x02)
//                      CMD Approved:                             | 0xFF 0xFF | 0x00 | 0x01 | 0x01 | 0xEE 0xEE |
//                      CMD Rejected:                             | 0xFF 0xFF | 0x00 | 0x01 | 0x02 | 0xEE 0xEE |
// Dependencies:        No
//
// Revision:            1.0
// Additional Comments: Actualy we are testing here 1 mode: (115200 bod/s, 1 stop bit, even parity, no flow control)
//////////////////////////////////////////////////////////////////////////////////

module serial_cmd_decoder #(
    parameter MAX_CMD_PAYLOAD_BYTES = 8
)
(
    input wire clk,
    input wire rst,
    // buffer to read data from
    input wire [7:0] data,
    // when set to 1 buffer is ready (contains data that could be considered as cmd)
    input wire cmd_ready,
    // processed state read by module
    input wire cmd_processed_received,
    // clock 2 read data from data
    output reg cmd_read_clk, 
    // when set to 1 means cmd was decoded or not (at least it is noithing to do with data)
    output reg cmd_processed,
    output reg [7:0] cmd_bytes_processed,
    output reg cmd_decode_success
)

localparam reg [3:0] INITIAL_STATE = 4'b0000;
localparam reg [3:0] AWAIT_CMD_STATE = 4'b0001;
localparam reg [3:0] CMD_START_PROCESSING_STATE = 4'b0010;
localparam reg [3:0] CMD_SPACE_PROCESSING_STATE = 4'b0011;
localparam reg [3:0] CMD_PAYLOAD_LENGTH_PROCESSING_STATE = 4'b0100;
localparam reg [3:0] CMD_PAYLOAD_PROCESSING_STATE = 4'b0101;
localparam reg [3:0] CMD_STOP_PROCESSING_STATE = 4'b0110;
localparam reg [3:0] CMD_DETECTED_STATE = 4'b0100;

localparam reg [7:0] BYTE_READ_CLK_DELAY = 16;
localparam reg [7:0] BYTE_READ_DATA_DELAY = 25;
localparam reg [7:0] BYTE_READ_END_DELAY = 32;
localparam reg [7:0] SOF_BYTE = 255;
localparam reg [7:0] EOF_BYTE = 238;
localparam reg [7:0] SPACE_BYTE = 0;
localparam reg [1:0] NUMBER_OF_SOF_BYTES = 2;
localparam reg [1:0] NUMBER_OF_EOF_BYTES = 2;

reg [3:0] state;
reg [7:0] byte_read_delay_counter;
reg [1:0] sof_bytes_counter;
reg [1:0] eof_bytes_counter;
reg [7:0] payload_len;

always @(posedge clk)
begin
    if (rst)
    begin
        state <= INITIAL_STATE;
        cmd_bytes_processed <= 0;
        cmd_processed <= 1'b0;
        cmd_decoded <= 1'b0;
        sof_bytes_counter <= 0;
        eof_bytes_counter <= 0;
        payload_len <= 0;
    end
    else
    begin
        case (state)
            INITIAL_STATE:
            begin
                cmd_bytes_processed <= 0;
                state <= AWAIT_CMD_STATE;
                cmd_processed <= 1'b0;
                cmd_decode_success <= 1'b0;
                cmd_read_clk <= 1'b0;
                byte_read_delay_counter <= 0;
                sof_bytes_counter <= 0;
                eof_bytes_counter <= 0;
                payload_len <= 0;
            end
            AWAIT_CMD_STATE:
            begin
                if (cmd_ready == 1'b1)
                begin
                    state <= CMD_START_PROCESSING_STATE;
                    cmd_processed <= 1'b0;
                    cmd_decode_success <= 1'b0;
                end
            end
            CMD_START_PROCESSING_STATE:
            begin
                // delay, toggle, inc counter,  analyze
                byte_read_delay_counter <= byte_read_delay_counter + 1;
                if (byte_read_delay_counter == BYTE_READ_CLK_DELAY)
                begin
                    cmd_read_clk <= ~cmd_read_clk;
                end
                if (byte_read_delay_counter == BYTE_READ_DATA_DELAY)
                begin
                    if (cmd_read_clk == 1'b1)
                    begin
                        // compare byte with SOF_BYTE, in not,  there is an error
                        if (data == SOF_BYTE)
                        begin
                            sof_bytes_counter <= sof_bytes_counter + 1;
                        end
                        else
                        begin
                            // got error because byte is not START OF FRAME
                            cmd_processed <= 1'b1;
                            cmd_decode_success <= 1'b0;
                            state <= INITIAL_STATE;
                        end
                    end
                    else
                    begin
                        if (sof_bytes_counter == NUMBER_OF_SOF_BYTES)
                        begin
                            state <= CMD_SPACE_PROCESSING_STATE;
                        end
                    end
                    byte_read_delay_counter <= 0;
                end
            end
            CMD_SPACE_PROCESSING_STATE:
            begin
                byte_read_delay_counter <= byte_read_delay_counter + 1;
                if (byte_read_delay_counter == BYTE_READ_CLK_DELAY)
                begin
                    cmd_read_clk <= ~cmd_read_clk;
                end
                if (byte_read_delay_counter == BYTE_READ_DATA_DELAY)
                begin
                    if (cmd_read_clk == 1'b1)
                    begin
                        if(data != SPACE_BYTE)
                        begin
                            cmd_processed <= 1'b1;
                            cmd_decode_success <= 1'b0;
                            state <= INITIAL_STATE;
                        end
                    end
                end
                if (byte_read_delay_counter == BYTE_READ_END_DELAY)
                begin
                    cmd_read_clk <= 1'b0;
                    state <= CMD_PAYLOAD_LENGTH_PROCESSING_STATE;
                end
            end
            CMD_PAYLOAD_LENGTH_PROCESSING_STATE:
            begin
                byte_read_delay_counter <= byte_read_delay_counter + 1;
                if (byte_read_delay_counter == BYTE_READ_CLK_DELAY)
                begin
                    cmd_read_clk <= ~cmd_read_clk;
                end
                if (byte_read_delay_counter == BYTE_READ_DATA_DELAY)
                begin
                    if (cmd_read_clk == 1'b1)
                    begin
                        payload_len <= data;
                        if(data > MAX_CMD_PAYLOAD_BYTES)
                        begin
                            cmd_processed <= 1'b1;
                            cmd_decode_success <= 1'b0;
                            state <= INITIAL_STATE;
                        end
                    end
                end
                if (byte_read_delay_counter == BYTE_READ_END_DELAY)
                begin
                    cmd_read_clk <= 1'b0;
                    state <=  CMD_PAYLOAD_PROCESSING_STATE;
                end
            end
            CMD_PAYLOAD_PROCESSING_STATE:
            begin
            end
            CMD_STOP_PROCESSING_STATE:
            begin
            end
            CMD_DETECTED_STATE:
            begin
            end
            default:
            begin
                state <= INITIAL;
            end
        endcase
    end
end

endmodule
