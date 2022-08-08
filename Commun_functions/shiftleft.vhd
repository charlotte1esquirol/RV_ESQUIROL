--! File shiftleft.vhd
--! \brief shiftleft logic operation 
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!shiftleft design with :\n
--!      - 1 inputs signal : Din1 \n
--!      - 1 output signal : Dout (result of the operation )\n
--!\n
--! **behavior** 
--!      - Do a shiftleft logic operation

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;




entity shiftleft is

generic (
	NB_SL: natural := 2;   -- Number of shifts
	DWIDTHSL: natural := 8 );  -- Number of data bits per input/output

  Port (Din :  in STD_LOGIC_VECTOR (DWIDTHSL-1 downto 0);
        Dout : out STD_LOGIC_VECTOR (DWIDTHSL-1 downto 0));

       


end shiftleft;

architecture Behavioral of shiftleft is




begin

		 Dout <= std_logic_vector(unsigned(Din) sll NB_SL);


end Behavioral;

