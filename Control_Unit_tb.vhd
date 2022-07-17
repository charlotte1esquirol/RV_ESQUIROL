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

	sRESET<='1';
	wait for 30 ns;

	-- On initialise

	sRESET<='0';
	sMEMBUSY<='1';
	sINSTR<="00000000000000000101000000010011";


	-- 

	sMEMBUSY<='0';

	wait for 30 ns; 

	sINSTR<="01000000000000000101000000010011";

	wait for 30 ns;

	sINSTR<="00000000000000000001000000110011";

	wait for 30 ns;

	-- On change MEMBUSY

	sMEMBUSY<='1';
	wait for 30 ns;



	
   
end process;

end Behavioral;
