## QmtechCycloneIVBoardDemos
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/wissance/QmtechCycloneIVBoardDemos?style=plastic) 
![GitHub issues](https://img.shields.io/github/issues/wissance/QmtechCycloneIVBoardDemos?style=plastic)
![GitHub Release Date](https://img.shields.io/github/release-date/wissance/QmtechCycloneIVBoardDemos?style=plastic)
![GitHub release (latest by date)](https://img.shields.io/github/downloads/wissance/QmtechCycloneIVBoardDemos/v0.1/total?style=plastic)

## 1. Project description

A set of ***additional*** non-official ***demo projects*** for `QmTech` `Cyclone IV` `Core Board` (`EP4CE15F23C8`).

## 2. Demos

### 2.1 RS232 Demo

For testing `RS232` [`QuickRS232`](https://github.com/Wissance/QuickRS232) module
was designed project `SerialPortEcho`. This project receive bytes from serial port (`COM`) that is configured in following mode - `115200 bit/s, 1 stop bit, even parity, no flow control`. This project do following: `receive byte, add + 1 and send it back`.

![RS232 Timing diagrams](/docs/img/serial_echo_demo.png)

#### 2.1.1 Demo project on board pinout

* `CLK` - global clock - already on the board -> `DIFFCLK_1P`
* `RX` - `RS232` `RX` line - connected to `U8` `20 pin` -> `IO_AB19`
* `TX` - `RS232` `TX` line - connected to `U8` `22 pin` -> `IO_AB20`
* `RTS` - we **don't USE it** in this demo **because simple `TTL` to `RS232` converter**, but anyway we connect it to `U8` `24 pin` -> `IO_Y21`
* `CTS` - we don't USE it in this demo because simple `TTL` to `RS232` converter,
  but anyway we connect it to `U8` `26 pin` -> `IO_W21`
* `RX_LED` - connect it to `D5 LED` -> `DIFFIO_L3P`
* `TX_LED` - don't have on board free `LED`, therefore just out it to pin 30 of `U8` (`IO_U21`)

Additionally RS232-to-TTL converter must be attached to power supply line and ground, that also could be taken from `U8`:

* `3V3` - Any pin from (3, 4)
* `GND` - Any pin from (1, 2, 61, 62)

