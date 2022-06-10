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

