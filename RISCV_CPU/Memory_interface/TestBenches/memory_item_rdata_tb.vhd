--!
--! File memory_item_rdata_tb.vhd
--! \brief  TestBench of the memory_item_rdata part in memory interface ( link of the zeroextend, the shiftright, the register, the byteextend, the halfextend, the AND and 3 MUXs )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!memory_item_rdata_tb design with :\n
--!      - 8 input signals : clk_rdata, PRDATA, PREADY, op1, unsigned_i, size_i, op2, alignement_reg \n
--!      - 2 output signals :  rdata_o, rdata_unbuff_o \n
--!\n
--! **behavior** 
--!      - Test all the behaviours


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity memory_item_rdata_tb is

end memory_item_rdata_tb; 


architecture Behavioral of memory_item_rdata_tb is

component memory_item_rdata

  Port (PRDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
	CLK_rdata : in STD_LOGIC;
	PREADY : in STD_LOGIC;
	op1 : in STD_LOGIC;
	op2 : in STD_LOGIC;
	unsigned_i : in STD_LOGIC;
	size_i : in STD_LOGIC_VECTOR ( 1 downto 0 );
	ALIGNEMENT_REG : in STD_LOGIC_VECTOR ( 1 downto 0 );
	rdata_o : out STD_LOGIC_VECTOR ( 31 downto 0);
	rdata_unbuff_o : out STD_LOGIC_VECTOR ( 31 downto 0));
end component; 

signal sALIGNR, sSIZE: STD_LOGIC_VECTOR(1 downto 0);
signal srdata, sPRDATA : STD_LOGIC_VECTOR(31 downto 0);
signal srdatau: STD_LOGIC_VECTOR(31 downto 0);
signal sCLK, sop2, sop1, sun, sPREADY: STD_LOGIC; 

begin 

UUT : memory_item_rdata port map ( CLK_rdata=>sCLK, op2=>sop2, size_i=>sSIZE, op1=>sop1, PRDATA=>sPRDATA, unsigned_i=>sun, ALIGNEMENT_REG=>sALIGNR, PREADY=>sPREADY, rdata_o=>srdata, rdata_unbuff_o=>srdatau );

process 

    begin

    sCLK <='0';

        wait for 10 ns;

    sCLK <='1';

        wait for 10 ns;

    end process;


process

    begin 

	-- On initialise



	sPRDATA<="00000000000000001111111111111111";
	sPREADY<='1';
	sop2<='1';
	sop1<='1';
	sALIGNR<="00";
	sun<='1';
	sSIZE<="00";
	wait for 30 ns; 

	----
	sPRDATA<="11110000000000001111111111111111";
	sALIGNR<="01";
	sSIZE<="01";
	wait for 30 ns;

	----
	sPRDATA<="00000000000000001111111111000000";
	sun<='0';
	wait for 30 ns;

	sPRDATA<="00000000000000000000000011111111";
	sop2<='0';
	wait for 30 ns;

	----

	sPRDATA<="00000000000000000011001100110011";
	sop1<='0';
	wait for 30 ns;

	sPRDATA<="00000000000000000011001100110011";
	sPREADY<='0';
	wait for 50 ns;


	
   
end process;

end Behavioral;
