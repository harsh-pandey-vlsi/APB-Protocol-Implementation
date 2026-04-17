# APB Protocol Implementation (Verilog + SystemVerilog Testbench)

## 📌 Overview
This project implements the AMBA APB (Advanced Peripheral Bus) protocol, a low-power and low-complexity bus widely used for peripheral communication in SoCs. The design includes an APB master, APB slave (memory model), and a self-checking SystemVerilog testbench.

---

## 🎯 Objectives
- Design an APB master using FSM (IDLE → SETUP → ENABLE)
- Implement an APB slave with memory-mapped registers
- Validate read/write operations using a testbench
- Understand APB timing and handshake mechanism

---

## 🏗️ Architecture

### 🔹 APB Master
- Controls transaction flow using FSM
- Generates signals: `PSEL`, `PENABLE`, `PWRITE`
- Handles read/write operations

### 🔹 APB Slave
- 256 x 32-bit memory
- Responds with `PREADY` and `PRDATA`
- Supports read and write transactions

### 🔹 Top Module
- Connects master and slave

### 🔹 Testbench
- Task-based stimulus (`apb_write`, `apb_read`)
- Self-checking using read-after-write comparison
- Generates waveform dump

---

## 📂 File Structure
├── apb_master.v
├── apb_slave.v
├── apb_top.v
├── tb.sv
├── wave.vcd (generated after simulation)


---

## 🔧 Design Details

### APB Transfer Phases
1. **SETUP Phase**
   - `PSEL = 1`, `PENABLE = 0`
2. **ENABLE Phase**
   - `PENABLE = 1`
   - Transfer occurs when `PREADY = 1`

---

## ▶️ Simulation

### Compile & Run (ModelSim / Questa)
```bash
vlog apb_master.v apb_slave.v apb_top.v tb.sv
vsim tb
run -all

---

## 🧠 Learning Outcomes
Understanding of AMBA APB protocol
FSM-based RTL design
SystemVerilog testbench development
Basic verification methodologies

👨‍💻 Author

Harsh Pandey
Electronics and Communication Engineering (ECE)
VLSI | RTL Design | Verification



