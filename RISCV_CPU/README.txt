This file contains all the blocks that form the RISCV CPU. 
First we have the PC part, with TargetAddress, WritePC, 2 MUXs and the PC.
Then we have the ControlUnit part with the ControlUnit, IR and Immediate.
We have also the ALU part, with the ALU and 2 MUXs.
Finally, we have the MemoryInterface part, the Regfile(Regfile_2_clock_edge) bloc and 2 MUXs.
All that are linked together to obtain the Master used in the amba protocol. 
The block that links all these parts, which is called the Master in the amba specification is called here RV_1_1.vhd.
