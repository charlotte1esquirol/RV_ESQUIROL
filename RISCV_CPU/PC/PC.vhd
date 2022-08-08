--! File PC.vhd
--! \brief PC bloc of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!PC design with :\n
--!      - 5 input signals : LoadVal, Load, inc, clk, reset\n
--!      - 1 output signals : pc_val \n
--!\n
--! **behavior** 
--!      - Count 4 to 4 if inc is a 1\n
--!      - Load the LoadVal in the output if Load is a 1 \n
--!


library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity PC is


  Port (LoadVal : in STD_LOGIC_VECTOR ( 31 downto 0 );
	Load : in STD_LOGIC;
	PC_VAL: out STD_LOGIC_VECTOR ( 31 downto 0 );
	INC : in STD_LOGIC;
	CLK : in STD_LOGIC;
	RESET : in STD_LOGIC);


end PC;

architecture Behavioral of PC is

signal PLUSQ : STD_LOGIC_VECTOR ( 31 downto 0 );
signal PC_INTERN : STD_LOGIC_VECTOR ( 31 downto 0 );

	begin 
	
		PLUSQ <= "00000000000000000000000000000100";

    		react: Process (reset, clk) is

    		begin
			
    			if (reset = '0') then

         			 -- reset action here
         			PC_INTERN <= "00000000000000000000000000000000";
				PC_VAL<=PC_INTERN;

     			elsif rising_edge(clk) then

					if (INC = '1' ) then 
						PC_INTERN <= std_logic_vector((unsigned(PC_INTERN) + unsigned(PLUSQ)));
						PC_VAL <= PC_INTERN;  

					elsif (Load = '1') then
						PC_INTERN <= LoadVal;
						PC_VAL <= PC_INTERN; 
				
					end if;
			end if;

		end process react;

end architecture Behavioral;

