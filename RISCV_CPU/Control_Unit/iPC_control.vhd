--!
--! File iPC_control.vhd
--! \brief iPC_control bloc of the Control Unit of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!iPC_control design with :\n
--!      - 3 input signals : CONTROL, waitmem, membusy\n
--!      - 1 output signal : CONTROLSIG\n
--!\n
--! **behavior** 
--!      - Take the bit 5 of the output, which is the signal iPC. \n
--!      - Modify this bit to '0' if not(membusy='0' or waitmem='0') is a 1. If (membusy='0' or waitmem='0') is a 1, iPC doesn't change.  \n
--!


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;





entity iPC_Control is

  Port (CONTROL :  in STD_LOGIC_VECTOR(31 downto 0);
	WaitMem : in STD_LOGIC;
	MemBusy : in STD_LOGIC;
        CONTROLSIG :out STD_LOGIC_VECTOR(31 downto 0));
       


end iPC_Control;

architecture Behavioral of iPC_Control is

alias iPC : std_logic is CONTROLSIG ( 5 );

begin

    react: Process (WaitMem, MemBusy, CONTROL) is

    begin

	if (WaitMem='0' or MemBusy='0') then

		CONTROLSIG<=CONTROL;
	else
		iPC<='0';

	end if;

	end process react;

end Behavioral;

