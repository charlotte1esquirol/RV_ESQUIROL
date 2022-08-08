--!
--! File memory_item_paddr_tb.vhd
--! \brief TestBench of the memory_item_paddr part in memory interface ( link of the register, the add and 2 MUXs )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!item_size_tb design with :\n
--!      - 4 input signals : clk_paddr, addr_i, first_cycle, op2 \n
--!      - 2 output signals : alignement, paddr \n
--!\n
--! **behavior** 
--!      - Test all the behaviours

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity memory_item_paddr_tb is

end memory_item_paddr_tb; 


architecture Behavioral of memory_item_paddr_tb is

component memory_item_paddr

  Port (addr_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
	first_cycle : in STD_LOGIC;
	CLK_paddr : in STD_LOGIC;
	op2 : in STD_LOGIC;
	ALIGNEMENT : out STD_LOGIC_VECTOR ( 1 downto 0);
	PADDR : out STD_LOGIC_VECTOR ( 29 downto 0));

end component; 

signal sALIGN: STD_LOGIC_VECTOR(1 downto 0);
signal sPADDR : STD_LOGIC_VECTOR(29 downto 0);
signal sADDR: STD_LOGIC_VECTOR(31 downto 0);
signal sfirst, sCLK, sop2: STD_LOGIC; 

begin 

UUT : memory_item_paddr port map ( CLK_paddr=>sCLK, op2=>sop2, PADDR=>sPADDR, addr_i=>sADDR, ALIGNEMENT=>sALIGN, first_cycle=>sfirst );

process 

    begin

    sCLK <='0';

        wait for 10 ns;

    sCLK <='1';

        wait for 10 ns;

    end process;


process

    begin 

	-- On initialise

	sADDR<="00000000000000001111111111111111";
	sfirst<='1';
	sop2<='1';
	wait for 30 ns; 

	----
	sADDR<="11000000000000001111111111111111";
	sop2<='0';
	wait for 30 ns;

	----

	sfirst<='0';
	sop2<='1';
	sADDR<="11000011000000001111111111111111";
	wait for 70 ns;








	
   
end process;

end Behavioral;
