
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity ALU_0_tb is

end ALU_0_tb;


architecture Behavioral of ALU_0_tb is

component ALU_0

generic (
	DWIDTH: natural := 32  );  -- Number of data bits per input/output

Port ( SELOPALU : in STD_LOGIC_VECTOR (3 downto 0);
       ALU_VALUE : out STD_LOGIC_VECTOR (DWIDTH-1 downto 0);
       OP1A : in STD_LOGIC_VECTOR (DWIDTH-1 downto 0);
       OP2A : in STD_LOGIC_VECTOR (DWIDTH-1 downto 0));

end component;

     
constant N : natural := 32;
signal sALU_VALUE,sOP1,sOP2 : STD_LOGIC_VECTOR(N-1 downto 0);

signal sSELOPALU : STD_LOGIC_VECTOR(3 downto 0);




begin



UUT : ALU_0 generic map (DWIDTH=>N) port map (  ALU_VALUE=>sALU_VALUE, OP1A=>sOP1, OP2A=>sOP2, SELOPALU=>sSELOPALU );



process

    begin


	sOP1 <= "00000000000000000000000000000111";
	sOP2 <= "00000000000000000000000000000001";
   	sSELOPALU <= "0001";
	wait for 20 ns;
     
     	sSELOPALU <= "0101";
      	wait for 20 ns;
     
      	sSELOPALU <= "0110";
      	wait for 20 ns;
 
     	sSELOPALU <= "0111";
      	wait for 20 ns;
     
     	sSELOPALU <= "1011";
      	wait for 20 ns;
     
      	sSELOPALU <= "0000";
      	wait for 20 ns; 

     end process;

end architecture Behavioral;

       


