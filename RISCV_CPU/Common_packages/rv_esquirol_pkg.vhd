--! File rv_esquirol_pkg.vhd
--! \brief First Package to defines types and functions 
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!

--! **behavior** 
--!      - It defines a new type, an array and a function to fill the ROM_Memory and the InstrMemory . \n


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;


package rv_esquirol_pkg is 

	type mem32_t is array (natural range <>) of std_logic_vector(31 downto 0); -- memory with 32-bit entries
	impure function mem32_init_f(init : mem32_t; depth : natural) return mem32_t;

end rv_esquirol_pkg;


package body rv_esquirol_pkg is 

	impure function mem32_init_f(init : mem32_t; depth : natural) return mem32_t is
    		variable mem_v : mem32_t(0 to depth-1);
  	begin
		report "function mem32_init_f called" ;
    		mem_v := (others => (others => '0')); -- make sure remaining memory entries are set to zero
    		if (init'length > depth) then
      			return mem_v;
    		end if;
    		for idx_v in 0 to init'length-1 loop -- init only in range of source data array
      			mem_v(idx_v) := init(idx_v);
    		end loop; -- idx_v
    		return mem_v;
  	end function mem32_init_f;



end rv_esquirol_pkg;