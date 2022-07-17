library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;
use work.rv_esquirol2_pkg.all;


entity SlaveDecodeur_tb is

end SlaveDecodeur_tb;


architecture Behavioral of SlaveDecodeur_tb is

component SlaveDecodeur

  Port (ADDRESS :  in STD_LOGIC_VECTOR (SLAVE_DECODER_A-1 downto 0);
        ENABLE : in STD_LOGIC;
    	SEL : out STD_LOGIC_VECTOR (SLAVE_DECODER_S-1 downto 0);
	NUM_SLAVE : out STD_LOGIC_VECTOR ( SLAVE_DECODER_LS-1 downto 0));     

end component;



signal sADD: STD_LOGIC_VECTOR(SLAVE_DECODER_A-1 downto 0);
signal sSEL: STD_LOGIC_VECTOR(SLAVE_DECODER_S-1 downto 0);
signal sNUM: STD_LOGIC_VECTOR(SLAVE_DECODER_LS-1 downto 0);
signal sENA : STD_LOGIC;




begin



UUT : SlaveDecodeur port map (  ADDRESS=>sADD, SEL=>sSEL, NUM_SLAVE=>sNUM, ENABLE=>sENA);



process

    begin


	sADD <= "00000000";
	sENA<='0';
	wait for 30 ns;
     


	sENA<='1';
	wait for 30 ns;

	sADD <= "00000001";
	wait for 30 ns;

	sADD <= "11111111";
	wait for 30 ns;



     end process;

end architecture Behavioral;

       


