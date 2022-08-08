--!
--! File item_controlu.vhd
--! \brief item_controlu part ( link of the Control Unit, the IR, the Immediate )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!item_controlu design with :\n
--!      - 5 input signals : clk_a, rst_co, MemBusy_co, wIR_co, Value_Imem \n
--!      - 1O output signal : funct3, rs1, rs2, rd, Iim, Sim, Uim, Bim, Jim, CONTROL_signal \n
--!\n
--! **behavior** 
--!      - It links some others blocs


library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity item_controlu is


  Port (
	CLK_co : in STD_LOGIC;
	RST_co : in STD_LOGIC;
	MemBusy_co : in STD_LOGIC;
	wIR_co : in STD_LOGIC;
	Value_Imem : in STD_LOGIC_VECTOR( 31 downto 0 );
	funct3 : out STD_LOGIC_VECTOR ( 2 downto 0 );
	rs1 : out STD_LOGIC_VECTOR ( 4 downto 0 );
	rs2 : out STD_LOGIC_VECTOR ( 4 downto 0 );
	rd : out STD_LOGIC_VECTOR ( 4 downto 0);
	Iim : out STD_LOGIC_VECTOR ( 31 downto 0);
	Sim : out STD_LOGIC_VECTOR ( 31 downto 0);
	Uim : out STD_LOGIC_VECTOR ( 31 downto 0);
	Bim : out STD_LOGIC_VECTOR ( 31 downto 0);
	Jim : out STD_LOGIC_VECTOR ( 31 downto 0);

	CONTROL_signal : out STD_LOGIC_VECTOR ( 31 downto 0));


end item_controlu;

architecture Behavioral of item_controlu is


	constant DWIDTH32 : natural := 32;



	component Control_Unit

  generic (DWIDTH: natural := 32  );  -- Number of data bits per input/output

  Port (CLK_A : in STD_LOGIC;
	RESET_A : in STD_LOGIC;
	MEM_BUSY : in STD_LOGIC;
	INSTRUCTION : in STD_LOGIC_VECTOR ( 31 downto 0 );
	CONTROL_SIG : out STD_LOGIC_VECTOR ( 31 downto 0));
 

	end component Control_Unit;

	component IR

  Port (LOADVAL :  in STD_LOGIC_VECTOR(31 downto 0);
        wIR : in STD_LOGIC;
	MemBusy : in STD_LOGIC;
    	CLK : in STD_LOGIC;
	VALEUR : out STD_LOGIC_VECTOR(31 downto 0));

	end component IR;

	component Immediate

  Port (RI :  in STD_LOGIC_VECTOR(31 downto 0);
        I : out STD_LOGIC_VECTOR(31 downto 0);
	S : out STD_LOGIC_VECTOR(31 downto 0);
    	U : out STD_LOGIC_VECTOR(31 downto 0);
	B : out STD_LOGIC_VECTOR(31 downto 0);
	J : out STD_LOGIC_VECTOR(31 downto 0));

	end component Immediate ;

	component fetching_size

  Port (CONTROL :  in STD_LOGIC_VECTOR(31 downto 0);
	funct3n2 : in STD_LOGIC_VECTOR(1 downto 0);
	funcfetch : out STD_LOGIC_VECTOR( 1 downto 0));

	end component fetching_size ;





signal RI_VALUE, uINSTR : STD_LOGIC_VECTOR ( 31 downto 0 );
alias f3_bit2 : std_logic is RI_VALUE ( 14 );
alias f3_bit10 : std_logic_vector is RI_VALUE( 13 downto 12 );
alias f3_fetch : std_logic_vector is funct3 ( 1 downto 0 );
alias f3_fetch_bit2 : std_logic is funct3 (2);
alias r1 : std_logic_vector is RI_VALUE ( 19 downto 15 );
alias r2 : std_logic_vector is RI_VALUE ( 24 downto 20 );
alias rd1 : std_logic_vector is RI_VALUE ( 11 downto 7 );









begin

	
	IR1 : IR port map ( LOADVAL=>Value_Imem, CLK=>CLK_co, wIR=>wIR_co, MemBusy=>MemBusy_co, VALEUR=>RI_VALUE );
	ControlUnit : Control_Unit generic map (DWIDTH=>DWIDTH32) port map (CLK_A=>CLK_co, RESET_A=>RST_co, MEM_BUSY=>MemBusy_co, INSTRUCTION=>Value_Imem, CONTROL_SIG=>uINSTR);
	Immediate1 : Immediate port map ( RI=>RI_VALUE, I=>Iim, S=>Sim, U=>Uim, B=>Bim, J=>Jim); 
	fetch : fetching_size port map ( CONTROL=>uINSTR, funct3n2=>f3_bit10, funcfetch=>f3_fetch);

	CONTROL_signal<=uINSTR;
	f3_fetch_bit2 <= f3_bit2;
	rs1 <= r1;
	rs2 <= r2;
	rd <= rd1;
	
end architecture Behavioral;

