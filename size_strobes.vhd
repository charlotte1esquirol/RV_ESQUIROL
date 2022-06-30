library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;



entity size_strobes is



  Port (size :  in STD_LOGIC_VECTOR (1 downto 0);
    	strobes : out STD_LOGIC_VECTOR (7 downto 0));       


end size_strobes;

architecture Behavioral of size_strobes is

signal sig1 : STD_LOGIC_VECTOR ( 7 downto 0 );
alias sigsize : std_logic_vector is sig1 ( 7 downto 6 );
alias sigzero : std_logic_vector is sig1 ( 5 downto 0 );


begin

	sigzero <= "000000";
	sigsize <= size;
	strobes <= sig1;
		

end Behavioral;

