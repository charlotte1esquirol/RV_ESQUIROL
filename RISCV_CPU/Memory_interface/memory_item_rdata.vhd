--!
--! File memory_item_rdata.vhd
--! \brief  memory_item_rdata part in memory interface ( link of the zeroextend, the shiftright, the register, the byteextend, the halfextend, the AND and 3 MUXs )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!memory_item_rdata design with :\n
--!      - 8 input signals : clk_rdata, PRDATA, PREADY, op1, unsigned_i, size_i, op2, alignement_reg \n
--!      - 2 output signals :  rdata_o, rdata_unbuff_o \n
--!\n
--! **behavior** 
--!      - It links some others blocs


library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity memory_item_rdata is


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


end memory_item_rdata;

architecture Behavioral of memory_item_rdata is


	constant DWIDTH64 : natural := 64;
	constant DWIDTH32 : natural := 32;
	constant SR8 : natural := 8;
	constant SR16 : natural := 16;
	constant SR24 : natural := 24;
	constant DWIDTHSR64 : natural := 64;
	constant B32 : natural := 32;


	component zero_extend

  Port (Din :  in STD_LOGIC_VECTOR (31 downto 0);
    	Dout : out STD_LOGIC_VECTOR (63 downto 0));  

	end component zero_extend;

	component MUX2TO1 

generic (
	DWIDTH: natural := 32  );  -- Number of data bits per input/output

port (
	SEL: in std_logic;
	DATA0: in std_logic_vector (DWIDTH-1 downto 0);
	DATA1: in std_logic_vector (DWIDTH-1 downto 0);
	RESULT: out std_logic_vector (DWIDTH-1 downto 0));

	end component MUX2TO1;

	component registera 

  generic (A: natural := 8  );  -- Number of data bits per input/output

  Port (D :  in STD_LOGIC_VECTOR (A-1 downto 0);
        LOAD : in STD_LOGIC;
    	CLK : in STD_LOGIC;
	Q : out STD_LOGIC_VECTOR (A-1 downto 0));

	end component registera ;

	component AND2

  Port (Din1 :  in STD_LOGIC;
	Din2 : in STD_LOGIC;
    	Dout : out STD_LOGIC); 	

	end component AND2;


	component shiftright

generic (
	NB_SR: natural := 2;   -- Number of shifts
	DWIDTHSR: natural := 8 );  -- Number of data bits per input/output

  Port (Din :  in STD_LOGIC_VECTOR (DWIDTHSR-1 downto 0);
        Dout : out STD_LOGIC_VECTOR (DWIDTHSR-1 downto 0));

       	end component shiftright;

	component MUX4TO1 

generic (
	DWIDTH: natural := 32  );  -- Number of data bits per input/output

port (
	SEL: in std_logic_vector (1 downto 0) ;
	DATA0: in std_logic_vector (DWIDTH-1 downto 0);
	DATA1: in std_logic_vector (DWIDTH-1 downto 0);
	DATA2: in std_logic_vector (DWIDTH-1 downto 0);
	DATA3: in std_logic_vector (DWIDTH-1 downto 0);
	RESULT: out std_logic_vector (DWIDTH-1 downto 0));

	end component MUX4TO1;

	component byte_extend

  Port (Din :  in STD_LOGIC_VECTOR (7 downto 0);
    	Dout : out STD_LOGIC_VECTOR (31 downto 0);
	unsigned1 : in STD_LOGIC);   

       	end component byte_extend;

	component half_extend

  Port (Din :  in STD_LOGIC_VECTOR (15 downto 0);
    	Dout : out STD_LOGIC_VECTOR (31 downto 0);
	unsigned1 : in STD_LOGIC); 

       	end component half_extend;

	component MUX3TO1 

generic (
	DWIDTH: natural := 32  );  -- Number of data bits per input/output

port (
	SEL: in std_logic_vector (1 downto 0) ;
	DATA0: in std_logic_vector (DWIDTH-1 downto 0);
	DATA1: in std_logic_vector (DWIDTH-1 downto 0);
	DATA2: in std_logic_vector (DWIDTH-1 downto 0);
	RESULT: out std_logic_vector (DWIDTH-1 downto 0));

	end component MUX3TO1;




