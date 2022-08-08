--!
--! File AND2.vhd
--! \brief And logic operation between 2 signals
--! \author Esquirol Charlotte
--! \version 0.1
--! \date May 2022
--!
--!
--!ADD design with :\n
--!      - 2 inputs signals : Din1, Din2 \n
--!      - 1 output signal : Dout (result of the operation and between Din1 and Din2)\n
--!\n
--! **behavior** 
--!      - Do a and logic operation

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

