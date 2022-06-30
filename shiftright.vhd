library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;




entity shiftright is

generic (
	A: natural := 2;   -- Number of shifts
	DWIDTH: natural := 8 );  -- Number of data bits per input/output

  Port (Din :  in STD_LOGIC_VECTOR (DWIDTH-1 downto 0);
        Dout : out STD_LOGIC_VECTOR (DWIDTH-1 downto 0));

       


end shiftright;

architecture Behavioral of shiftright is




begin

		 Dout <= std_logic_vector(unsigned(Din) srl A);


end Behavioral;

