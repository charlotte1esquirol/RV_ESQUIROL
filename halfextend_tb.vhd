library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity half_extend_tb is

end half_extend_tb;


architecture Behavioral of half_extend_tb is

component half_extend

  Port (Din :  in STD_LOGIC_VECTOR (15 downto 0);
    	Dout : out STD_LOGIC_VECTOR (31 downto 0);
	unsigned1 : in STD_LOGIC);          

end component;

     

signal sDin: STD_LOGIC_VECTOR(15 downto 0);
signal sDout: STD_LOGIC_VECTOR(31 downto 0);
signal suns : STD_LOGIC;




begin



UUT : half_extend port map (  Din=>sDin, Dout=>sDout, unsigned1=>suns);



process

    begin


	sDin <= "0000000000000001";
	suns<='0';
	wait for 30 ns;
     
	sDin <= "1000000000000001";
	suns<='0';
	wait for 30 ns;

	sDin <= "0000000000000001";
	suns<='1';
	wait for 30 ns;

	sDin <= "1000000000000001";
	suns<='1';
	wait for 30 ns;

     end process;

end architecture Behavioral;

       


