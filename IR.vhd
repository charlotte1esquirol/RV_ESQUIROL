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

