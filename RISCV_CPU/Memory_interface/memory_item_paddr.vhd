--!
--! File memory_item_paddr.vhd
--! \brief memory_item_paddr part in memory interface ( link of the register, the add and 2 MUXs )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!item_size design with :\n
--!      - 4 input signals : clk_paddr, addr_i, first_cycle, op2 \n
--!      - 2 output signals : alignement, paddr \n
--!\n
--! **behavior** 
--!      - It links some others blocs
library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity memory_item_paddr is



  Port (addr_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
	first_cycle : in STD_LOGIC;
	CLK_paddr : in STD_LOGIC;
	op2 : in STD_LOGIC;
	ALIGNEMENT : out STD_LOGIC_VECTOR ( 1 downto 0);
	PADDR : out STD_LOGIC_VECTOR ( 29 downto 0));


end memory_item_paddr;

architecture Behavioral of memory_item_paddr is


	constant DWIDTH30 : natural := 30;
	constant B30 : natural := 30;


	component registera 

  generic (A: natural := 8  );  -- Number of data bits per input/output

  Port (D :  in STD_LOGIC_VECTOR (A-1 downto 0);
        LOAD : in STD_LOGIC;
    	CLK : in STD_LOGIC;
	Q : out STD_LOGIC_VECTOR (A-1 downto 0));

	end component registera ;

	component ADD2

  Port (Din1 :  in STD_LOGIC_VECTOR ( 29 downto 0 );
	Din2 : in STD_LOGIC_VECTOR ( 29 downto 0 );
    	Dout : out STD_LOGIC_VECTOR ( 29 downto 0 ));   

       	end component ADD2;



	component MUX2TO1 

generic (
	DWIDTH: natural := 32  );  -- Number of data bits per input/output

port (
	SEL: in std_logic;
	DATA0: in std_logic_vector (DWIDTH-1 downto 0);
	DATA1: in std_logic_vector (DWIDTH-1 downto 0);
	RESULT: out std_logic_vector (DWIDTH-1 downto 0));

	end component MUX2TO1;



alias WORDADDR : std_logic_vector(29 downto 0) is addr_i(31 downto 2);
alias ALIGN : std_logic_vector(1 downto 0) is addr_i(1 downto 0);
signal WADDR_reg : STD_LOGIC_VECTOR ( 29 downto 0 );
signal ONE : STD_LOGIC_VECTOR ( 29 downto 0 );
signal OUT_ADD : STD_LOGIC_VECTOR ( 29 downto 0 );
signal OUT_MUX1 : STD_LOGIC_VECTOR ( 29 downto 0 );



begin

	ONE <= "000000000000000000000000000001";

	
	register1 : registera generic map (A=>B30) port map ( D=>WORDADDR, LOAD=>first_cycle, CLK=>CLK_paddr, Q=>WADDR_reg ); 
	mux2to1_1 : MUX2TO1 generic map (DWIDTH=>DWIDTH30) port map (SEL=>op2, DATA0=>WADDR_reg, DATA1=>OUT_ADD, RESULT=>OUT_MUX1);
	mux2to1_2 : MUX2TO1 generic map (DWIDTH=>DWIDTH30) port map (SEL=>first_cycle, DATA0=>OUT_MUX1, DATA1=>WORDADDR, RESULT=>PADDR);
	add_1 : ADD2 port map ( Din1=>WADDR_reg, Din2=>ONE, Dout=>OUT_ADD);

	ALIGNEMENT <= ALIGN;
	
end architecture Behavioral;

