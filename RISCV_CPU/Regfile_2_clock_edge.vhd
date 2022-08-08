--! File Regfile_2_clock_edge.vhd
--! \brief Regfile bloc of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date May 2022
--!
--!
--!Regfile_2_clock_edge design with :\n
--!      - 7 input signals : w_data, w_address, w_command,  r0_address, r1_address, clk, reset\n
--!      - 2 output signals : r0_data, r1_data \n
--!\n
--! **behavior** 
--!      - This bloc manages the regfile table with all the values of the registers\n
--!


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity Regfile_2_clock_edge is

  Port ( W_DATA : in STD_LOGIC_VECTOR (31 downto 0);
         W_ADDRESS : in STD_LOGIC_VECTOR (4 downto 0);
         W_COMMAND : in STD_LOGIC;
         R0_DATA : out STD_LOGIC_VECTOR (31 downto 0);
         R0_ADDRESS: in STD_LOGIC_VECTOR (4 downto 0);
        -- R0_COMMAND : in STD_LOGIC;
         R1_DATA : out STD_LOGIC_VECTOR (31 downto 0);
         R1_ADDRESS: in STD_LOGIC_VECTOR (4 downto 0);
         --R1_COMMAND : in STD_LOGIC;
         RESET : in STD_LOGIC;
         CLK : in STD_LOGIC);

end Regfile_2_clock_edge;


architecture Behavioral of Regfile_2_clock_edge is 


type myTab_type is array( 0 to 31) of std_logic_vector(31 downto 0);
signal regfile  :   myTab_type;
signal aa : std_logic;
--signal regfile: array (31 downto 0) of std_logic_vector(31 downto 0);


begin 

    react: Process (reset, clk) is

    begin

    if (reset = '0') then
	aa<='0';
          -- reset action here
          for i in 0 to 31 loop
            regfile(i) <= (others => '0');
          end loop;

     elsif rising_edge(clk) then

          -- clock edge reaction here
          if (w_command = '1'and w_address /= "00000" ) then
            regfile(to_integer(unsigned(w_address))) <= w_data;
		aa<='1';
          end if;

          --if (r0_command = '1'  ) then
            r0_data <= regfile(to_integer(unsigned(r0_address)));
          --else
           -- r0_data <= (others => '0');
          --end if;

          --if (r1_command = '1'  ) then
            r1_data <= regfile(to_integer(unsigned(r1_address)));
          --else
           -- r1_data <= (others => '0');
         -- end if;

        end if;

   
    end process react;


end Behavioral;


