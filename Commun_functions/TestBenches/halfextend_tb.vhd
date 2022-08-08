--!
--! File halfextend_tb.vhd
--! \brief TestBench of the Byteextend bloc of the Memory Interface of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!halfextend_tb design with :\n
--!      - 2 input signals : Din, unsigned1 ( to determine if the signal is signed or not )\n
--!      - 1 output signal : Dout (result of a 16-bits extension) \n
--!\n
--! **behavior** 
--!      - Test all the behaviours


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity half_extend_tb is

end half_extend_tb;


architecture Behavioral of half_extend_tb is

component half_extend

  Port (Din :  in STD_LOGIC_VECTOR (15 downto 0);
    	Dout : out STD_LOGIC_VECTOR (31 downto 0);
	unsigned1 : in STD_LOGIC);          

end component;

     

signal sDin: STD_LOGIC_VECTOR(15 downto 0);
signal sDout: STD_LOGIC_VECTOR(31 downto 0);
signal suns : STD_LOGIC;




begin



UUT : half_extend port map (  Din=>sDin, Dout=>sDout, unsigned1=>suns);



process

    begin


	sDin <= "0000000000000001";
	suns<='0';
	wait for 30 ns;
     
	sDin <= "1000000000000001";
	suns<='0';
	wait for 30 ns;

	sDin <= "0000000000000001";
	suns<='1';
	wait for 30 ns;

	sDin <= "1000000000000001";
	suns<='1';
	wait for 30 ns;

     end process;

end architecture Behavioral;

       


