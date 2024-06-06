# Digital Alarm Clock for Basys 3 Board

This project implements a digital clock with alarm functionality using Verilog and Vivado, targeting the Basys 3 FPGA development board. The ClockInterface module provides clock display, time adjustment, and alarm setting capabilities, making use of the onboard buttons and seven-segment display.

## Features

- **Clock Display**: Shows current time on a seven-segment display.
- **Time Adjustment**: Allows adjustment of minutes and hours using the onboard buttons.
- **Alarm Setting**: Users can set an alarm time. When the current time matches the alarm time, a buzzer sounds.
- **LED Indicators**: Indicates the current mode (clock adjustment, alarm adjustment) with onboard LEDs.
- **Buzzer Control**: Sounds the buzzer when the alarm is triggered.

## Hardware Requirements

- **Basys 3 FPGA Board**
- **Vivado Design Suite**

## Module Overview

### ClockInterface Module

The `ClockInterface` module is the top-level module that integrates various sub-modules to achieve the clock and alarm functionality. It includes clock dividers, button detectors, and the main digital clock logic.

#### Inputs

- `clk`: System clock input.
- `reset`: Reset signal.
- `BTNU`, `BTND`, `BTNL`, `BTNR`, `BTNC`: Button inputs for user interaction.
- `enablealarm`: Enable signal for the alarm.

#### Outputs

- `segments`: Controls the seven-segment display.
- `anode_active`: Controls which digit of the seven-segment display is active.
- `dp`: Decimal point control for the seven-segment display.
- `LD0`, `LD12`, `LD13`, `LD14`, `LD15`: LEDs indicating various states and modes.
- `buzzer`: Buzzer control signal.

### Sub-Modules

1. **Clock Dividers**: Used to generate different clock frequencies required by other components.
    - `clockDivider #(250000) divide`: Generates a 200Hz clock.
    - `clockDivider #(50000000) decimal`: Generates a 1Hz clock.
    - `clockDivider #(10000000) buzzerclk`: Generates a 5Hz clock for the buzzer.

2. **Pushdown Detectors**: Detects button presses and provides clean, debounced signals.
    - `pushdownDetector btn1`: Detects center button press.
    - `pushdownDetector btn2`: Detects down button press.
    - `pushdownDetector btn3`: Detects up button press.
    - `pushdownDetector btn4`: Detects left button press.
    - `pushdownDetector btn5`: Detects right button press.

3. **Digital Clock**: Main clock logic that handles timekeeping and display updates.
    - `digitalClock Main`: Manages the clock display, time adjustment, and alarm functionality.

### State Machine

The state machine controls the mode of operation:
- `Clock_mode`: Normal clock operation.
- `Adjust_clockmin`: Adjusting the minutes.
- `Adjust_clockhour`: Adjusting the hours.
- `Adjust_alarmmin`: Adjusting the alarm minutes.
- `Adjust_alarmhour`: Adjusting the alarm hours.
- `Alarm_mode`: Alarm active mode.

### Operation

- **Clock Mode**: The default mode displaying the current time.
- **Adjust Time**: Press the center button to enter time adjustment mode. Use the up and down buttons to change the minutes and hours.
- **Set Alarm**: Enter alarm adjustment mode by navigating through the state machine. Set the alarm time using the up and down buttons.
- **Enable Alarm**: Set the `enablealarm` input to activate the alarm.
- **Alarm Trigger**: When the set alarm time is reached, the buzzer will sound.

## Usage

1. **Setup**: Load the Verilog code into Vivado and program the Basys 3 board.
2. **Clock Display**: The seven-segment display shows the current time.
3. **Adjust Time**: Press the center button to enter time adjustment mode. Use the up and down buttons to change the minutes and hours.
4. **Set Alarm**: Enter alarm adjustment mode by navigating through the state machine. Set the alarm time using the up and down buttons.
5. **Enable Alarm**: Set the `enablealarm` input to activate the alarm.
6. **Alarm Trigger**: When the set alarm time is reached, the buzzer will sound.

## Additional Information

- **LD0**: Lit during any adjustment mode or when the alarm is active.
- **LD12**: Lit during minute adjustment mode.
- **LD13**: Lit during hour adjustment mode.
- **LD14**: Lit during alarm minute adjustment mode.
- **LD15**: Lit during alarm hour adjustment mode.
- **Buzzer**: Sounds when the alarm is triggered.

