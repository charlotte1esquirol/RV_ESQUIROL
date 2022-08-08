--!
--! File item_PC_tb.vhd
--! \brief TestBench of the item_PC part ( link of the PC, the TargetAddress, the WritePC and 2 MUXs )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!item_PC_tb design with :\n
--!      - 9 input signals : clk_pc, rst_pc, iPC, Bim_PC, Jim_PC, rs1_PC, sel1PC, sel2PC, wPC\n
--!      - 1 output signal : PC_value \n
--!\n
--! **behavior** 
--!      - Test all the behaviours

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity item_PC_tb is

end item_PC_tb; 


architecture Behavioral of item_PC_tb is

component item_PC

  Port (
	iPC : in STD_LOGIC;
	CLK_PC : in STD_LOGIC;
	RST_PC : in STD_LOGIC;
	Bim_PC : in STD_LOGIC_VECTOR( 31 downto 0 );
	Jim_PC : in STD_LOGIC_VECTOR ( 31 downto 0 );
	rs1_PC : in STD_LOGIC_VECTOR ( 31 downto 0 );
	sel1PC : in STD_LOGIC;
	sel2PC : in STD_LOGIC;
	wPC : in STD_LOGIC;
	PC_value : out STD_LOGIC_VECTOR ( 31 downto 0));



end component; 

     


signal sB, sJ, sRS1, sPC_VAL: STD_LOGIC_VECTOR(31 downto 0);

signal siPC, sCLK, sRST, sSEL1, sSEL2, swPC: STD_LOGIC; 



begin 



UUT : item_PC port map ( iPC=>siPC, sel1PC=>sSEL1, sel2PC=>sSEL2, wPC=>swPC, CLK_PC=>sCLK, RST_PC=>sRST, Bim_PC=>sB, Jim_PC=>sJ, rs1_PC=>sRS1, PC_value=>sPC_VAL );

process 

    begin

    sCLK <='0';

        wait for 10 ns;

    sCLK <='1';

        wait for 10 ns;

    end process;


process

    begin 

	-- On reset pour bien demarrer

	sRST<='0';
	wait for 30 ns;

	-- On initialise

	sRST<='1';
	sB<="00000000000000000000000000000000";
	sJ<="11111111111111111111111111111111";
	sRS1<="00000000000000001111111111111111";
	swPC<='0';
	sSEL1<='0';
	sSEL2<='0';
	siPC<='0';
	wait for 30 ns; 

	siPC<='1';
	wait for 30 ns;

	sSEL1<='1';
	sSEL2<='1';
	wait for 30 ns;

	--siPC<='0';
	--wait for 30 ns;

	--swPC<='1';
	--wait for 50 ns;



	
   
end process;

end Behavioral;
