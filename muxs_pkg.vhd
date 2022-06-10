library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


package muxs_pkg is


	component MUXs 

	  generic (
		  DWIDTH: natural := 32  );  -- Number of data bits per input/output

		Port  (OP1 : in STD_LOGIC_VECTOR (DWIDTH-1 downto 0);
     			OP2 : in STD_LOGIC_VECTOR (DWIDTH-1 downto 0));

	end component;

end muxs_pkg;

     
--constant N : natural := 32;
--signal sOP1,sOP2 : STD_LOGIC_VECTOR(N-1 downto 0);


--begin



--UUT : MUXs generic map (DWIDTH=>N) port map (OP1=>sOP1, OP2=>sOP2);

--end Behavioral;

