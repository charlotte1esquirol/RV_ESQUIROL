--!
--! File item_size.vhd
--! \brief item_size part in memory interface ( link of the sizestrobes, the shiftleft, the register, the flipflop and 3 MUXs )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!item_size design with :\n
--!      - 5 input signals : clk_size, size_i, first_cycle, op2, alignement \n
--!      - 2 output signals : pstrb, unaligned \n
--!\n
--! **behavior** 
--!      - It links some others blocs

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity item_size is


  Port (size_i : in STD_LOGIC_VECTOR ( 1 downto 0 );
	first_cycle : in STD_LOGIC;
	CLK_size : in STD_LOGIC;
	op2 : in STD_LOGIC;
	ALIGNEMENT : in STD_LOGIC_VECTOR ( 1 downto 0 );
	PSTRB : out STD_LOGIC_VECTOR ( 3 downto 0);
	unaligned : out STD_LOGIC );


end item_size;

architecture Behavioral of item_size is

	constant DWIDTH8 : natural := 8;
	constant DWIDTH4 : natural := 4;
	constant SL1 : natural := 1;
	constant SL2 : natural := 2;
	constant SL3 : natural := 3;
	constant DWIDTHSL8 : natural := 8;
	constant B8 : natural := 8;
	constant B1 : natural := 1;

	component size_strobes

  Port (size :  in STD_LOGIC_VECTOR (1 downto 0);
    	strobes : out STD_LOGIC_VECTOR (7 downto 0));  

	end component size_strobes;

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

	component flipflop 

  Port (D :  in STD_LOGIC;
        LOAD : in STD_LOGIC;
    	CLK : in STD_LOGIC;
	Q : out STD_LOGIC);

	end component flipflop ;


	component OR1 

  Port (Din :  in STD_LOGIC_VECTOR (3 downto 0);
    	Dout : out STD_LOGIC);       

	end component OR1 ;

	component MUX2TO1 

generic (
	DWIDTH: natural := 32  );  -- Number of data bits per input/output

port (
	SEL: in std_logic;
	DATA0: in std_logic_vector (DWIDTH-1 downto 0);
	DATA1: in std_logic_vector (DWIDTH-1 downto 0);
	RESULT: out std_logic_vector (DWIDTH-1 downto 0));

	end component MUX2TO1;





signal SIZESTRB : STD_LOGIC_VECTOR ( 7 downto 0 );
signal STRB_SL1 : STD_LOGIC_VECTOR ( 7 downto 0 );
signal STRB_SL2 : STD_LOGIC_VECTOR ( 7 downto 0 );
signal STRB_SL3 : STD_LOGIC_VECTOR ( 7 downto 0 );
signal BYTESTRB : STD_LOGIC_VECTOR ( 7 downto 0 );
alias BSTRB1 : std_logic_vector(3 downto 0) is BYTESTRB(3 downto 0);
alias BSTRB2 : std_logic_vector(3 downto 0) is BYTESTRB(7 downto 4);
signal BSTR_reg : STD_LOGIC_VECTOR ( 7 downto 0 );
alias BSTR_regB1 : std_logic_vector(3 downto 0) is BSTR_reg(3 downto 0);
alias BSTR_regB2 : std_logic_vector(3 downto 0) is BSTR_reg(7 downto 4);
signal BSTR_OR : std_logic;
signal OUT_MUX1 : STD_LOGIC_VECTOR ( 3 downto 0 );







begin

	
	sizestrobes : size_strobes port map ( size=>size_i, strobes=>SIZESTRB );
	shiftleft1 : shiftleft generic map (DWIDTHSL=>DWIDTHSL8, NB_SL=>SL1) port map ( Din=>SIZESTRB, Dout=>STRB_SL1 );
	shiftleft2 : shiftleft generic map (DWIDTHSL=>DWIDTHSL8, NB_SL=>SL2) port map ( Din=>SIZESTRB, Dout=>STRB_SL2 );
	shiftleft3 : shiftleft generic map (DWIDTHSL=>DWIDTHSL8, NB_SL=>SL3) port map ( Din=>SIZESTRB, Dout=>STRB_SL3 );
	mux4to1_1 : MUX4TO1 generic map (DWIDTH=>DWIDTH8) port map (SEL=>ALIGNEMENT, DATA0=>SIZESTRB, DATA1=>STRB_SL1, DATA2=>STRB_SL2, DATA3=>STRB_SL3, RESULT=>BYTESTRB);
	orn1 : OR1 port map ( Din=>BSTRB2, Dout=>BSTR_OR );
	register1 : flipflop port map ( D=>BSTR_OR, LOAD=>first_cycle, CLK=>CLK_size, Q=>unaligned ); 
	register2 : registera generic map (A=>B8) port map ( D=>BYTESTRB, LOAD=>first_cycle, CLK=>CLK_size, Q=>BSTR_reg ); 
	mux2to1_1 : MUX2TO1 generic map (DWIDTH=>DWIDTH4) port map (SEL=>op2, DATA0=>BSTR_regB1, DATA1=>BSTR_regB2, RESULT=>OUT_MUX1);
	mux2to1_2 : MUX2TO1 generic map (DWIDTH=>DWIDTH4) port map (SEL=>first_cycle, DATA0=>OUT_MUX1, DATA1=>BSTRB1, RESULT=>PSTRB);

	
end architecture Behavioral;

