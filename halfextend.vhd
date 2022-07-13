library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;



entity half_extend is



  Port (Din :  in STD_LOGIC_VECTOR (15 downto 0);
    	Dout : out STD_LOGIC_VECTOR (31 downto 0);
	unsigned1 : in STD_LOGIC);       


end half_extend;

architecture Behavioral of half_extend is

signal sig1 : STD_LOGIC_VECTOR ( 31 downto 0 );

alias MSB : std_logic is Din ( 15 );
alias sigsize : std_logic_vector is sig1 ( 15 downto 0 );
alias sigzero : std_logic_vector is sig1 ( 31 downto 8 );


begin

	process

	begin

	if ( unsigned1 = '1' or MSB = '0' ) then

		sigzero <= "0000000000000000";
		sigsize <= Din;
		Dout <= sig1;

	else 
		sigzero <= "1111111111111111"; 
		sigsize <= Din;
		Dout <= sig1;

	end if;

	end process;
		

end Behavioral;
