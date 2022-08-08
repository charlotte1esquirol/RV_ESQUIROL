--!
--! File ADD2.vhd
--! \brief Addition between 2 signals
--! \author Esquirol Charlotte
--! \version 0.1
--! \date May 2022
--!
--!
--!ADD design with :\n
--!      - 2 input signals : Din1, Din2 \n
--!      - 1 output signal : Dout (result of the operation add between Din1 and Din2)\n
--!\n
--! **behavior** 
--!      - Do a add arithmetic operation



library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;



entity ADD2 is



  Port (Din1 :  in STD_LOGIC_VECTOR ( 29 downto 0 );
	Din2 : in STD_LOGIC_VECTOR ( 29 downto 0 );
    	Dout : out STD_LOGIC_VECTOR ( 29 downto 0 ));       


end ADD2 ;

architecture Behavioral of ADD2 is




begin


		Dout <= std_logic_vector((unsigned(Din1) + unsigned(Din2)));


end Behavioral;

