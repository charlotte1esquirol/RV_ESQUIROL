--!
--! File IR.vhd
--! \brief IR bloc of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!IR design with :\n
--!      - 4 input signals : clk, loadval, wIR, membusy \n
--!      - 1 output signal : valeur\n
--!\n
--! **behavior** 
--!      - It works like a flip-flop \n
--!      - If (wIR='1' and membusy='0') is a 1, loadval is copied in valeur at a rising edge. If (wIR='1' and membusy='0') is a 0, valeur doesn't change \n
--!



library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;




entity IR is

  Port (LOADVAL :  in STD_LOGIC_VECTOR(31 downto 0);
        wIR : in STD_LOGIC;
	MemBusy : in STD_LOGIC;
    	CLK : in STD_LOGIC;
	VALEUR : out STD_LOGIC_VECTOR(31 downto 0));
       


end IR;

architecture Behavioral of IR is


begin

    react: Process (clk) is

    begin


	if ( rising_edge(CLK) ) then

		if (wIR='1' and MemBusy='0') then

			VALEUR<=LOADVAL;

		end if;

	end if;

	end process react;

end Behavioral;

