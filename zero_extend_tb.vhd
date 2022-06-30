library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;


entity zero_extend_tb is

end zero_extend_tb; 


architecture Behavioral of zero_extend_tb is

component zero_extend


  Port (Din :  in STD_LOGIC_VECTOR (31 downto 0);
    	Dout : out STD_LOGIC_VECTOR (63 downto 0));

end component; 

     



signal sIN : STD_LOGIC_VECTOR(31 downto 0);

signal sOUT: STD_LOGIC_VECTOR (63 downto 0);


begin 



UUT : zero_extend port map ( Din=>sIN, Dout=>sOUT );


process

    begin 

	-- On initialise

	sIN <= "11111111111111111111111111111111";
	wait for 30 ns;

	-- On teste une autre valeur

	sIN <= "11111111111111111111111111111000";
	wait for 30 ns;


end process;

end Behavioral;
