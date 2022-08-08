--! File shiftright.vhd
--! \brief shiftright logic operation 
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!shiftright design with :\n
--!      - 1 inputs signal : Din1 \n
--!      - 1 output signal : Dout (result of the operation )\n
--!\n
--! **behavior** 
--!      - Do a shiftright logic operation

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;




entity shiftright is

generic (
	NB_SR: natural := 2;   -- Number of shifts
	DWIDTHSR: natural := 8 );  -- Number of data bits per input/output

  Port (Din :  in STD_LOGIC_VECTOR (DWIDTHSR-1 downto 0);
        Dout : out STD_LOGIC_VECTOR (DWIDTHSR-1 downto 0));

       


end shiftright;

architecture Behavioral of shiftright is




begin

		 Dout <= std_logic_vector(unsigned(Din) srl NB_SR);


end Behavioral;

