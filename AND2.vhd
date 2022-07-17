library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;



entity AND2 is



  Port (Din1 :  in STD_LOGIC;
	Din2 : in STD_LOGIC;
    	Dout : out STD_LOGIC);       


end AND2 ;

architecture Behavioral of AND2 is




begin
	process (Din1, Din2)

	begin

	if ( (Din1 and Din2) = '1' ) then
		Dout <= '1';
	else 
		Dout <= '0';
	end if;

	end process;

end Behavioral;

