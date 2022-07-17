library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity memory_item_pwdata_tb is

end memory_item_pwdata_tb; 


architecture Behavioral of memory_item_pwdata_tb is

component memory_item_pwdata

  Port (wdata_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
	first_cycle : in STD_LOGIC;
	CLK_pwdata : in STD_LOGIC;
	op2 : in STD_LOGIC;
	ALIGNEMENT : in STD_LOGIC_VECTOR ( 1 downto 0 );
	PWDATA : out STD_LOGIC_VECTOR ( 31 downto 0));

end component; 

signal sALIGN: STD_LOGIC_VECTOR(1 downto 0);
signal sPWDATA : STD_LOGIC_VECTOR(31 downto 0);
signal sWDATA: STD_LOGIC_VECTOR(31 downto 0);
signal sfirst, sCLK, sop2: STD_LOGIC; 

begin 

UUT : memory_item_pwdata port map ( CLK_pwdata=>sCLK, op2=>sop2, PWDATA=>sPWDATA, wdata_i=>sWDATA, ALIGNEMENT=>sALIGN, first_cycle=>sfirst );

process 

    begin

    sCLK <='0';

        wait for 10 ns;

    sCLK <='1';

        wait for 10 ns;

    end process;


process

    begin 

	-- On initialise



	sWDATA<="00000000000000001111111111111111";
	sfirst<='1';
	sop2<='1';
	sALIGN<="00";
	wait for 30 ns; 

	----
	sWDATA<="11110000000000001111111111111111";
	sALIGN<="01";
	wait for 30 ns;

	----
	sWDATA<="00000000000000001111111111000000";
	sALIGN<="10";
	wait for 30 ns;

	-----

	sALIGN<="11";
	sop2<='0';
	wait for 50 ns;

	----

	sfirst<='0';
	wait for 20 ns;

	sWDATA<="00000000000000000000000011111111";
	sALIGN<="01";
	wait for 30 ns;

	----

	sWDATA<="00000000000000000011001100110011";
	sALIGN<="10";
	wait for 30 ns;

	-----

	sALIGN<="11";

	wait for 50 ns;

	
   
end process;

end Behavioral;
