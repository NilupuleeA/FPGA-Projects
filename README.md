# UART Bit Stream Structure

## Start Bit:
- The UART transmission always begins with a start bit, which is a **logic low (0)** signal.
- This indicates to the receiver that a new data frame is about to be transmitted.

## Data Bits:
- After the start bit, the actual data bits are transmitted.
- The number of data bits is typically **8 bits**.
- The data bits are sent starting from the **least significant bit (LSB)**.
- This data represents the byte being communicated, and both the sender and receiver must agree on the number of bits being transmitted.

## Parity Bit:
- The parity bit is a feature used for **error detection**.
- It checks if the number of 1’s in the transmitted data bits is even or odd.

  **If parity is enabled:**
  - **Even parity**: The parity bit is set to 1 if the number of 1’s in the data is odd, making the total count even.
  - **Odd parity**: The parity bit is set to 1 if the number of 1’s in the data is even, making the total count odd.

## Stop Bit(s):
- The transmission ends with one or more stop bits, which are always **logic high (1)**.
- Stop bits provide a buffer between the end of one data frame and the start of the next.
- They ensure the receiver has enough time to process the data before another transmission begins.

## Idle Line:
- After the stop bit(s) are sent, the UART line returns to an **idle state**, which is a **logic high (1)**.
- The line remains idle until the next transmission begins with a new start bit.
- The idle state allows the system to differentiate between periods of activity and inactivity on the communication line.
![uart3](https://github.com/user-attachments/assets/6b695315-0928-48f0-bccb-f537b0b06a23)

# UART Transmitter Module

## Parameters

- **CLOCKS_PER_PULSE**: Defines the baud rate based on the clock frequency and desired baud rate.
- **BITS_PER_WORD**: Number of data bits per word (typically 8 bits).
- **PACKET_SIZE**: Total size of the packet, including start, data, parity, and stop bits (`BITS_PER_WORD + 5`).
- **W_OUT**: Total output width, determined by the application.

## Ports

- **Inputs**:
  - `clk`: Clock signal.
  - `rstn`: Active-low reset signal.
  - `s_valid`: Indicates that `s_data` is valid and ready for transmission.
  - `s_data`: Parallel data input, provided as an array of `NUM_WORDS` words.

- **Outputs**:
  - `tx`: Serial data output for UART transmission.
  - `s_ready`: Indicates when the module is ready to accept new data (high when in the IDLE state).

## Functionality

### State Machine

The state machine controls the data transmission process:

1. **IDLE State**:
   - The module waits for `s_valid` to be asserted, indicating that data is ready for transmission.
   - Once `s_valid` is high, the state transitions to **SEND**, and the data packets are prepared for transmission.

2. **SEND State**:
   - **Data Shifting**: Data bits are shifted out serially, starting with the least significant bit.
   - **Timing Control**: Counters (`c_clocks` and `c_pulses`) manage baud rate timing and ensure data is transmitted at the correct rate.
   - **Completion**: Once all data and stop bits are transmitted, the state machine resets counters and returns to the IDLE state to accept new data.

### Parity Implementation

- **Parity Bit Calculation**:
  - The parity bit is computed by XORing all bits in each data word. This ensures the total number of `1`s (including the parity bit) is either even or odd, depending on the parity setting.

- **Error Detection**:
  - The receiver checks the parity bit against the received data to detect transmission errors. A mismatch indicates an error occurred during transmission.

## Example Usage

This module is suitable for applications requiring UART communication, including microcontroller-based systems. It provides reliable data transfer with optional parity checking for enhanced error detection.

