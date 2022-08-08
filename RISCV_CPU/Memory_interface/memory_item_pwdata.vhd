--!
--! File memory_item_pwdata.vhd
--! \brief  memory_item_pwdata part in memory interface ( link of the zeroextend, the shiftleft, the register and 3 MUXs )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!memory_item_pwdata design with :\n
--!      - 5 input signals : clk_pwdata, wdata_i, first_cycle, op2, alignement \n
--!      - 1 output signal :  pwdata \n
--!\n
--! **behavior** 
--!      - It links some others blocs

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity memory_item_pwdata is


  Port (wdata_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
	first_cycle : in STD_LOGIC;
	CLK_pwdata : in STD_LOGIC;
	op2 : in STD_LOGIC;
	ALIGNEMENT : in STD_LOGIC_VECTOR ( 1 downto 0 );
	PWDATA : out STD_LOGIC_VECTOR ( 31 downto 0));


end memory_item_pwdata;

architecture Behavioral of memory_item_pwdata is


	constant DWIDTH32 : natural := 32;
	constant DWIDTH64 : natural := 64;
	constant SL8 : natural := 8;
	constant SL16 : natural := 16;
	constant SL24 : natural := 24;
	constant DWIDTHSL64 : natural := 64;
	constant B64 : natural := 64;


	component zero_extend

  Port (Din :  in STD_LOGIC_VECTOR (31 downto 0);
    	Dout : out STD_LOGIC_VECTOR (63 downto 0));  

	end component zero_extend;

	component shiftleft

generic (
	NB_SL: natural := 2;   -- Number of shifts
	DWIDTHSL: natural := 8 );  -- Number of data bits per input/output

  Port (Din :  in STD_LOGIC_VECTOR (DWIDTHSL-1 downto 0);
        Dout : out STD_LOGIC_VECTOR (DWIDTHSL-1 downto 0));

       	end component shiftleft;

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



	component registera 

  generic (A: natural := 8  );  -- Number of data bits per input/output

  Port (D :  in STD_LOGIC_VECTOR (A-1 downto 0);
        LOAD : in STD_LOGIC;
    	CLK : in STD_LOGIC;
	Q : out STD_LOGIC_VECTOR (A-1 downto 0));

	end component registera ;



	component MUX2TO1 

generic (
	DWIDTH: natural := 32  );  -- Number of data bits per input/output

port (
	SEL: in std_logic;
	DATA0: in std_logic_vector (DWIDTH-1 downto 0);
	DATA1: in std_logic_vector (DWIDTH-1 downto 0);
	RESULT: out std_logic_vector (DWIDTH-1 downto 0));

	end component MUX2TO1;



signal WEXTEND : STD_LOGIC_VECTOR ( 63 downto 0 );
signal WE_SL8 : STD_LOGIC_VECTOR ( 63 downto 0 );
signal WE_SL16 : STD_LOGIC_VECTOR ( 63 downto 0 );
signal WE_SL24 : STD_LOGIC_VECTOR ( 63 downto 0 );
signal WDATA64 : STD_LOGIC_VECTOR ( 63 downto 0 );
alias WDATA1 : std_logic_vector(31 downto 0) is WDATA64(31 downto 0);
signal WDATA_reg : STD_LOGIC_VECTOR ( 63 downto 0 );
alias WDATA_regB1 : std_logic_vector(31 downto 0) is WDATA_reg(31 downto 0);
alias WDATA_regB2 : std_logic_vector(31 downto 0) is WDATA_reg(63 downto 32);
signal OUT_MUX1 : STD_LOGIC_VECTOR ( 31 downto 0 );







begin

	
	zeroextend : zero_extend port map ( Din=>wdata_i, Dout=>WEXTEND );
	shiftleft8 : shiftleft generic map (DWIDTHSL=>DWIDTHSL64, NB_SL=>SL8) port map ( Din=>WEXTEND, Dout=>WE_SL8 );
	shiftleft16 : shiftleft generic map (DWIDTHSL=>DWIDTHSL64, NB_SL=>SL16) port map ( Din=>WEXTEND, Dout=>WE_SL16 );
	shiftleft24 : shiftleft generic map (DWIDTHSL=>DWIDTHSL64, NB_SL=>SL24) port map ( Din=>WEXTEND, Dout=>WE_SL24 );
	mux4to1_1 : MUX4TO1 generic map (DWIDTH=>DWIDTH64) port map (SEL=>ALIGNEMENT, DATA0=>WEXTEND, DATA1=>WE_SL8, DATA2=>WE_SL16, DATA3=>WE_SL24, RESULT=>WDATA64);
	register1 : registera generic map (A=>B64) port map ( D=>WDATA64, LOAD=>first_cycle, CLK=>CLK_pwdata, Q=>WDATA_reg ); 
	mux2to1_1 : MUX2TO1 generic map (DWIDTH=>DWIDTH32) port map (SEL=>op2, DATA0=>WDATA_regB1, DATA1=>WDATA_regB2, RESULT=>OUT_MUX1);
	mux2to1_2 : MUX2TO1 generic map (DWIDTH=>DWIDTH32) port map (SEL=>first_cycle, DATA0=>OUT_MUX1, DATA1=>WDATA1, RESULT=>PWDATA);

	
end architecture Behavioral;

