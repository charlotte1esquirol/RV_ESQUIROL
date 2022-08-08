--!
--! File flipflop_tb.vhd
--! \brief TestBench of a Common FlipFlop
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!flipflop_tb design with :\n
--!      - 3 input signals : clk, d, load \n
--!      - 1 output signal : q \n
--!\n
--! **behavior** 
--!      - Test all the behaviours


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;


entity flipflop_tb is

end flipflop_tb; 


architecture Behavioral of flipflop_tb is

component flipflop


  Port (D :  in STD_LOGIC;
        LOAD : in STD_LOGIC;
    	CLK : in STD_LOGIC;
	Q : out STD_LOGIC);

end component; 

     


signal sD, sQ : STD_LOGIC;

signal sLOAD, sCLK: STD_LOGIC;


begin 



UUT : flipflop port map ( D=>sD, Q=>sQ, LOAD=>sLOAD, CLK=>sCLK );



process 

    begin

    sCLK <='0';

        wait for 10 ns;

    sCLK <='1';

        wait for 10 ns;

    end process;



process

    begin 

	-- On initialise

	sLOAD <= '1';
	sD <= '1';

	wait for 30 ns;

	-- On teste une autre valeur

	sLOAD <= '0';
	wait for 30 ns;

	-- On teste une autre valeur

	sD <= '0';
	wait for 30 ns;

	-- On teste une autre valeur

	sLOAD <= '1';
	wait for 30 ns;

	sD <= '1';
	wait for 50 ns;


end process;

end Behavioral;
