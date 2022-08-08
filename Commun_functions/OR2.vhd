--!
--! File OR2.vhd
--! \brief OR logic operation between 2 signals
--! \author Esquirol Charlotte
--! \version 0.1
--! \date May 2022
--!
--!
--!OR2 design with :\n
--!      - 2 inputs signals : Din1, Din2 \n
--!      - 1 output signal : Dout (result of the operation and between Din1 or Din2)\n
--!\n
--! **behavior** 
--!      - Do a or logic operation

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
	process ( Din1, Din2 )

	begin

	if ( (Din1 or Din2) = '1' ) then
		Dout <= '1';
	else 
		Dout <= '0';
	end if;

	end process;

end Behavioral;

