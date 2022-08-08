Here is the two part of the ALU part. First you have the ALU only :

ALU_0 design with :
3 input signals : op1, op2 and selopalu (selects the operation to be performed. Alternative 2 with 11 different operations)
2 output signals : alu_value (result of the operation between op1 and op2) and flags (implementation 2)

Behavior :
Defines the kind of operation to be performed according to the value of selopalu, writes the result in alu_value and produces flags.
There are 10 working operations : +, - (signed or unsigned), bitwise operations (^ | &), op1, op2, right and left shift on op1 where the shift amount is the less 5 bits of op2.

After that, you have the ALU linked with the two multiplexers that chose the inputs of the ALU.

Flags need to be implemented. 