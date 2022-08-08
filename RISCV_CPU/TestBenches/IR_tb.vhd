--!
--! File IR_tb.vhd
--! \brief TestBench of the IR bloc of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!IR_tb design with :\n
--!      - 4 input signals : clk, loadval, wIR, membusy \n
--!      - 1 output signal : valeur\n
--!\n
--! **behavior** 
--!      - Test all the behaviours of IR



library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity IR_tb is

end IR_tb;


architecture Behavioral of IR_tb is

component IR

  Port (LOADVAL :  in STD_LOGIC_VECTOR(31 downto 0);
        wIR : in STD_LOGIC;
	MemBusy : in STD_LOGIC;
    	CLK : in STD_LOGIC;
	VALEUR : out STD_LOGIC_VECTOR(31 downto 0));    

end component;

     

signal sLOAD, sVAL: STD_LOGIC_VECTOR(31 downto 0);
signal swIR, sMEM, sCLK: STD_LOGIC;




begin



UUT : IR port map (  LOADVAL=>sLOAD, VALEUR=>sVAL, wIR=>swIR, MemBusy=>sMEM, CLK=>sCLK);


process 

    begin

    sCLK <='0';

        wait for 10 ns;

    sCLK <='1';

        wait for 10 ns;

    end process;

process

    begin


	sLOAD <= "00000000000000001111111111111111";
	sMem<='1';
	swIR<='0';
	wait for 30 ns;
     
	swIR<='1';
	wait for 30 ns;

	sMem<='0';
	swIR<='0';
	wait for 30 ns;

	swIR<='1';
	wait for 30 ns;

     end process;

end architecture Behavioral;

       


