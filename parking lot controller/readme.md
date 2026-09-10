A digital parking lot controller designed using Verilog HDL.

The system monitors vehicles entering and leaving a parking lot and keeps track of the number of available parking spaces.

Features
Vehicle entry detection
Vehicle exit detection
Parking slot counter
Available slot counter
Full parking lot detection
Entry gate control
Exit gate control
Parameterized parking capacity
Verilog testbench for simulation
Block Diagram
              +-------------------+
Entry Sensor  |                   |
------------->|                   |
              | Parking Lot       |----> Entry Gate
Exit Sensor   |    Controller     |
------------->|                   |----> Exit Gate
              |                   |
              |                   |----> FULL
              |                   |
              |                   |----> Available Slots
              +-------------------+

Inputs
Signal	Description
clk	System clock
reset	Active-high reset
entry_sensor	Detects vehicle entering
exit_sensor	Detects vehicle leaving

Outputs
Signal	Description
entry_gate	Opens entry gate when a slot is available
exit_gate	Opens exit gate when a vehicle is detected
full	Indicates that parking is full
available_slots	Number of available parking slots

Default Capacity
The design uses:

parameter TOTAL_SLOTS = 8;

The testbench changes this to:

parameter TOTAL_SLOTS = 4;

This makes simulation easier because the parking lot reaches the FULL state after four vehicles.

Working
1. Empty Parking Lot
Occupied Slots : 0
Available Slots : 4
FULL            : 0

2. Vehicle Enters
When entry_sensor becomes HIGH:

Occupied Slots : 1
Available Slots : 3

The entry gate opens when space is available.

3. Parking Lot Full
After four vehicles enter:

Occupied Slots : 4
Available Slots : 0
FULL            : 1

The entry gate remains closed.

4. Vehicle Exits
When exit_sensor becomes HIGH:

Occupied Slots : 3
Available Slots : 1
FULL            : 0

The exit gate opens and the available-space count increases.

Simulation
Using Icarus Verilog:

iverilog -o parking_sim rtl/parking_lot_controller.v tb/tb_parking_lot_controller.v
vvp parking_sim

Expected behavior:

Available = 4
Vehicle enters
Available = 3

Vehicle enters
Available = 2

Vehicle enters
Available = 1

Vehicle enters
Available = 0
FULL = 1

Vehicle exits
Available = 1
FULL = 0

Vehicle enters
Available = 0
FULL = 1

Future Improvements
Seven-segment display for available slots
RFID/card-based vehicle identification
Automatic barrier control
Entry/exit sensor debouncing
Vehicle count display
Multiple parking zones
FSM-based gate controller
FPGA implementation
Buzzer when parking is full
Tools
Verilog HDL
Icarus Verilog
GTKWave
ModelSim / QuestaSim
Xilinx Vivado or Intel Quartus