signal RDATA64A : STD_LOGIC_VECTOR ( 63 downto 0 );
signal OUT_AND : std_logic;
signal RDATA64B : STD_LOGIC_VECTOR ( 63 downto 0 );
alias RDATA_1 : std_logic_vector(31 downto 0) is RDATA64B(63 downto 32);
alias RDATA_2 : std_logic_vector(31 downto 0) is RDATA64B(31 downto 0);
signal RDATA64 : STD_LOGIC_VECTOR ( 63 downto 0 );

signal RD_SR8 : STD_LOGIC_VECTOR ( 63 downto 0 );
signal RD_SR16 : STD_LOGIC_VECTOR ( 63 downto 0 );
signal RD_SR24 : STD_LOGIC_VECTOR ( 63 downto 0 );
alias RD8 : std_logic_vector(31 downto 0) is RD_SR8(31 downto 0);
alias RD16 : std_logic_vector(31 downto 0) is RD_SR16(31 downto 0);
alias RD24 : std_logic_vector(31 downto 0) is RD_SR24(31 downto 0);
alias RD : std_logic_vector(31 downto 0) is RDATA64(31 downto 0);

signal RDSR : STD_LOGIC_VECTOR ( 31 downto 0 );
alias RDSR_1 : std_logic_vector(7 downto 0) is RDSR(7 downto 0);
alias RDSR_2 : std_logic_vector(15 downto 0) is RDSR(15 downto 0);

signal RD_bex : STD_LOGIC_VECTOR ( 31 downto 0 );
signal RD_hex : STD_LOGIC_VECTOR ( 31 downto 0 );

signal OUT_MUX1 : STD_LOGIC_VECTOR ( 31 downto 0 );
signal fin : STD_LOGIC_VECTOR ( 31 downto 0 );







begin

	
	zeroextend : zero_extend port map ( Din=>PRDATA, Dout=>RDATA64A );
	mux2to1_1 : MUX2TO1 generic map (DWIDTH=>DWIDTH64) port map (SEL=>op2, DATA0=>RDATA64A, DATA1=>RDATA64B, RESULT=>RDATA64);
	register1 : registera generic map (A=>B32) port map ( D=>PRDATA, LOAD=>OUT_AND, CLK=>CLK_rdata, Q=>RDATA_2 ); 
	and2_1 : and2 port map ( Din1=>op1, Din2=>PREADY, Dout=>OUT_AND );
	shiftright8 : shiftright generic map (DWIDTHSR=>DWIDTHSR64, NB_SR=>SR8) port map ( Din=>RDATA64, Dout=>RD_SR8 );
	shiftright16 : shiftright generic map (DWIDTHSR=>DWIDTHSR64, NB_SR=>SR16) port map ( Din=>RDATA64, Dout=>RD_SR16 );
	shiftright24 : shiftright generic map (DWIDTHSR=>DWIDTHSR64, NB_SR=>SR24) port map ( Din=>RDATA64, Dout=>RD_SR24 );
	mux4to1_1 : MUX4TO1 generic map (DWIDTH=>DWIDTH32) port map (SEL=>ALIGNEMENT_REG, DATA0=>RD, DATA1=>RD8, DATA2=>RD16, DATA3=>RD24, RESULT=>RDSR);
	byteextend : byte_extend port map ( Din=>RDSR_1, Dout=>RD_bex, unsigned1=>unsigned_i); 
	halfextend : half_extend port map ( Din=>RDSR_2, Dout=>RD_hex, unsigned1=>unsigned_i); 
	mux3to1_1 : MUX3TO1 generic map (DWIDTH=>DWIDTH32) port map (SEL=>size_i, DATA0=>RD_bex, DATA1=>RD_hex, DATA2=>RDSR, RESULT=>OUT_MUX1);
	register2 : registera generic map (A=>B32) port map ( D=>OUT_MUX1, LOAD=>PREADY, CLK=>CLK_rdata, Q=>fin ); 


	RDATA_1<=PRDATA;
	rdata_o<=fin;
	rdata_unbuff_o <= PRDATA;
	
end architecture Behavioral;

