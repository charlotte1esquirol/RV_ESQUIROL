--! File register_tb.vhd
--! \brief TestBench of a Common FlipFlop with std_logic_vectors
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!register_tb design with :\n
--!      - 3 input signals : clk, d, load \n
--!      - 1 output signal : q \n
--!\n
--! **behavior** 
--!      - Test all the behaviours

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;


entity register_tb is

end register_tb; 


architecture Behavioral of register_tb is

component registera

generic (A: natural := 8  );  -- Number of data bits per input/output


  Port (D :  in STD_LOGIC_VECTOR (A-1 downto 0);
        LOAD : in STD_LOGIC;
    	CLK : in STD_LOGIC;
	Q : out STD_LOGIC_VECTOR (A-1 downto 0));

end component; 

     

constant N : natural := 8;

signal sD, sQ : STD_LOGIC_VECTOR(N-1 downto 0);

signal sLOAD, sCLK: STD_LOGIC;


begin 



UUT : registera generic map (A=>N) port map ( D=>sD, Q=>sQ, LOAD=>sLOAD, CLK=>sCLK );



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

	sLOAD <= '0';
	sD <= "11111111";

	wait for 30 ns;

	-- On teste une autre valeur

	sLOAD <= '1';
	wait for 30 ns;

	-- On teste une autre valeur

	sD <= "00000001";
	wait for 30 ns;

	-- On teste une autre valeur

	sLOAD <= '0';
	wait for 210 ns;


end process;

end Behavioral;
