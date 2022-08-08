--! File SlaveDecodeur_tb.vhd
--! \brief TestBench of the SlaveDecodeur of the amba protocol of the RV design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!SlaveDecodeur_tb design with :\n
--!	 - 1 package : rv_esquirol2_pkg \n
--!      - 2 input signals : address, enable \n
--!      - 2 output signals : sel, num_slave \n
--!\n
--! **behavior** 
--!      - Test all the behaviours

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

       


