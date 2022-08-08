--!
--! File amba_item.vhd
--! \brief Amba part ( link of the Master, the Slave(s), the Slave_decodeur and 2 MUXs )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!Amba_item design with :\n
--!      - 4 input signals : clk_ma, rst_ma, PRDATA, PREADY \n
--!      - 6 output signals : PADD, PSTRB, PWRITE, PWDATA, PENABLE, PREQ \n
--!\n
--! **behavior** 
--!      - Follows the amba protocol \n


--! \todo
--!        - Test with others slaves ( just InstrMemory tested for now ), for example DataMemory

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;
use work.rv_esquirol2_pkg.all;


entity amba_item is


  Port (
	PCLK : in STD_LOGIC;
	PRSTn : in STD_LOGIC);



end amba_item;

architecture Behavioral of amba_item is


	constant DWIDTH32 : natural := 32;
	constant XX : natural := 8;


	component RV_1_1

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

	end component RV_1_1;

	component SlaveDecodeur


  Port (ADDRESS :  in STD_LOGIC_VECTOR (SLAVE_DECODER_A-1 downto 0);
        ENABLE : in STD_LOGIC;
    	SEL : out STD_LOGIC_VECTOR (SLAVE_DECODER_S-1 downto 0);
	NUM_SLAVE : out STD_LOGIC_VECTOR ( SLAVE_DECODER_LS-1 downto 0));
       

	end component SlaveDecodeur;


	component MUX2TO1 

generic (
	DWIDTH: natural := 32  );  -- Number of data bits per input/output

port (
	SEL: in std_logic;
	DATA0: in std_logic_vector (DWIDTH-1 downto 0);
	DATA1: in std_logic_vector (DWIDTH-1 downto 0);
	RESULT: out std_logic_vector (DWIDTH-1 downto 0));

	end component MUX2TO1;


	component MUX2TO1single 

port (
	SEL: in std_logic;
	DATA0: in std_logic;
	DATA1: in std_logic;
	RESULT: out std_logic);

	end component MUX2TO1single;

	component InstrMemory

generic (X: natural := 16  );  -- Number of data bits per input/output


  Port (
	CLK : in STD_LOGIC;
	PRDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
	PREADY : out STD_LOGIC;
	PADDRX : in STD_LOGIC_VECTOR ( X-1 downto 0 );
	PSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
	PENABLE : in STD_LOGIC;
	PSEL : in STD_LOGIC);

	end component InstrMemory;



signal PREADYa : STD_LOGIC;
signal PRDATAa : STD_LOGIC_VECTOR( 31 downto 0);
signal PADDRa :  STD_LOGIC_VECTOR ( 29 downto 0 );
signal PSTRBa : STD_LOGIC_VECTOR ( 3 downto 0 );
signal PWDATAa : STD_LOGIC_VECTOR ( 31 downto 0 );
signal PWRITEa : STD_LOGIC;
signal PENABLEa : STD_LOGIC;
signal PREQa : STD_LOGIC;
alias add : std_logic_vector is PADDRa ( 29 downto (29-(SLAVE_DECODER_A-1)) );
alias addX : std_logic_vector is PADDRa ( XX-1 downto 0 );

signal PSELa : STD_LOGIC_VECTOR ( SLAVE_DECODER_S-1 downto 0 );
alias PSEL0 : std_logic is PSELa ( 0 );
signal NSLAVE : STD_LOGIC_VECTOR ( SLAVE_DECODER_LS-1 downto 0 );
alias NSLAVEsingle : std_logic is NSLAVE ( 0 ); -- attention si LS different de 1 !!!
signal PREADY0 : STD_LOGIC;
signal PRDATA0 : STD_LOGIC_VECTOR( 31 downto 0);
signal PREADY1 : STD_LOGIC;
signal PRDATA1 : STD_LOGIC_VECTOR( 31 downto 0);












begin

	PRDATA1<="00000000000000000000000000000000";
	PREADY1<='0';


	
	RV : RV_1_1 port map ( CLK_ma=>PCLK, RST_ma=>PRSTn, PRDATA=>PRDATAa, PREADY=>PREADYa, PADDR=>PADDRa, PSTRB=>PSTRBa, PWDATA=>PWDATAa, PWRITE=>PWRITEa, PENABLE=>PENABLEa, PREQ=>PREQa);
	SlaveDec : SlaveDecodeur port map (ADDRESS=>add, ENABLE=>PREQa, SEL=>PSELa, NUM_SLAVE=>NSLAVE);
	muxdata : MUX2TO1 generic map (DWIDTH=>DWIDTH32) port map ( DATA0=>PRDATA0, DATA1=>PRDATA1, SEL=>NSLAVEsingle, RESULT=>PRDATAa); 
	muxready : MUX2TO1single port map ( DATA0=>PREADY0, DATA1=>PREADY1, SEL=>NSLAVEsingle, RESULT=>PREADYa); 
	slave1 : InstrMemory generic map (X=>XX) port map ( CLK=>PCLK, PRDATA=>PRDATA0, PREADY=>PREADY0, PADDRX=>addX, PSTRB=>PSTRBa, PENABLE=>PENABLEa, PSEL=>PSEL0); 

	

	
end architecture Behavioral;

