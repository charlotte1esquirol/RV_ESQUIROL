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

