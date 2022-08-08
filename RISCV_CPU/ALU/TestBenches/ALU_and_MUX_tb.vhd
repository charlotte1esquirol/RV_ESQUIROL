--!
--! File ALU_and_MUX_tb.vhd
--! \brief TestBench of the Arithmetic Logic Unit linked with two MUXs of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date May 2022
--!
--!
--!ALU_and_MUX_tb design with :\n
--!      - 9 inputs signals : rs1_value, pc_value, rs2_value, I/U/S_Immediate, sel1alu, sel2alu ( selctions of the multiplexers and selo (selects the operation to be performed. Alternative 2 with 11 different operations)\n
--!      - 1 output signal : alu_val (result of the operations of the two multiplexers and of the ALU)\n
--!\n
--! **behavior** 
--!      - Test all the selctions


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity ALU_and_MUX_tb is

end ALU_and_MUX_tb; 


architecture Behavioral of ALU_and_MUX_tb is

component ALU_and_MUX

generic (DWIDTH: natural := 32  );  -- Number of data bits per input/output

  Port (RS1_VALUE, PC_VALUE :  in STD_LOGIC_VECTOR (DWIDTH-1 downto 0);
	RS2_VALUE, I_IMMEDIATE, U_IMMEDIATE, S_IMMEDIATE : in STD_LOGIC_VECTOR (DWIDTH-1 downto 0);
	SEL1ALU : in STD_LOGIC;
	SEL2ALU : in STD_LOGIC_VECTOR (1 downto 0);
        SELOP : in STD_LOGIC_VECTOR (3 downto 0);
    	ALU_VAL : out STD_LOGIC_VECTOR (DWIDTH-1 downto 0));

end component; 

     
constant N : natural := 32;


signal sRS1, sPC, sRS2, sI, sU, sS, sALU_VAL: STD_LOGIC_VECTOR(N-1 downto 0);

signal sSEL1: STD_LOGIC; 

signal sSEL2 : STD_LOGIC_VECTOR (1 downto 0);

signal sSELOP : STD_LOGIC_VECTOR (3 downto 0);



begin 



UUT : ALU_and_MUX generic map (DWIDTH=>N) port map ( RS1_VALUE=>sRS1, PC_VALUE=>sPC, RS2_VALUE=>sRS2, I_IMMEDIATE=>sI, U_IMMEDIATE=>sU, S_IMMEDIATE=>sS, ALU_VAL=>sALU_VAL, SEL1ALU=>sSEL1, SEL2ALU=>sSEL2, SELOP=>sSELOP );


process

    begin 

	-- On initialise

	sRS1<="00000000000000000000000000000001"; 
	sRS2<="00000000000000000000000000000010"; 
	sI<="10000000000000000000000000000000"; 
	sU<="01000000000000000000000000000000"; 
	sS<="00100000000000000000000000000000"; 
	sPC<="11111000000000000000000000000000";

	-- On initialise les valeurs des selecteurs toutes à 0

	sSEL1<='0';
	sSEL2<="00";
	sSELOP<="0000";

	wait for 30 ns;

	-- On change SEL1 à 1

	sSEL1<='1';
	wait for 30 ns;

	-- On remet SEL1 à 0 et change SEL2 à 1

	sSEL2<="01";
	wait for 30 ns;

	-- On change encore SEL2 à 2

	sSEL2<="10";
	wait for 30 ns;

	-- On change encore SEL2 à 3

	sSEL2<="10";
	wait for 30 ns;

	-- On remet SEL1 à 0 et SEL2 à 0 et change SELOP à 1

	sSELOP<="0001";
	wait for 30 ns;

	-- On change encore SELOP à 2

	sSELOP<="0010";
	wait for 30 ns;

	-- On change encore SELOP à 3

	sSELOP<="0011";
	wait for 30 ns;

	-- On change encore SELOP à 4

	sSELOP<="0100";
	wait for 30 ns;

	-- On change encore SELOP à 5

	sSELOP<="0101";
	wait for 30 ns;

	-- On change encore SELOP à 6

	sSELOP<="0110";
	wait for 30 ns;

	-- On change encore SELOP à 7

	sSELOP<="0111";
	wait for 30 ns;

	-- On change encore SELOP à 8

	sSELOP<="1000";
	wait for 30 ns;

	-- On change encore SELOP à 9

	sSELOP<="1001";
	wait for 30 ns;

	-- On change encore SELOP à 10

	sSELOP<="1010";
	wait for 30 ns;

	-- On change encore SELOP à 11

	sSELOP<="1011";
	wait for 30 ns;

	-- On vérifie que ca marche pour tout

	sSEL1<='1';
	sSEL2<="11";
	wait for 30 ns;

	sSEL2<="10";
	sSELOP<="0110";
	wait for 200 ns;


	
   
end process;

end Behavioral;
