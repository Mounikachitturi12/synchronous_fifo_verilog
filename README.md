# Synchronous FIFO Design and Verification Using Verilog

## Overview

This project implements a synchronous FIFO (First-In First-Out) buffer using Verilog HDL.

The FIFO has a depth of 16 locations, with each location storing 8-bit data. The design was developed and simulated using Xilinx Vivado.

## Features

- 16 × 8-bit FIFO memory
- Synchronous read and write operations
- 4-bit write pointer
- 4-bit read pointer
- 5-bit occupancy counter
- FULL and EMPTY status flags
- Write protection when FIFO is FULL
- Read protection when FIFO is EMPTY
- Pointer wraparound
- Self-checking testbench with PASS/FAIL messages

## FIFO Architecture

The FIFO consists of:

- Memory array for storing data
- Write pointer (`wr_ptr`)
- Read pointer (`rd_ptr`)
- Counter (`count`)
- FULL flag
- EMPTY flag

### Write Operation

When `wr_en = 1` and the FIFO is not FULL, input data is stored in the memory at the location pointed to by `wr_ptr`.

### Read Operation

When `rd_en = 1` and the FIFO is not EMPTY, data is read from the memory location pointed to by `rd_ptr`.

### FULL Condition

The FIFO is FULL when:

```text
count = 16
