--!
--! File Immediate_tb.vhd
--! \brief TestBench of the Immediate bloc of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!Immediate_tb design with :\n
--!      - 1 input signal : RI\n
--!      - 5 output signals : I, S, U, B,J\n
--!\n
--! **behavior** 
--!      - Test all the behaviours of Immediate



library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity Immediate_tb is

end Immediate_tb;


architecture Behavioral of Immediate_tb is

component Immediate

  Port (RI :  in STD_LOGIC_VECTOR(31 downto 0);
        I : out STD_LOGIC_VECTOR(31 downto 0);
	S : out STD_LOGIC_VECTOR(31 downto 0);
    	U : out STD_LOGIC_VECTOR(31 downto 0);
	B : out STD_LOGIC_VECTOR(31 downto 0);
	J : out STD_LOGIC_VECTOR(31 downto 0));     

end component;

     

signal sRI, sI, sU, sB, sS, sJ: STD_LOGIC_VECTOR(31 downto 0);





begin



UUT : Immediate port map (  RI=>sRI, I=>sI, U=>sU, B=>sB, S=>sS, J=>sJ);



process

    begin


	sRI <= "00000000000000001111111111111111";
	wait for 30 ns;
     
	sRI <= "11111111111111111111111111111111";
	wait for 30 ns;

	sRI <= "01010101010101010101010101010101";
	wait for 30 ns;

	sRI <= "00000000000000000000000000000000";
	wait for 30 ns;

     end process;

end architecture Behavioral;

       


