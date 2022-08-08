--!
--! File Control_Unit_tb.vhd
--! \brief TestBench of the Control Unit part ( link of InstrNumber, the AddressCounter, the ROM_Memory and 2 MUXs )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!Control_Unit_tb design with :\n
--!      - 4 input signals : clk_a, rst_a, mem_busy, instruction \n
--!      - 1 output signal : CONTROL_SIG \n
--!\n
--! **behavior** 
--!      - Test all the behaviours


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity Control_Unit_tb is

end Control_Unit_tb; 


architecture Behavioral of Control_Unit_tb is

component Control_Unit

generic (DWIDTH: natural := 32  );  -- Number of data bits per input/output

  Port (CLK_A : in STD_LOGIC;
	RESET_A : in STD_LOGIC;
	MEM_BUSY : in STD_LOGIC;
	INSTRUCTION : in STD_LOGIC_VECTOR ( 31 downto 0 );
	CONTROL_SIG : out STD_LOGIC_VECTOR ( 31 downto 0));



end component; 

     


signal sINSTR, sCONTROL_SIG: STD_LOGIC_VECTOR(31 downto 0);

signal sCLK, sRESET, sMEMBUSY: STD_LOGIC; 



begin 



UUT : Control_Unit  port map ( INSTRUCTION=>sINSTR, CONTROL_SIG=>sCONTROL_SIG, CLK_A=>sCLK, MEM_BUSY=>sMEMBUSY, RESET_A=>sRESET );

process 

    begin

    sCLK <='0';

        wait for 10 ns;

    sCLK <='1';

        wait for 10 ns;

    end process;


process

    begin 

	-- On reset pour bien demarrer

	sRESET<='0';
	sMEMBUSY<='0';
	wait until rising_edge(sCLK);
	wait for 5 ns;

	-- On initialise

	sRESET<='1';
	sMEMBUSY<='1';
	sINSTR<="00000000000000000101000000010011";

	wait until rising_edge(sCLK);
	wait for 5 ns;
	-- 

	sMEMBUSY<='0';

	wait until rising_edge(sCLK);
	wait for 5 ns;

	sINSTR<="01000000000000000101000000010011";

	wait until rising_edge(sCLK);
	wait for 5 ns;

	sINSTR<="00000000000000000001000000110011";

	wait until rising_edge(sCLK);
	wait for 5 ns;

	-- On change MEMBUSY

	sMEMBUSY<='1';
	wait until rising_edge(sCLK);
	wait for 5 ns;



	
   
end process;

end Behavioral;
