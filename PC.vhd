library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity PC is


  Port (LoadVal : in STD_LOGIC_VECTOR ( 31 downto 0 );
	Load : in STD_LOGIC_VECTOR ( 31 downto 0 );
	PC_VAL: out STD_LOGIC_VECTOR ( 31 downto 0 );
	INC : in STD_LOGIC;
	CLK : in STD_LOGIC;
	RESET : in STD_LOGIC);


end PC;

architecture Behavioral of PC is

signal PLUSQ : STD_LOGIC_VECTOR ( 31 downto 0 );

	begin 

    		react: Process (reset, clk) is

    		begin
			PLUSQ <= "00000000000000000000000000000100";

    			if (reset = '1') then

         			 -- reset action here
         			PC_VAL <= "00000000000000000000000000000000";

     			elsif rising_edge(clk) then

					PC_VAL <= std_logic_vector((unsigned(LoadVal) + unsigned(PLUSQ))) when INC='1'
					else std_logic_vector(unsigned(Load));
			end if;

		end process react;

end architecture Behavioral;

