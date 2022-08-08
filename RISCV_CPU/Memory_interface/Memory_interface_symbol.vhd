--!
--! File memory_interface_symbol.vhd
--! \brief  Memory part ( link of the item_size, the memory_item_paddr, the memory_item_pwdata, memory_item_pwrite, memory_item_rdata, the StateMachine, the register, the OR and 2 MUXs )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!memory_interface_symbol design with :\n
--!      - 10 input signals : clkm, rstm, prdatam, preadym, rd_im, wr_im, addr_im, unsigned_im, size_im, wdata_im \n
--!      - 9 output signals :  paddrm, pstrbm, pwdatam, pwritem, penablem, preqm, busy_om, rdata_om, rdata_unbuff_om \n
--!\n
--! **behavior** 
--!      - It links some others blocs

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;
use work.rv_esquirol2_pkg.all;


entity Memory_interface_symbol is

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


end Memory_interface_symbol;


architecture Behavioral of Memory_interface_symbol is


	constant DWIDTH32 : natural := 32;
	constant DWIDTH1 : natural := 1;
	constant B2 : natural := 2;

	constant SR8 : natural := 8;
	constant SR16 : natural := 16;
	constant SR24 : natural := 24;
	constant DWIDTHSR64 : natural := 64;



	component item_size

  Port (size_i : in STD_LOGIC_VECTOR ( 1 downto 0 );
	first_cycle : in STD_LOGIC;
	CLK_size : in STD_LOGIC;
	op2 : in STD_LOGIC;
	ALIGNEMENT : in STD_LOGIC_VECTOR ( 1 downto 0 );
	PSTRB : out STD_LOGIC_VECTOR ( 3 downto 0);
	unaligned : out STD_LOGIC );

	end component item_size;

	component memory_item_pwdata

  Port (wdata_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
	first_cycle : in STD_LOGIC;
	CLK_pwdata : in STD_LOGIC;
	op2 : in STD_LOGIC;
	ALIGNEMENT : in STD_LOGIC_VECTOR ( 1 downto 0 );
	PWDATA : out STD_LOGIC_VECTOR ( 31 downto 0));

       	end component memory_item_pwdata;



	component memory_item_pwrite 

  Port (first_cycle : in STD_LOGIC;
	CLKA : in STD_LOGIC;
	wr_i : in STD_LOGIC;
	PWRITE : out STD_LOGIC);

	end component memory_item_pwrite ;



	component MUX2TO1single 


port (
	SEL: in std_logic;
	DATA0: in std_logic;
	DATA1: in std_logic;
	RESULT: out std_logic);

	end component MUX2TO1single;

	component MUX4TO1single 


port (
	SEL: in std_logic_vector (1 downto 0) ;
	DATA0: in std_logic;
	DATA1: in std_logic;
	DATA2: in std_logic;
	DATA3: in std_logic;
	RESULT: out std_logic);

	end component MUX4TO1single;

	component StateMachine 

	port
	(
		clk : in std_logic;
		rst	 : in	std_logic;
		trigger	 : in	std_logic;
		PREADY	 : in	std_logic;
		unaligned : in std_logic;
		op1 : out std_logic;
		op2 : out std_logic;
		first_cycle : out std_logic;
		busy_sel : out std_logic_vector (1 downto 0) ;
		preq_sel : out std_logic;
		PENABLE : out std_logic);

	end component StateMachine;

	component registera 

  generic (A: natural := 8  );  -- Number of data bits per input/output

  Port (D :  in STD_LOGIC_VECTOR (A-1 downto 0);
        LOAD : in STD_LOGIC;
    	CLK : in STD_LOGIC;
	Q : out STD_LOGIC_VECTOR (A-1 downto 0));

	end component registera ;

	component OR2 

  Port (Din1 :  in STD_LOGIC;
	Din2 : in STD_LOGIC;
    	Dout : out STD_LOGIC);       

	end component OR2 ;

	component memory_item_paddr 

  Port (addr_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
	first_cycle : in STD_LOGIC;
	CLK_paddr : in STD_LOGIC;
	op2 : in STD_LOGIC;
	ALIGNEMENT : out STD_LOGIC_VECTOR ( 1 downto 0);
	PADDR : out STD_LOGIC_VECTOR ( 29 downto 0));

	end component memory_item_paddr ;

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

	end component memory_item_rdata ;





signal preq_sel1 : STD_LOGIC;
signal busy_sel1 : STD_LOGIC_VECTOR( 1 downto 0 );
signal trigger1 : STD_LOGIC;
signal ONE : STD_LOGIC;
signal unaligned_l : STD_LOGIC;
signal first_cycle1 : STD_LOGIC;
signal ope1 : STD_LOGIC;
signal ope2 : STD_LOGIC;
signal alignement1 : std_logic_vector ( 1 downto 0 );
signal enable1 : STD_LOGIC;
signal enable2 : STD_LOGIC;
signal alignement_reg1 : STD_LOGIC_VECTOR ( 1 downto 0 );







begin

	ONE<='1';
	enable1<= ( unaligned_l or not(PREADYm) );
	enable2<= not(PREADYm);

	
	itemsize : item_size port map ( size_i=>size_im, ALIGNEMENT=>alignement1, op2=>ope2, CLK_size=>CLKm, first_cycle=>first_cycle1 ,PSTRB=>PSTRBm, unaligned=>unaligned_l );
	memory_itempwdata : memory_item_pwdata  port map ( wdata_i=>wdata_im, first_cycle=>first_cycle1, op2=>ope2, CLK_pwdata=>CLKm, ALIGNEMENT=>alignement1, PWDATA=>PWDATAm );
	memory_itempwrite : memory_item_pwrite port map ( wr_i=>wr_im, first_cycle=>first_cycle1, CLKA=>CLKm, PWRITE=>PWRITEm );
	mux2to1_1 : MUX2TO1single  port map (SEL=>preq_sel1, DATA0=>trigger1, DATA1=>ONE, RESULT=>PREQm);
	mux4to1_1 : MUX4TO1single  port map (SEL=>busy_sel1, DATA0=>trigger1, DATA1=>enable1, DATA2=>ONE, DATA3=>enable2, RESULT=>busy_om);
	machine : StateMachine  port map ( clk=>CLKm, rst=>RSTm, trigger=>trigger1, PREADY=>PREADYm, unaligned=>unaligned_l, op1=>ope1, op2=>ope2, first_cycle=>first_cycle1, busy_sel=>busy_sel1, preq_sel=>preq_sel1, PENABLE=>PENABLEm );
	register1 : registera generic map (A=>B2) port map ( D=>alignement1, LOAD=>first_cycle1, CLK=>CLKm, Q=>alignement_reg1 ); 
	or2_1 : or2  port map (Din1=>rd_im, Din2=>wr_im, Dout=>trigger1);
	memory_itempaddr : memory_item_paddr port map ( addr_i=>addr_im, first_cycle=>first_cycle1, op2=>ope2, CLK_paddr=>CLKm, ALIGNEMENT=>alignement1, PADDR=>PADDRm );
	memory_itemrdata : memory_item_rdata port map ( PRDATA=>PRDATAm, PREADY=>PREADYm, op2=>ope2, op1=>ope1, CLK_rdata=>CLKm, unsigned_i=>unsigned_im, size_i=>size_im, ALIGNEMENT_reg=>alignement_reg1, rdata_unbuff_o=>rdata_unbuff_om, rdata_o=>rdata_om );



	
end architecture Behavioral;

