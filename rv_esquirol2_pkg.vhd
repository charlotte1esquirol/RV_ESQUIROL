library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;

package rv_esquirol2_pkg is

	constant SLAVE_DECODER_A: natural := 8;
	constant SLAVE_DECODER_S: natural := 3;
	constant SLAVE_DECODER_LS: natural := 2;
	type SLAVE_DECODER_SAX_TYPE is array (0 to SLAVE_DECODER_S-1) of std_logic_vector(SLAVE_DECODER_A-1 downto 0);
	constant SLAVE_DECODER_SAX: SLAVE_DECODER_SAX_TYPE := {};

end package rv_esquirol2_pkg;

package body rv_esquirol2_pkg is 


end rv_esquirol2_pkg;
