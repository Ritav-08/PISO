# 32-bit Parallel-In Serial-Out (PISO) Shift Register - Verilog

## Overview

This project implements a 32-bit Parallel-In Serial-Out (PISO) shift register using Verilog HDL. The design loads 32-bit parallel data and shifts it out serially one bit at a time on every positive edge of the clock.

---

## Design Description

### PISO Shift Register

* Accepts 32-bit parallel input data (`din_i`)
* Loads data when `load_i` is HIGH
* Shifts data serially when `load_i` is LOW
* Outputs 1-bit serial data (`dout_o`)
* Uses synchronous reset
* Operates on positive edge of clock

---

## Module Details

### PISO Module

```verilog
module PISO(
   input [31:0] din_i,
   input load_i,
   input clk_i,
   input rst_i,
   output reg dout_o
);
```

### Inputs

* `din_i`  → 32-bit parallel input
* `load_i` → Load enable signal
* `clk_i`  → Clock signal
* `rst_i`  → Active HIGH reset

### Output

* `dout_o` → Serial output bit

---

## Internal Register

```verilog
reg [31:0] DATA;
```

* Stores parallel input data
* Shifts right during serial transmission

---

## Working Principle

At every positive edge of the clock:

### 1. Reset Active

If reset is HIGH:

```verilog
dout_o <= 1'b0;
```

### 2. Load Mode

If `load_i = 1`:

```verilog
DATA <= din_i;
```

* Parallel input data is loaded into internal register

### 3. Shift Mode

If `load_i = 0`:

```verilog
dout_o <= DATA[0];
DATA <= {1'b0, DATA[31:1]};
```

* Least Significant Bit (LSB) is sent to output
* Register shifts right by one bit
* Zero is inserted at MSB position

---

## Data Shifting Example

Suppose:

```text
DATA = 10110010
```

Shift operations:

| Clock Cycle | Output Bit | DATA After Shift |
| ----------- | ---------- | ---------------- |
| 1           | 0          | 01011001         |
| 2           | 1          | 00101100         |
| 3           | 0          | 00010110         |
| ...         | ...        | ...              |

---

## Testbench Description

The testbench performs:

* Clock generation
* Reset operation
* Parallel data loading
* Serial shifting operation
* Multiple load operations
* Waveform dumping
* Real-time monitoring using `$monitor`

---

## Testbench Sequence

### Step 1: Apply Reset

```verilog
rst_ti = 1'b1;
```

### Step 2: Load Parallel Data

```verilog
load_ti = 1'b1;
din_ti = 32'h84fac960;
```

### Step 3: Shift Serial Data

```verilog
load_ti = 1'b0;
```

Bits begin shifting out serially through `dout_o`.

### Step 4: Load Again

Another parallel load operation is performed later during simulation.

---

## Sample Simulation Output

```text
Time: 20 | Load: 0 | Input: 84fac960 | Output: 0
Time: 30 | Load: 0 | Input: ffffffff | Output: 0
Time: 40 | Load: 0 | Input: ffffffff | Output: 0
```

---

## Waveform

Generated waveform file:

```text
PISO.vcd
```

Open waveform using GTKWave:

```bash
gtkwave PISO.vcd
```

---

## How to Run (Icarus Verilog)

### Compile

```bash
iverilog -o piso PISO.v
```

### Run Simulation

```bash
vvp piso
```

### Open Waveform

```bash
gtkwave PISO.vcd
```

---

## Features

* 32-bit parallel data loading
* Serial data transmission
* Right-shift operation
* Synchronous reset
* Positive edge triggered

---

## Applications

* Serial communication systems
* Data transmission interfaces
* UART/SPI style communication
* Shift-register based designs
* Digital data serialization

---

## Notes

* Data shifts from LSB to output
* Zero-padding is applied during shifting
* Internal register retains loaded data until fully shifted
* Behavioral modeling approach is used

---
