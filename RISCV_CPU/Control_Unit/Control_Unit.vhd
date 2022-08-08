--!
--! File Control_Unit.vhd
--! \brief Control Unit part ( link of InstrNumber, the AddressCounter, the ROM_Memory and 2 MUXs )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!Control_Unit design with :\n
--!      - 4 input signals : clk_a, rst_a, mem_busy, instruction \n
--!      - 1 output signal : CONTROL_SIG \n
--!\n
--! **behavior** 
--!      - It links some others blocs
--!	 - It produces a 32_bits signal with the values of some signals which will control a lot of blocs in the design ( sel1PC, sel2PC, iPC... ) \n



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

	constant N : natural := 8;

	component InstrNumber

		Port (FUNC12 : in STD_LOGIC;
			FUNC7 : in STD_LOGIC;
			FUNC3 : in STD_LOGIC_VECTOR ( 2 downto 0 );
			OPCODE : in STD_LOGIC_VECTOR ( 4 downto 0 );
			NUMBER : out STD_LOGIC_VECTOR ( 7 downto 0));

	end component InstrNumber;

	component AddressCounter

		  Port (WAITMEM : in STD_LOGIC;
			MEMBUSY : in STD_LOGIC;
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
         		WAITMEM : in STD_LOGIC;
			MEMBUSY : in STD_LOGIC;
			RST : in STD_LOGIC;
         		CLK : in STD_LOGIC);

	end component ROM_Memory ;

	component iPC_control 

  Port (CONTROL :  in STD_LOGIC_VECTOR(31 downto 0);
	WaitMem : in STD_LOGIC;
	MemBusy : in STD_LOGIC;
        CONTROLSIG :out STD_LOGIC_VECTOR(31 downto 0));

	end component iPC_control  ;




signal INUM, uCYCLE, uADDR, RESULTMUX1, ZERO: STD_LOGIC_VECTOR ( 7 downto 0 );

signal uINSTR, uINSTRMOD : STD_LOGIC_VECTOR ( 31 downto 0 );

alias sFUNC3 : std_logic_vector(2 downto 0) is INSTRUCTION(14 downto 12);
alias sFUNC7 : std_logic is INSTRUCTION( 30 );
alias sFUNC12 : std_logic is INSTRUCTION( 20 );
alias sOPCODE : std_logic_vector is INSTRUCTION( 6 downto 2 );
alias EOF : std_logic is uINSTR ( 30 );
alias EOI : std_logic is uINSTR ( 31 );
alias sWAITMEM : std_logic is uINSTR ( 0 );




begin

	ZERO<="00000000";
	
	instrnumber1 : InstrNumber port map (FUNC3=>sFUNC3, FUNC7=>sFUNC7, FUNC12 =>sFUNC12, OPCODE=>sOPCODE, NUMBER=>INUM );
	addresscounter1 : AddressCounter port map (WAITMEM=>sWAITMEM, MEMBUSY=>MEM_BUSY, LOAD=>EOF, LOAD_VAL=>INUM, VALU=>uCYCLE, RESTART => EOI, RESET=>RESET_A, CLK=>CLK_A );
	mux1 : MUX2TO1 generic map (DWIDTH=>N) port map (SEL=>EOF, DATA0=>uCYCLE, DATA1=>INUM, RESULT=>RESULTMUX1);
	mux2 : MUX2TO1 generic map (DWIDTH=>N) port map (SEL=>EOI, DATA0=>RESULTMUX1, DATA1=>ZERO, RESULT=>uADDR);
	rommemory : ROM_Memory port map (RST=>RESET_A, ADDRESS=>uADDR, DATA=>uINSTR, WAITMEM=>sWAITMEM, MEMBUSY=>MEM_BUSY, CLK=>CLK_A );
	ipc : iPC_control port map ( CONTROL=>uINSTR, WaitMem=>sWAITMEM, MemBusy=>MEM_BUSY, CONTROLSIG=>uINSTRMOD);
	CONTROL_SIG<=uINSTRMOD;
	
end architecture Behavioral;

