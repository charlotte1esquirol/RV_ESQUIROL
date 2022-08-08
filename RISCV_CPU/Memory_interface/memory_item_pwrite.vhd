--!
--! File memory_item_pwrite.vhd
--! \brief  memory_item_pwrite part in memory interface ( link of the flipflop and 1 MUX )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!memory_item_pwRITE design with :\n
--!      - 3 input signals : clkA, wR_i, first_cycle \n
--!      - 1 output signal :  pwRITE \n
--!\n
--! **behavior** 
--!      - It links some others blocs

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity memory_item_pwrite is


  Port (first_cycle : in STD_LOGIC;
	CLKA : in STD_LOGIC;
	wr_i : in STD_LOGIC;
	PWRITE : out STD_LOGIC);


end memory_item_pwrite;

architecture Behavioral of memory_item_pwrite is

	constant B : natural := 1;
	constant N : natural := 1;

	component flipflop

  Port (D :  in STD_LOGIC;
        LOAD : in STD_LOGIC;
    	CLK : in STD_LOGIC;
	Q : out STD_LOGIC);

	end component flipflop;

	component MUX2TO1single



  Port (
	SEL: in std_logic;
	DATA0: in std_logic;
	DATA1: in std_logic;
	RESULT: out std_logic);
	
	end component MUX2TO1single;



signal inputQ: STD_LOGIC;



begin

	
	mux1 : MUX2TO1single generic map (DWIDTH=>N) port map (SEL=>first_cycle, DATA1=>wr_i, DATA0=>inputQ, RESULT=>PWRITE);
	regiister1 : flipflop port map (D=>wr_i, LOAD=>first_cycle, CLK=>CLKA, Q=>inputQ);

	
end architecture Behavioral;

