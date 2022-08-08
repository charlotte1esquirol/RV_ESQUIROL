--! File SlaveDecodeur.vhd
--! \brief SlaveDecodeur of the amba protocol of the RV design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!SlaveDecodeur design with :\n
--!	 - 1 package : rv_esquirol2_pkg \n
--!      - 2 input signals : address, enable \n
--!      - 2 output signals : sel, num_slave \n
--!\n
--! **behavior** 
--!      - If enable is a 1, it compares the address with defined values in a package and give the outputs corresponding.


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

process ( ADDRESS, ENABLE )

begin



	if ( ENABLE='0' ) then
		SEL <= "00";
		--NUM_SLAVE <="-";

	elsif ( ENABLE='1' ) then

		if (std_match(ADDRESS,SLAVE_DECODER_SAX(0))) then
			SEL<="01";
			NUM_SLAVE<="0";

		elsif (std_match(ADDRESS,SLAVE_DECODER_SAX(1))) then
			SEL<="10";
			NUM_SLAVE<="1";

		--elsif (std_match(ADDRESS,SLAVE_DECODER_SAX(2))) then
			--SEL<="11";
			--NUM_SLAVE<="11";
		else 
			SEL<="00";
			--NUM_SLAVE<="-";
		
		end if;
		
	end if;

	end process;

end Behavioral;

