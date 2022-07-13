library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all;
use work.rv_esquirol2_pkg.all;


entity SlaveDecodeur is



  Port (ADDRESS :  in STD_LOGIC_VECTOR (SLAVE_DECODER_A-1 downto 0);
        ENABLE : in STD_LOGIC;
    	SEL : out STD_LOGIC_VECTOR (SLAVE_DECODER_S-1 downto 0);
	NUM_SLAVE : out STD_LOGIC_VECTOR ( SLAVE_DECODER_LS-1 downto 0));
       


end SlaveDecodeur;

architecture Behavioral of SlaveDecodeur is


begin

process

begin



	if ( ENABLE='0' ) then
		SEL <= "000";
		NUM_SLAVE <="--";

	elsif ( ENABLE='1' ) then

		if (std_match(ADDRESS,SLAVE_DECODER_SAX(0))) then
			SEL<="001";
			NUM_SLAVE<="00";

		elsif (std_match(ADDRESS,SLAVE_DECODER_SAX(1))) then
			SEL<="010";
			NUM_SLAVE<="10";

		elsif (std_match(ADDRESS,SLAVE_DECODER_SAX(2))) then
			SEL<="100";
			NUM_SLAVE<="11";
		else 
			SEL<="000";
			NUM_SLAVE<="--";
		
		end if;
		
	end if;

	end process;

end Behavioral;

