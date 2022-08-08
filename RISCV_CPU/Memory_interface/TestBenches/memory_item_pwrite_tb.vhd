--!
--! File memory_item_pwrite_tb.vhd
--! \brief  TestBench of the memory_item_pwrite part in memory interface ( link of the flipflop and 1 MUX )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!memory_item_pwrite_tb design with :\n
--!      - 3 input signals : clkA, wR_i, first_cycle \n
--!      - 1 output signal :  pwRITE \n
--!\n
--! **behavior** 
--!      - Test all the behaviours


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity memory_item_pwrite_tb is

end memory_item_pwrite_tb; 


architecture Behavioral of memory_item_pwrite_tb is

component memory_item_pwrite

generic (DWIDTH: natural := 32  );  -- Number of data bits per input/outp



  Port (first_cycle : in STD_LOGIC;
	CLKA : in STD_LOGIC;
	wr_i : in STD_LOGIC;
	PWRITE : out STD_LOGIC);

end component; 




signal sCLK, sfirst, swr, sPWRITE: STD_LOGIC; 

begin 

UUT : memory_item_pwrite port map ( CLKA=>sCLK, first_cycle=>sfirst, wr_i=>swr, PWRITE=>sPWRITE );
process 

    begin

    sCLK <='0';

        wait for 10 ns;

    sCLK <='1';

        wait for 10 ns;

    end process;


process

    begin 


	-- RESET


	-- On initialise




	swr<='1';
	sfirst<='1';
	wait for 30 ns; 

	----
	sfirst<='0'; 

	wait for 30 ns; 


	swr<='0';
	wait for 30 ns;

	----
	sfirst<='1';
	wait for 30 ns;

	swr<='1';
	wait for 30 ns;

	----




	
   
end process;

end Behavioral;
