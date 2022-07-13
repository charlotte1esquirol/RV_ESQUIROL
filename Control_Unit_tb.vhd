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


end Control_Unit;

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
	sINSTR<="


	-- On initialise les valeurs des selecteurs toutes à 0

	sSEL1<='0';
	sSEL2<="00";
	sSELOP<="0000";

	wait for 30 ns;

	-- On change SEL1 à 1

	sSEL1<='1';
	wait for 30 ns;

	-- On remet SEL1 à 0 et change SEL2 à 1

	sSEL2<="01";
	wait for 30 ns;

	-- On change encore SEL2 à 2

	sSEL2<="10";
	wait for 30 ns;

	-- On change encore SEL2 à 3

	sSEL2<="10";
	wait for 30 ns;

	-- On remet SEL1 à 0 et SEL2 à 0 et change SELOP à 1

	sSELOP<="0001";
	wait for 30 ns;

	-- On change encore SELOP à 2

	sSELOP<="0010";
	wait for 30 ns;

	-- On change encore SELOP à 3

	sSELOP<="0011";
	wait for 30 ns;

	-- On change encore SELOP à 4

	sSELOP<="0100";
	wait for 30 ns;

	-- On change encore SELOP à 5

	sSELOP<="0101";
	wait for 30 ns;

	-- On change encore SELOP à 6

	sSELOP<="0110";
	wait for 30 ns;

	-- On change encore SELOP à 7

	sSELOP<="0111";
	wait for 30 ns;

	-- On change encore SELOP à 8

	sSELOP<="1000";
	wait for 30 ns;

	-- On change encore SELOP à 9

	sSELOP<="1001";
	wait for 30 ns;

	-- On change encore SELOP à 10

	sSELOP<="1010";
	wait for 30 ns;

	-- On change encore SELOP à 11

	sSELOP<="1011";
	wait for 30 ns;

	-- On vérifie que ca marche pour tout

	sSEL1<='1';
	sSEL2<="11";
	wait for 30 ns;

	sSEL2<="10";
	sSELOP<="0110";
	wait for 200 ns;


	
   
end process;

end Behavioral;
