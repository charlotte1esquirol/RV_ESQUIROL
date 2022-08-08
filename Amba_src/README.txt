This part is the part corresponding to the amba-protocol.
It links the Master ( called RV_1_1 ), the Slave(s) ( here Data_Memory and InstrMemory ), the Slave_Decoder and 2 MUXs.
For now, we only have done the tests with only one slave : InstrMemory.
DataMemory is to do.
Be carreful to change the package rv_esquirol2_pkg.vhd to correspond with the number of slaves.