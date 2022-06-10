library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity Control_Unit is

generic (DWIDTH: natural := 32  );  -- Number of data bits per input/output

  Port (CLK_A : in STD_LOGIC;
	RESET_A : in STD_LOGIC;
	MEM_BUSY : in STD_LOGIC;
	INSTRUCTION : in STD_LOGIC_VECTOR ( 31 downto 0 );
	CONTROL_SIG : out STD_LOGIC_VECTOR ( 31 downto 0));


end Control_Unit;

architecture Behavioral of Control_Unit is

	constant N : natural := 32;

	component InstrNumber

		Port (FUNC12 : in STD_LOGIC;
			FUNC7 : in STD_LOGIC;
			FUNC3 : in STD_LOGIC_VECTOR ( 2 downto 0 );
			OPCODE : in STD_LOGIC_VECTOR ( 4 downto 0 );
			NUMBER : out STD_LOGIC_VECTOR ( 7 downto 0));

	end component InstrNumber;

	component AddressCounter

		  Port (ENABLE : in STD_LOGIC;
			LOAD : in STD_LOGIC;
			LOAD_VAL : in STD_LOGIC_VECTOR ( 7 downto 0);
			VALU : out STD_LOGIC_VECTOR ( 7 downto 0);
			RESTART : in STD_LOGIC;
			RESET : in STD_LOGIC;
			CLK : in STD_LOGIC );

	end component AddressCounter;


	component MUX2TO1 

	generic ( DWIDTH: natural := 32  );  -- Number of data bits per input/output

		Port (  SEL: in std_logic;
			DATA0: in std_logic_vector (DWIDTH-1 downto 0);
			DATA1: in std_logic_vector (DWIDTH-1 downto 0);
			RESULT: out std_logic_vector (DWIDTH-1 downto 0));

	end component MUX2TO1;

	component ROM_Memory 

  		Port (  ADDRESS : in STD_LOGIC_VECTOR (7 downto 0);
        		DATA : out STD_LOGIC_VECTOR (31 downto 0);
         		ENABLE : in STD_LOGIC;
         		CLK : in STD_LOGIC);

	end component ROM_Memory ;


signal sFUNC12, sFUNC7, EOF, EOI, WaitMEM, sENABLE : STD_LOGIC;
signal sFUNC3 : STD_LOGIC_VECTOR ( 2 downto 0 );
signal sOPCODE : STD_LOGIC_VECTOR ( 4 downto 0 );
signal INUM, uCYCLE, uADDR, RESULTMUX1, ZERO: STD_LOGIC_VECTOR ( 7 downto 0 );



begin

	ZERO<="00000000";

	alias sFUNC3 : std_logic_vector is INSTRUCTION( 14 downto 12 );
	alias sFUNC7 : std_logic is INSTRUCTION( 30 );
	alias sFUNC12 : std_logic is INSTRUCTION( 20 );
	alias sOPCODE : std_logic_vector is INSTRUCTION( 6 downto 2 );

	instrnumber1 : InstrNumber port map (FUNC3=>sFUNC3, FUNC7=>sFUNC7, FUNC12 =>sFUNC12, OPCODE=>sOPCODE, NUMBER=>INUM );
	addresscounter1 : AddressCounter port map (ENABLE=>sENABLE, LOAD=>EOF, LOAD_VAL=>INUM, VALU=>uCYCLE, RESTART => EOI, RESET=>RESET_A, CLK=>CLK_A );
	mux1 : MUX2TO1 generic map (DWIDTH=>N) port map (SEL=>EOF, DATA0=>uCYCLE, DATA1=>INUM, RESULT=>RESULTMUX1);
	mux2 : MUX2TO1 generic map (DWIDTH=>N) port map (SEL=>EOI, DATA0=>RESULTMUX1, DATA1=>ZERO, RESULT=>uADDR);
	rommemory : ROM_Memory port map (ADDRESS=>uADDR, DATA=>CONTROL_SIG, ENABLE=>sENABLE, CLK=>CLK_A );
	
end architecture Behavioral;

