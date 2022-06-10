library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity ALU_and_MUX is

generic (DWIDTH: natural := 32  );  -- Number of data bits per input/output

  Port (RS1_VALUE, PC_VALUE :  in STD_LOGIC_VECTOR (DWIDTH-1 downto 0);
	RS2_VALUE, I_IMMEDIATE, U_IMMEDIATE, S_IMMEDIATE : in STD_LOGIC_VECTOR (DWIDTH-1 downto 0);
	SEL1ALU : in STD_LOGIC;
	SEL2ALU : in STD_LOGIC_VECTOR (1 downto 0);
        SELOP : in STD_LOGIC_VECTOR (3 downto 0);
    	ALU_VAL : out STD_LOGIC_VECTOR (DWIDTH-1 downto 0));
       


end ALU_and_MUX;

architecture Behavioral of ALU_and_MUX is

	constant N : natural := 32;

	component MUX2TO1 

	generic (
		DWIDTH: natural := 32  );  -- Number of data bits per input/output

		Port ( SEL: in std_logic;
			DATA0: in std_logic_vector (DWIDTH-1 downto 0);
			DATA1: in std_logic_vector (DWIDTH-1 downto 0);
			RESULT: out std_logic_vector (DWIDTH-1 downto 0));	

	end component MUX2TO1;

	component MUX4TO1 

	generic (
		DWIDTH: natural := 32  );  -- Number of data bits per input/output

		port ( SEL: in std_logic_vector (1 downto 0) ;
			DATA0: in std_logic_vector (DWIDTH-1 downto 0);
			DATA1: in std_logic_vector (DWIDTH-1 downto 0);
			DATA2: in std_logic_vector (DWIDTH-1 downto 0);
			DATA3: in std_logic_vector (DWIDTH-1 downto 0);
			RESULT: out std_logic_vector (DWIDTH-1 downto 0));	

	end component MUX4TO1;

	component ALU_0 

	generic (
		DWIDTH: natural := 32  );  -- Number of data bits per input/output

		Port ( SELOPALU : in STD_LOGIC_VECTOR (3 downto 0);
       			ALU_VALUE : out STD_LOGIC_VECTOR (DWIDTH-1 downto 0);
       			OP1 : in STD_LOGIC_VECTOR (DWIDTH-1 downto 0);
       			OP2 : in STD_LOGIC_VECTOR (DWIDTH-1 downto 0));

	end component;


signal MUX1_TO_OP1, MUX2_TO_OP2 : STD_LOGIC_VECTOR(N-1 downto 0);


begin

	mux1 : MUX2TO1 generic map (DWIDTH=>N) port map (DATA0=>RS1_VALUE, DATA1=>PC_VALUE, SEL =>SEL1ALU, RESULT=>MUX1_TO_OP1 );
	mux2 : MUX4TO1 generic map (DWIDTH=>N) port map (DATA0=>RS2_VALUE, DATA1=>I_IMMEDIATE, DATA2=>U_IMMEDIATE, DATA3=>S_IMMEDIATE, SEL =>SEL2ALU, RESULT=>MUX2_TO_OP2 );
	alu : ALU_0 generic map (DWIDTH=>N) port map (OP1=>MUX1_TO_OP1, OP2=>MUX2_TO_OP2, ALU_VALUE=>ALU_VAL, SELOPALU =>SELOP);


end architecture Behavioral;

