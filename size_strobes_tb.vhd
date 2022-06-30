library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;


entity size_strobes_tb is

end size_strobes_tb; 


architecture Behavioral of size_strobes_tb is

component size_strobes


  Port (size :  in STD_LOGIC_VECTOR (1 downto 0);
    	strobes : out STD_LOGIC_VECTOR (7 downto 0));

end component; 

     



signal sSIZE : STD_LOGIC_VECTOR(1 downto 0);

signal sSTROBES: STD_LOGIC_VECTOR (7 downto 0);


begin 



UUT : size_strobes port map ( size=>sSIZE, strobes=>sSTROBES );


process

    begin 

	-- On initialise

	sSIZE <= "00";
	wait for 30 ns;

	-- On teste une autre valeur

	sSIZE <= "01";
	wait for 30 ns;

	-- On teste une autre valeur

	sSIZE <= "10";
	wait for 30 ns;

	-- On teste une autre valeur

	sSIZE <= "11";
	wait for 30 ns;


end process;

end Behavioral;
