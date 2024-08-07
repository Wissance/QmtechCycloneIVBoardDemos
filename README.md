## QmtechCycloneIVBoardDemos
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/wissance/QmtechCycloneIVBoardDemos?style=plastic) 
![GitHub issues](https://img.shields.io/github/issues/wissance/QmtechCycloneIVBoardDemos?style=plastic)
![GitHub Release Date](https://img.shields.io/github/release-date/wissance/QmtechCycloneIVBoardDemos?style=plastic)
![GitHub release (latest by date)](https://img.shields.io/github/downloads/wissance/QmtechCycloneIVBoardDemos/v1.0/total?style=plastic)

## 1. Project description

A set of ***additional*** non-official ***demo projects*** for `QmTech` `Cyclone IV` `Core Board` (`EP4CE15F23C8`).

## 2. Demos

### 2.1 Echo+1 RS232 Demo

For testing `RS232` [`QuickRS232`](https://github.com/Wissance/QuickRS232) module
was designed project `SerialPortEcho`. This project receive bytes from serial port (`COM`) that is configured in following mode - `115200 bit/s, 1 stop bit, even parity, no flow control`. This project do following: `receive byte, add + 1 and send it back`.

![RS232 Timing diagrams](/docs/img/serial_echo_demo.png)

You could use our application [`Zerial`](https://github.com/Wissance/Zerial) to work with `RS232`:

![Application 4 RS232](/docs/img/serial_echo_app_4test.png)

#### 2.1.1 Demo project on board pinout

* `CLK` - global clock - already on the board -> `DIFFCLK_1P` (`T2`)
* `RX` - `RS232` `RX` line - connected to `U8` `20 pin` -> `IO_AB19`
* `TX` - `RS232` `TX` line - connected to `U8` `22 pin` -> `IO_AB20`
* `RTS` - we **don't USE it** in this demo **because simple `TTL` to `RS232` converter**, but anyway we connect it to `U8` `24 pin` -> `IO_Y21`
* `CTS` - we don't USE it in this demo because simple `TTL` to `RS232` converter,
  but anyway we connect it to `U8` `26 pin` -> `IO_W21`
* `RX_LED` - connect it to `D5 LED` -> `DIFFIO_L2P` (`E4`)
* `TX_LED` - don't have on board free `LED`, therefore just out it to pin 30 of `U8` (`IO_U21`)

Additionally RS232-to-TTL converter must be attached to power supply line and ground, that also could be taken from `U8`:

* `3V3` - Any pin from (3, 4)
* `GND` - Any pin from (1, 2, 61, 62)

### 2.2 Cmd Decode+Encode RS232 Demo

Usually we **don't work with separate bytes**, we are **interacting with device by commands**, device is answering on received command, therefore we wrapped bytes in `Command/Answer` via ***frames***.

In this demo Frame have a following **format of a Frame** : 
`SOF | Space | Payload Len | Payload |EOF ` , where:
* `SOF` - start of a frame (2 bytes of `0xFF`)
* `Space` - separator (0 Byte - `0x00`)
* `Payload len` - number of payload bytes
* `Payload` - actual payload, *could be up to 255*, but in demo **restricted to 8**
* `EOF` - end of a frame (2 bytes of `EE`)

In this demo (`SerialPortWithCmdProcessor` folder/project) we are having following 2 commands:
1. *Set 4-byte register* - `0xFF 0xFF 0x00 0x07 0x01 0x02 0x10 0x20 0x30 0x40 0xEE 0xEE` which means `SET` (cmd code `0x01`, 0 byte of payload) **Register** `0x02` (index of registers `0-7`, 1 byte of payload) to value `0x10203040`.
2. *Get 4-byte register* - (cmd code `0x02`), i.e. reading of register of index `0x03` :
`0xFF 0xFF 0x00 0x02 0x02 0x03 0xEE 0xEE`

#### 2.2.1 Testbenches diagrams demonstrating how it works:

Example of how decoder works, we haven't yet encoder (maybe will be in future)

![Frame parser/decoder](/docs/img/serial_cmd_decoder_example.png)

Example of interacting with device by `Commands/Answers`

![Interaction by commands](/docs/img/cmd_commands_demo.png)

#### 2.2.2 Demo project on board pinout

* `CLK` - global clock - already on the board -> `DIFFCLK_1P` (`T2`)
* `RX` - `RS232` `RX` line - connected to `U8` `20 pin` -> `IO_AB19`
* `TX` - `RS232` `TX` line - connected to `U8` `22 pin` -> `IO_AB20`
* `RTS` - we **don't USE it** in this demo **because simple `TTL` to `RS232` converter**, but anyway we connect it to `U8` `24 pin` -> `IO_Y21`
* `CTS` - we don't USE it in this demo because simple `TTL` to `RS232` converter,
  but anyway we connect it to `U8` `26 pin` -> `IO_W21`
* `RX_LED` - connect it to `D5 LED` -> `DIFFIO_L2P` (`E4`)
* `TX_LED` - don't have on board free `LED`, therefore just out it to pin 30 of `U8` (`IO_U21`)

Additionally RS232-to-TTL converter must be attached to power supply line and ground, that also could be taken from `U8`:

* `3V3` - Any pin from (3, 4)
* `GND` - Any pin from (1, 2, 61, 62)

### 2.3 DRAM Explorer + RS232 Demo

is under development....

Give us a STAR for motivating us to do this (**100 stars min to prioritize this work**)



