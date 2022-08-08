--!
--! File ROM_Memory.vhd
--! \brief ROM table used in the Control Unit of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date May 2022
--!
--!
--!ROM_Memory design with :\n
--!	 - 2 packages : rv_esquirol_pkg and rv_esquirol_controlunit_image_pkg\n
--!      - 5 input signals : clk, ADDRESS, waitmem, membusy, rst\n
--!      - 1 output signal : DATA\n
--!\n
--! **behavior** 
--!      - Copy the value at the (ADDRESS)-position of the table of the ROM and paste it in DATA if (WAITMEM='0' or MEMBUSY='0').\n




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
	 RST : in STD_LOGIC;
         CLK : in STD_LOGIC);

end ROM_Memory;


architecture Behavioral of ROM_Memory is 


constant mem_rom : mem32_t(0 to 255) := mem32_init_f(control_unit_image, 256);

begin 

    react: Process (rst, clk) is

    begin

	if (RST='0') then
		DATA<=(others=>'0');


     elsif rising_edge(clk) then
	
	if (WAITMEM='0' or MEMBUSY='0') then
          -- clock edge reaction here

            DATA <= mem_rom(to_integer(unsigned(ADDRESS)));
	
	end if;

      end if;

   
    end process react;


end Behavioral;


