--!
--! File RV_1_1.vhd
--! \brief RV part ( link of item_controlu, the item_PC, the Regfile, the ALU_and_MUX, the Memory_interface_symbol and 2 MUXs )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!RV_1_1 design with :\n
--!      - 4 input signals : clk_ma, rst_ma, prdata, pready \n
--!      - 6 output signals : paddr, pstrb, pwdata, pwrite, penable, preq \n
--!\n
--! **behavior** 
--!      - It links some others blocs
--!	 - It is the Master used in the amba part  \n


library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity RV_1_1 is


  Port (
	CLK_ma : in STD_LOGIC;
	RST_ma : in STD_LOGIC;
	PRDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
	PREADY : in STD_LOGIC;
	PADDR : out STD_LOGIC_VECTOR ( 29 downto 0 );
	PSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
	PWDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
	PWRITE : out STD_LOGIC;
	PENABLE : out STD_LOGIC;
	PREQ : out STD_LOGIC);



end RV_1_1;

architecture Behavioral of RV_1_1 is


	constant DWIDTH32 : natural := 32;



	component item_controlu

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
 

	end component item_controlu;

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

	end component item_PC;

	component ALU_and_MUX

generic (DWIDTH: natural := 32  );  -- Number of data bits per input/output

  Port (RS1_VALUE, PC_VALUE :  in STD_LOGIC_VECTOR (DWIDTH-1 downto 0);
	RS2_VALUE, I_IMMEDIATE, U_IMMEDIATE, S_IMMEDIATE : in STD_LOGIC_VECTOR (DWIDTH-1 downto 0);
	SEL1ALU : in STD_LOGIC;
	SEL2ALU : in STD_LOGIC_VECTOR (1 downto 0);
        SELOP : in STD_LOGIC_VECTOR (3 downto 0);
    	ALU_VAL : out STD_LOGIC_VECTOR (DWIDTH-1 downto 0));

	end component ALU_and_MUX ;

	component Regfile_2_clock_edge

  Port ( W_DATA : in STD_LOGIC_VECTOR (31 downto 0);
         W_ADDRESS : in STD_LOGIC_VECTOR (4 downto 0);
         W_COMMAND : in STD_LOGIC;
         R0_DATA : out STD_LOGIC_VECTOR (31 downto 0);
         R0_ADDRESS: in STD_LOGIC_VECTOR (4 downto 0);
         --R0_COMMAND : in STD_LOGIC;
         R1_DATA : out STD_LOGIC_VECTOR (31 downto 0);
         R1_ADDRESS: in STD_LOGIC_VECTOR (4 downto 0);
         --R1_COMMAND : in STD_LOGIC;
         RESET : in STD_LOGIC;
         CLK : in STD_LOGIC);

	end component Regfile_2_clock_edge ;

	component MUX2TO1 

	generic (
		DWIDTH: natural := 32  );  -- Number of data bits per input/output

		Port ( SEL: in std_logic;
			DATA0: in std_logic_vector (DWIDTH-1 downto 0);
			DATA1: in std_logic_vector (DWIDTH-1 downto 0);
			RESULT: out std_logic_vector (DWIDTH-1 downto 0));	

	end component MUX2TO1;


	component Memory_interface_symbol 

	generic (DWIDTH: natural := 32  );  -- Number of data bits per input/outp



  Port (CLKm : in STD_LOGIC;
	RSTm : in STD_LOGIC;
	PRDATAm : in STD_LOGIC_VECTOR (31 downto 0);
	PREADYm : in STD_LOGIC;
	rd_im : in STD_LOGIC;
	wr_im : in STD_LOGIC;
	addr_im : in STD_LOGIC_VECTOR (31 downto 0);
	unsigned_im: in STD_LOGIC;
	size_im : in STD_LOGIC_VECTOR (1 downto 0);
	wdata_im : in STD_LOGIC_VECTOR (31 downto 0);
	PADDRm : out STD_LOGIC_VECTOR (29 downto 0);
	PSTRBm : out STD_LOGIC_VECTOR (3 downto 0);
	PWDATAm : out STD_LOGIC_VECTOR (31 downto 0);
	PWRITEm : out STD_LOGIC;
	PENABLEm : out STD_LOGIC;
	PREQm: out STD_LOGIC;
	busy_om : out STD_LOGIC;
	rdata_om : out STD_LOGIC_VECTOR (31 downto 0);
	rdata_unbuff_om : out STD_LOGIC_VECTOR (31 downto 0));



	end component Memory_interface_symbol;



