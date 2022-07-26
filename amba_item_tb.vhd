library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;
use work.rv_esquirol2_pkg.all;
use work.rv_esquirol_pkg.all;


entity amba_item_tb is

end amba_item_tb; 


architecture Behavioral of amba_item_tb is

component amba_item

  Port (
	PCLK : in STD_LOGIC;
	PRSTn : in STD_LOGIC);

end component; 

     


signal CLK, RST: STD_LOGIC; 



begin 



UUT : amba_item  port map ( PCLK=>CLK, PRSTn=>RST);

process 

    begin

    CLK <='0';

        wait for 30 ns;

    CLK <='1';

        wait for 30 ns;

    end process;


process

    begin 

	-- On reset pour bien demarrer

	RST<='0';
	wait until rising_edge(CLK);

	-- On demarre

	RST<='1';
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	wait until rising_edge(CLK);
	
end process;

end Behavioral;
