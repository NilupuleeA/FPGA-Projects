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

# UART Receiver Module

## Parameters

- **CLOCKS_PER_PULSE**: Defines the baud rate based on the clock frequency and desired baud rate. Determines how many clock cycles are used for one baud period.
- **BITS_PER_WORD**: Number of data bits per word (typically 8 bits).
- **W_OUT**: Total width of the output data, determined by the application.

## Ports

- **Inputs**:
  - `clk`: Clock signal input.
  - `rstn`: Active-low reset signal.
  - `rx`: Serial data input (received data).

- **Outputs**:
  - `m_valid`: Indicates that the received data on `m_data` is valid.
  - `m_data`: Parallel data output after receiving and decoding the serial data.

## Functionality

### State Machine

The state machine controls the reception and decoding of the UART data:

1. **IDLE State**:
   - The module waits for the start bit (logic low `0`) to signal the beginning of a new data frame.
   - Once the start bit is detected, it transitions to the **START** state.

2. **START State**:
   - Waits for half a baud period to synchronize with the start bit.
   - After the delay, it transitions to the **DATA** state.

3. **DATA State**:
   - Reads the data bits serially.
   - Uses counters (`c_clocks` and `c_bits`) to manage timing and bit position.
   - After receiving all data bits, it transitions to the **PARITY** state.

4. **PARITY State**:
   - Checks the parity bit for error detection.
   - Computes the parity of the received data bits and compares it with the received parity bit (`rx`).
   - If the parity matches, it moves to the **END** state. Otherwise, it returns to **IDLE**.

5. **END State**:
   - Completes the reception process and returns to the **IDLE** state, ready to receive the next data frame.

### Counters

- **Clock Counter (`c_clocks`)**: Counts clock cycles to manage baud rate timing.
- **Bit Counter (`c_bits`)**: Counts data bits received in each word.
- **Word Counter (`c_words`)**: Counts the number of words received.

### Parity Implementation

- **Parity Bit Checking**:
  - Computes the parity of the received data using XOR operation.
  - Compares the computed parity with the received parity bit to detect errors.

# UART Communication on DE0-Nano FPGA Board

To implement UART communication using the DE0-nano FPGA board, we followed these steps:

### 1. Designed the UART Module
- Developed Verilog modules for both UART transmitter and receiver.
- **UART Transmitter**: Converts parallel data into serial format, handles start and stop bits, and includes optional parity checking.
- **UART Receiver**: Converts serial data back into parallel format, detects start and stop bits, and performs parity checking if enabled.

### 2. Developed a Testbench
- Created a testbench to simulate the UART modules.
- Verified functionality with stimulus and responses to ensure proper operation before hardware testing.

### 3. Assigned Pins
- Mapped UART signals to the appropriate pins on the DE0-nano FPGA board.
- Ensured correct pin assignments in the FPGA design tool for proper signal interfacing.

### 4. Performed Simulation and Verification
- Ran simulations to verify that the UART modules function correctly at the desired baud rate.
- Checked data transmission and reception accuracy.

### 5. Set Up Hardware
- Used one DE0-nano FPGA board as the UART transmitter and another as the UART receiver.
- Connected the UART transmit pin from the transmitter board to the UART receive pin on the receiver board.

### 6. Tested Communication
- Loaded the design onto both FPGA boards.
- Tested UART communication to ensure data was transmitted and received correctly.
- Verified that the baud rates matched for successful communication.

