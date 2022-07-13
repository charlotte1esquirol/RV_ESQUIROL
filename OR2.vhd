library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;



entity OR2 is



  Port (Din1 :  in STD_LOGIC;
	Din2 : in STD_LOGIC;
    	Dout : out STD_LOGIC);       


end OR2 ;

architecture Behavioral of OR2 is




begin
	process

	begin

	if ( (Din1 or Din2) = '1' ) then
		Dout <= '1';
	else 
		Dout <= '0';
	end if;

	end process;

end Behavioral;

