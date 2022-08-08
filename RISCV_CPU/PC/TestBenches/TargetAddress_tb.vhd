--! File TargetAddress_tb.vhd
--! \brief TestBench of the TargetAddress bloc of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date May 2022
--!
--!
--!TargetAddress_tb design with :\n
--!      - 2 input signals : DATA0, DATA1\n
--!      - 1 output signals : TARGET_PC \n
--!\n
--! **behavior** 
--!      - Test all the behaviours\n
--!


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity TargetAddress_tb is

end TargetAddress_tb; 


architecture Behavioral of TargetAddress_tb is

component TargetAddress

  Port (DATA0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
	DATA1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
	TARGET_PC : out STD_LOGIC_VECTOR ( 31 downto 0 ));

end component; 

     

signal sDATA0, sDATA1, sTARGET_PC : STD_LOGIC_VECTOR(31 downto 0);



begin 



UUT : TargetAddress port map ( DATA0=>sDATA0, DATA1=>sDATA1, TARGET_PC=>sTARGET_PC);



process

    begin 

	-- On initialise les entrees 

	sDATA0<="00000000000000000000000000000000";
	sDATA1<="00000000000000000000000000000001";
	
	wait for 30 ns;

	-- On change la valeur des entrées

	sDATA0<="10000000000000000000000000000000";
	sDATA1<="10000000000000000000000000000001";

	wait for 200 ns;

end process;

end Behavioral;

        








