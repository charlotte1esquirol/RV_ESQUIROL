Here is the Contro Unit part. It takes a 32-bits instruction for input and links the InstrNumber, the AddressCounter, two MUXs and the ROM_Memory.
The result ( output ) is a 32-bit control_signal. This signal after goes in the fetchhing_size module and in the iPC_control module. 
These signals were not in the Control Unit schematic because we have added them at the end, to adjust the design in order to make him does what we want to. 
The fetching module verify if we are in a fetching phase or not. If we are, PSTRB need to be "1111", so the input size of the Memory_interface need to be "11" and this is linked with the control_signal.
The iPC_control verify that if (not(membusy) or not(waitmem) ) is not a 1, iPC is well a 0.