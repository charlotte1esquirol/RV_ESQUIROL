--! File shiftright_tb.vhd
--! \brief TestBench of the shiftright logic operation 
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!shiftright_tb design with :\n
--!      - 1 inputs signal : Din1 \n
--!      - 1 output signal : Dout (result of the operation )\n
--!\n
--! **behavior** 
--!      -  Test all the behaviours

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;


entity shiftright_tb is

end shiftright_tb; 


architecture Behavioral of shiftright_tb is

component shiftright

generic (
	A: natural := 2;   -- Number of shifts
	DWIDTH: natural := 8 );  -- Number of data bits per input/output

  Port (Din :  in STD_LOGIC_VECTOR (DWIDTH-1 downto 0);
        Dout : out STD_LOGIC_VECTOR (DWIDTH-1 downto 0));

end component; 

     

constant B : natural := 4;
constant N : natural := 8;


signal sDin, sDout : STD_LOGIC_VECTOR(N-1 downto 0);


begin 



UUT : shiftright generic map (A=>B, DWIDTH=>N) port map (Din=>sDin, Dout=>sDout);



process

    begin 

	-- On initialise

	sDin <= "11111111";
	

	wait for 30 ns;

	


end process;

end Behavioral;
