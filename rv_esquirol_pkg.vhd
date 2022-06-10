library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;


package rv_esquirol_pkg is

	type mem32_t is array (natural range <>) of std_logic_vector(31 downto 0); -- memory with 32-bit entries
	impure function mem32_init_f(init : mem32_t; depth : natural) return mem32_t;

end rv_esquirol_pkg;
