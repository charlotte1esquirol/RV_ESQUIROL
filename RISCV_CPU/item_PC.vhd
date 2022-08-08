--!
--! File item_PC.vhd
--! \brief item_PC part ( link of the PC, the TargetAddress, the WritePC and 2 MUXs )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!item_PC design with :\n
--!      - 9 input signals : clk_pc, rst_pc, iPC, Bim_PC, Jim_PC, rs1_PC, sel1PC, sel2PC, wPC\n
--!      - 1 output signal : PC_value \n
--!\n
--! **behavior** 
--!      - It links some others blocs

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity item_PC is


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



end item_PC;

architecture Behavioral of item_PC is


	constant DWIDTH32 : natural := 32;
	constant DWIDTH20 : natural := 20;



	component TargetAddress

  Port (DATA0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
	DATA1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
	TARGET_PC : out STD_LOGIC_VECTOR ( 31 downto 0 ));
 

	end component TargetAddress;

	component PC

  Port (LoadVal : in STD_LOGIC_VECTOR ( 31 downto 0 );
	Load : in STD_LOGIC;
	PC_VAL: out STD_LOGIC_VECTOR ( 31 downto 0 );
	INC : in STD_LOGIC;
	CLK : in STD_LOGIC;
	RESET : in STD_LOGIC);

	end component PC;

	component MUX2TO1

generic (
	DWIDTH: natural := 32  );  -- Number of data bits per input/output

port (
	SEL: in std_logic;
	DATA0: in std_logic_vector (DWIDTH-1 downto 0);
	DATA1: in std_logic_vector (DWIDTH-1 downto 0);
	RESULT: out std_logic_vector (DWIDTH-1 downto 0));

	end component MUX2TO1 ;




signal OUT_MUX1 : STD_LOGIC_VECTOR ( 31 downto 0 );
signal OUT_MUX2 : STD_LOGIC_VECTOR ( 31 downto 0 );
signal TargetPC : STD_LOGIC_VECTOR ( 31 downto 0 );
signal Count : STD_LOGIC_VECTOR ( 31 downto 0 );








begin

	
	TargetAddress1 : TargetAddress port map ( DATA0=>OUT_MUX1, DATA1=>OUT_MUX2, TARGET_PC=>TargetPC );
	UUTPC : PC  port map (LoadVal=>TargetPC, Load=>wPC, INC=>iPC, CLK=>CLK_PC, RESET=>RST_PC, PC_VAL=>Count);
	mux1 : MUX2TO1 generic map (DWIDTH=>DWIDTH32) port map ( DATA0=>Count, DATA1=>rs1_PC, RESULT=>OUT_MUX1, SEL=>sel1PC); 
	mux2 : MUX2TO1 generic map (DWIDTH=>DWIDTH32) port map ( DATA0=>Bim_PC, DATA1=>Jim_PC, RESULT=>OUT_MUX2, SEL=>sel2PC); 

	PC_value <= Count;

	
end architecture Behavioral;

