library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;



entity zero_extend is



  Port (Din :  in STD_LOGIC_VECTOR (31 downto 0);
    	Dout : out STD_LOGIC_VECTOR (63 downto 0));       


end zero_extend;

architecture Behavioral of zero_extend is

signal sig1 : STD_LOGIC_VECTOR ( 63 downto 0 );
alias sigsize : std_logic_vector is sig1 ( 31 downto 0 );
alias sigzero : std_logic_vector is sig1 ( 63 downto 32 );


begin

	sigzero <= "00000000000000000000000000000000";
	sigsize <= Din;
	Dout <= sig1;
		

end Behavioral;

