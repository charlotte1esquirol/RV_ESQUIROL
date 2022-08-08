--!
--! File InstrNumber.vhd
--! \brief InstrNumber bloc of the Control Unit of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!InstrNumber design with :\n
--!      - 4 input signals : opcode, func3, func7, func12 \n
--!      - 1 output signal : number \n
--!\n
--! **behavior** 
--!      - Take some informations and translate these in an particular instruction\n
--!      - Translate this instruction in a number \n
--!


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity InstrNumber is

  Port (FUNC12 : in STD_LOGIC;
	FUNC7 : in STD_LOGIC;
	FUNC3 : in STD_LOGIC_VECTOR ( 2 downto 0 );
	OPCODE : in STD_LOGIC_VECTOR ( 4 downto 0 );
	NUMBER : out STD_LOGIC_VECTOR ( 7 downto 0));

       

end InstrNumber;

architecture Behavioral of InstrNumber is



begin


-- Liste de tous les numéros d'instructions :

	-- OPCODE OP-IMM
	-- ADDI 
	NUMBER <= "01000000" when OPCODE="00100" and FUNC3="000" 
	-- SLTI 
	else "01001000" when OPCODE="00100" and FUNC3="010" 
	-- SLTIU
	else "01001100" when OPCODE="00100" and FUNC3="011"
	-- ANDI
	else "01100000" when OPCODE="00100" and FUNC3="111"
	-- ORI
	else "01011100" when OPCODE="00100" and FUNC3="110"
	-- XORI
	else "01010000" when OPCODE="00100" and FUNC3="100" 
	-- SLLI
	else "01000100" when OPCODE="00100" and FUNC3="001" 
	-- SRLI
	else "01010100" when OPCODE="00100" and FUNC3="101" and FUNC7='0'
	-- SRAI
	else "01011000" when OPCODE="00100" and FUNC3="101" and FUNC7='1'	

	-- OPCODE LOAD
	else "00001000" when OPCODE="00000"


	-- OPCODE LUI
	-- LUI
	else "00010100" when OPCODE="01101"

	-- OPCODE AUIPC
	-- AUIPC
	else "00010000" when OPCODE="00101"

	-- OPCODE OP
	-- ADD
	else "01100100" when OPCODE="01100" and FUNC3="000" and FUNC7='0'	
	-- SUB
	else "01101000" when OPCODE="01100" and FUNC3="000" and FUNC7='1'	
	-- SLT
	else "01110000" when OPCODE="01100" and FUNC3="010"
	-- SLTU
	else "01110100" when OPCODE="01100" and FUNC3="011"
	-- AND
	else "10001000" when OPCODE="01100" and FUNC3="111"
	-- OR
	else "10000100" when OPCODE="01100" and FUNC3="110"
	-- XOR
	else "01111000" when OPCODE="01100" and FUNC3="100"
	-- SLL
	else "01101100" when OPCODE="01100" and FUNC3="001"
	-- SRL
	else "01111100" when OPCODE="01100" and FUNC3="101" and FUNC7='0' 
	-- SRA
	else "10000000" when OPCODE="01100" and FUNC3="101" and FUNC7='1'

	-- OPCODE JALR
	-- JALR
	else "00011000" when OPCODE="11001"
	
	-- OPCODE JAL
	-- JAL
	else "00011100" when OPCODE="11011"

	-- OPCODE BRANCH
	-- BEQ
	else "00100000" when OPCODE="11000" and FUNC3="000" 
	-- BNE
	else "00100100" when OPCODE="11000" and FUNC3="001"
	-- BLT
	else "00101000" when OPCODE="11000" and FUNC3="100"
	-- BGE
	else "00101100" when OPCODE="11000" and FUNC3="101"
	-- BLTU
	else "00110000" when OPCODE="11000" and FUNC3="110"
	-- BGEU
	else "00110100" when OPCODE="11000" and FUNC3="111"

	-- OPCODE STORE
	else "00001100" when OPCODE="01000"


	-- OPCODE MISC-MEM 
	-- FENCE
	else "00000100" when OPCODE="00011" and FUNC3="000"

	-- OPCODE SYSTZM
	-- ECALL
	else "00111000" when OPCODE="11100" and FUNC3="000" and FUNC12='0'
	
	-- EBREAK
	else "00111100" when OPCODE="11100" and FUNC3="000" and FUNC12='1'


	else "11111111";


end Behavioral;
