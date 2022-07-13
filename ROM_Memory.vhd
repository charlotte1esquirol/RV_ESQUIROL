
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.rv_esquirol_pkg.all;
use work.rv_esquirol_controlunit_image_pkg.all;
use work.rv_esquirol_controlunit_image_pkg.all;


entity ROM_Memory is

  Port ( 
         ADDRESS : in STD_LOGIC_VECTOR (7 downto 0);
         DATA : out STD_LOGIC_VECTOR (31 downto 0);
         WAITMEM : in STD_LOGIC;
	 MEMBUSY : in STD_LOGIC;
         CLK : in STD_LOGIC);

end ROM_Memory;


architecture Behavioral of ROM_Memory is 


constant mem_rom : mem32_t(0 to 31) := mem32_init_f(control_unit_image, 32);

begin 

    react: Process (membusy, waitmem, clk) is

    begin


     if rising_edge(clk) then
	
	if (WAITMEM='0' or MEMBUSY='0') then
          -- clock edge reaction here

            DATA <= mem_rom(to_integer(unsigned(ADDRESS)));
	
	end if;

      end if;

   
    end process react;


end Behavioral;


