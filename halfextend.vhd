library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;



entity half_extend is



  Port (Din :  in STD_LOGIC_VECTOR (15 downto 0);
    	Dout : out STD_LOGIC_VECTOR (31 downto 0);
	unsigned1 : in STD_LOGIC);       


end half_extend;

architecture Behavioral of half_extend is



alias MSB : std_logic is Din ( 15 );
alias sigsize : std_logic_vector is Dout ( 15 downto 0 );
alias sigzero : std_logic_vector is Dout ( 31 downto 16 );


begin

	process ( Din, unsigned1 )

	begin

	if ( unsigned1 = '1' or MSB = '0' ) then

		sigzero <= "0000000000000000";
		sigsize <= Din;


	else 
		sigzero <= "1111111111111111"; 
		sigsize <= Din;


	end if;

	end process;
		

end Behavioral;

