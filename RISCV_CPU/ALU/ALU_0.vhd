--!
--! File ALU_0.vhd
--! \brief Arithmetic Logic Unit of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date May 2022
--!
--!
--!ALU_0 design with :\n
--!      - 3 input signals : op1, op2 and selopalu (selects the operation to be performed. Alternative 2 with 11 different operations)\n
--!      - 2 output signals : alu_value (result of the operation between op1 and op2) and flags (implementation 2)\n
--!\n
--! **behavior** 
--!      - Defines the kind of operation to be performed according to the value of selopalu, writes the **result in alu_value** and produces flags.\n
--!      - There are 10 working operations : +, - (signed or unsigned), bitwise operations (^ | &), op1, op2, right and left shift on op1 where the shift amount is the less 5 bits of op2 \n
--!

--! \todo
--!        - Add the code corresponding to the flags Z, N and C \n
--!        - Find a way to code "<<", ">>" ">>*", op1, op2 and signed operations\n
--!



library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity ALU_0 is

generic (DWIDTH: natural := 32  );  -- Number of data bits per input/output

  Port (OP1, OP2 :  in STD_LOGIC_VECTOR (DWIDTH-1 downto 0);
        SELOPALU : in STD_LOGIC_VECTOR (3 downto 0);
    	ALU_VALUE : out STD_LOGIC_VECTOR (DWIDTH-1 downto 0));
       


end ALU_0;

architecture Behavioral of ALU_0 is

--constant N : natural := 32;
--signal sOP1,sOP2 : STD_LOGIC_VECTOR(N-1 downto 0);


begin

--UUT : MUXs generic map (DWIDTH=>N) port map (OP1=>sOP1, OP2=>sOP2);

 
  ALU_VALUE <= std_logic_vector((unsigned(OP1) + unsigned(OP2))) when (SELOPALU = "0001")  
  -- else std_logic_vector ( unsigned(sOP1) << unsigned(sOP2) ) when (SELOPALU = "0010")  
  -- else std_logic_vector ( unsigned(sOP1) >> unsigned(sOP2) ) when (SELOPALU = "0011") 
  -- else std_logic_vector ( unsigned(sOP1) >>* unsigned(sOP2) ) when (SELOPALU = "0100") 
  else std_logic_vector ( unsigned(OP1) and unsigned(OP2) ) when (SELOPALU = "0101")
  else std_logic_vector ( unsigned(OP1) or unsigned(OP2) ) when (SELOPALU = "0110") 
  else std_logic_vector ( unsigned(OP1) xor unsigned(OP2) ) when (SELOPALU = "0111") 
  -- else std_logic_vector ( unsigned(sOP1) op1 unsigned(sOP2) ) when (SELOPALU = "1000")
  -- else std_logic_vector ( unsigned(sOP1) op2 unsigned(sOP2) ) when (SELOPALU = "1001") 
  -- else std_logic_vector ( signed(sOP1) - signed(sOP2) ) when (SELOPALU = "1010")  
  else std_logic_vector ( unsigned(OP1) - unsigned(OP2) ) when (SELOPALU = "1011") 
  else "00000000000000000000000000000000";

end architecture Behavioral;

