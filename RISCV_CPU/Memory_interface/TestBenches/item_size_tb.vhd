--!
--! File item_size_tb.vhd
--! \brief Testbench of item_size part in memory interface ( link of the sizestrobes, the shiftleft, the register, the flipflop and 3 MUXs )of the RISC-V design
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
--!      - Test all the behaviours

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity item_size_tb is

end item_size_tb; 


architecture Behavioral of item_size_tb is

component item_size

  Port (size_i : in STD_LOGIC_VECTOR ( 1 downto 0 );
	first_cycle : in STD_LOGIC;
	CLK_size : in STD_LOGIC;
	op2 : in STD_LOGIC;
	ALIGNEMENT : in STD_LOGIC_VECTOR ( 1 downto 0 );
	PSTRB : out STD_LOGIC_VECTOR ( 3 downto 0);
	unaligned : out STD_LOGIC );
end component; 

signal sSIZE, sALIGN: STD_LOGIC_VECTOR(1 downto 0);
signal sPSTRB: STD_LOGIC_VECTOR(3 downto 0);
signal sfirst, sCLK, sop2, suna: STD_LOGIC; 

begin 

UUT : item_size port map ( CLK_size=>sCLK, op2=>sop2, unaligned=>suna, size_i=>sSIZE, ALIGNEMENT=>sALIGN, PSTRB=>sPSTRB, first_cycle=>sfirst );

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

	sSIZE<="00";
	sfirst<='1';
	sop2<='1';
	sALIGN<="00";
	wait for 30 ns; 

	----

	sSIZE<="01";
	sALIGN<="01";
	wait for 30 ns;

	----

	sSIZE<="10";
	sALIGN<="10";
	wait for 30 ns;

	-----

	sALIGN<="11";
	sop2<='0';
	wait for 50 ns;

	----

	sfirst<='0';
	wait for 20 ns;

	sSIZE<="01";
	sALIGN<="01";
	wait for 30 ns;

	----

	sSIZE<="10";
	sALIGN<="10";
	wait for 30 ns;

	-----

	sALIGN<="11";

	wait for 50 ns;






	
   
end process;

end Behavioral;
