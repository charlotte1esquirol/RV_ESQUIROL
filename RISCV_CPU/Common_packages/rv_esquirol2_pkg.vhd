--! File rv_esquirol2_pkg.vhd
--! \brief Second Package to defines types and constants
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!

--! **behavior** 
--!      - It defines new constants and a new type, an array which will be used in the amba protocol ( for the SlaveDecoder, the Slaves and the two MUXs ) . \n
--! 	 - It defines the values to compare with for the SlaveDecodeur. \n



library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;

package rv_esquirol2_pkg is

	constant SLAVE_DECODER_A: natural := 8;
	constant SLAVE_DECODER_S: natural := 2;
	constant SLAVE_DECODER_LS: natural := 1;
	type SLAVE_DECODER_SAX_TYPE is array (0 to SLAVE_DECODER_S-1) of std_logic_vector(SLAVE_DECODER_A-1 downto 0);
	constant SLAVE_DECODER_SAX: SLAVE_DECODER_SAX_TYPE := (x"00", x"01"); --, "1000----", "1001----");

end package rv_esquirol2_pkg;

package body rv_esquirol2_pkg is 


end rv_esquirol2_pkg;