signal MemBusy_intern : STD_LOGIC;
signal Value_Imem_intern : STD_LOGIC_VECTOR( 31 downto 0);
signal rd_intern : STD_LOGIC_VECTOR(4 downto 0);
signal rs1_intern : STD_LOGIC_VECTOR(4 downto 0);
signal rs2_intern : STD_LOGIC_VECTOR(4 downto 0);
signal funct3_intern : STD_LOGIC_VECTOR(2 downto 0);
alias funct31 : std_logic_vector is funct3_intern ( 1 downto 0 );
alias funct32 : std_logic is funct3_intern ( 2 );
signal I : STD_LOGIC_VECTOR(31 downto 0);
signal U : STD_LOGIC_VECTOR(31 downto 0);
signal S : STD_LOGIC_VECTOR(31 downto 0);
signal B : STD_LOGIC_VECTOR(31 downto 0);
signal J : STD_LOGIC_VECTOR(31 downto 0);
signal Iext : STD_LOGIC_VECTOR(31 downto 0);
signal Uext : STD_LOGIC_VECTOR(31 downto 0);
signal Sext : STD_LOGIC_VECTOR(31 downto 0);
signal Bext : STD_LOGIC_VECTOR(31 downto 0);
signal Jext : STD_LOGIC_VECTOR(31 downto 0);
signal uINSTR : STD_LOGIC_VECTOR(31 downto 0);
alias iPC_intern : std_logic is uINSTR ( 5 );
alias sel1PC_intern : std_logic is uINSTR ( 21 );
alias sel2PC_intern : std_logic is uINSTR ( 20 );
signal rs1_value_intern : STD_LOGIC_VECTOR(31 downto 0);
signal rs2_value_intern : STD_LOGIC_VECTOR(31 downto 0);
signal rd_value_intern : STD_LOGIC_VECTOR(31 downto 0);
signal Address_to_Imem : STD_LOGIC_VECTOR(31 downto 0);
signal Address_to_Dmem : STD_LOGIC_VECTOR(31 downto 0);
signal Address_to_mem : STD_LOGIC_VECTOR(31 downto 0);
signal Value_from_Dmem : STD_LOGIC_VECTOR(31 downto 0);
alias sel1alu_intern : std_logic is uINSTR ( 14 );
alias sel2alu_intern : std_logic_vector is uINSTR( 13 downto 12 );
alias selop_intern : std_logic_vector is uINSTR( 11 downto 8 );
alias w_rd_intern : std_logic is uINSTR ( 7 );
alias idmem : std_logic is uINSTR ( 1 );
alias selRD : std_logic is uINSTR ( 6 );
alias rdmem : std_logic is uINSTR ( 2 );
alias wrmem : std_logic is uINSTR ( 3 );
alias wIR_intern : std_logic is uINSTR ( 4 );
signal ZERO : std_logic;













begin

ZERO<='0';

	
	item_controlu1 : item_controlu port map ( CLK_co=>CLK_ma, RST_co=>RST_ma, wIR_co=>wIR_intern, MemBusy_co=>MemBusy_intern, Value_Imem=>Value_Imem_intern, funct3=>funct3_intern, rs1=>rs1_intern, rs2=>rs2_intern, rd=>rd_intern, Iim=>I, Sim=>S, Uim=>U, Bim=>B, Jim=>J, CONTROL_signal=>uInstr );
	item_PC1 : item_PC port map (CLK_PC=>CLK_ma, RST_PC=>RST_ma, iPC=>iPC_intern, Bim_PC=>B, Jim_PC=>J, rs1_PC=>rs1_value_intern, sel1PC=>sel2PC_intern, sel2PC=>sel2PC_intern, wPC=>ZERO, PC_value=>Address_to_Imem);
	alumux : ALU_and_MUX port map ( RS1_VALUE=>rs1_value_intern, RS2_VALUE=>rs2_value_intern, PC_VALUE=>Address_to_Imem, I_IMMEDIATE=>I, U_IMMEDIATE=>U, S_IMMEDIATE=>S, SEL1ALU=>sel1alu_intern, SEL2ALU=>sel2alu_intern, SELOP=>selop_intern, ALU_VAL=>Address_to_Dmem); 
	regfile : Regfile_2_clock_edge port map ( W_DATA=>rd_value_intern, W_ADDRESS=>rd_intern, W_COMMAND=>w_rd_intern, R0_ADDRESS=>rs1_intern, R1_ADDRESS=>rs2_intern, R0_DATA=>rs1_value_intern, R1_DATA=>rs2_value_intern, RESET=>RST_ma, CLK=>CLK_ma); 
	muxaddress : MUX2TO1 port map ( DATA0=>Address_to_Imem, DATA1=>Address_to_Dmem, SEL=>idmem, RESULT=>Address_to_mem); 
	muxrd : MUX2TO1 port map ( DATA0=>Address_to_Dmem, DATA1=>Value_from_Dmem, SEL=>selRD, RESULT=>rd_value_intern); 
	memory : Memory_interface_symbol generic map (DWIDTH=>DWIDTH32) port map ( PRDATAm=>PRDATA, PREADYm=>PREADY, CLKm=>CLK_ma, RSTm=>RST_ma, rd_im=>rdmem, wr_im=>wrmem, addr_im=>Address_to_mem, size_im=>funct31, unsigned_im=>funct32, wdata_im=>rs2_value_intern, PADDRm=>PADDR, PSTRBm=>PSTRB, PWDATAm=>PWDATA, PWRITEm=>PWRITE, PENABLEm=>PENABLE, PREQm=>PREQ, busy_om=>MemBusy_intern, rdata_om=>Value_from_Dmem, rdata_unbuff_om=>Value_Imem_intern ); 


	
end architecture Behavioral;

