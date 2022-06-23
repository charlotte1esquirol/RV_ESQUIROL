library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;



entity SlaveDecodeur is

generic (A: natural := 8  );  -- Number of data bits per input/output

  Port (ADDRESS :  in STD_LOGIC_VECTOR (A-1 downto 0);
        ENABLE : in STD_LOGIC;
    	SEL : out STD_LOGIC_VECTOR ((log2(A)-1) downto 0);
	NUM_SLAVE : out STD_LOGIC_VECTOR ( log2((log2(A)-1)) downto 0));
       


end SlaveDecodeur;

architecture Behavioral of SlaveDecodeur is


begin



end architecture Behavioral;

