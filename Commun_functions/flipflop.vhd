--! File flipflop.vhd
--! \brief Common FlipFlop
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!flipflop design with :\n
--!      - 3 input signals : clk, d, load \n
--!      - 1 output signal : q \n
--!\n
--! **behavior** 
--!      - If load is a 1, d is copied in q at a rising edge. If load is a 0, q doesn't change.


library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;




entity flipflop is

  Port (D :  in STD_LOGIC;
        LOAD : in STD_LOGIC;
    	CLK : in STD_LOGIC;
	Q : out STD_LOGIC);
       


end flipflop;

architecture Behavioral of flipflop is


begin

    react: Process (clk) is

    begin


	if ( rising_edge(CLK) ) then

		if (LOAD='1') then

			Q<=D;

		end if;

	end if;

	end process react;

end Behavioral;

