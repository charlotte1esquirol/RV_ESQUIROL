library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity PC_tb is

end PC_tb; 


architecture Behavioral of PC_tb is

component PC

  Port (LoadVal : in STD_LOGIC_VECTOR ( 31 downto 0 );
	Load : in STD_LOGIC;
	PC_VAL: out STD_LOGIC_VECTOR ( 31 downto 0 );
	INC : in STD_LOGIC;
	CLK : in STD_LOGIC;
	RESET : in STD_LOGIC);

end component; 

     



signal sLOADVAL, sPC_VAL: STD_LOGIC_VECTOR(31 downto 0);

signal sLOAD, sINC, sRESET, sCLK: STD_LOGIC; 



begin 



UUT : PC port map ( LOADVAL=>sLOADVAL, PC_VAL=>sPC_VAL, LOAD=>sLOAD, INC=>sINC, RESET=>sRESET, CLK=>sCLK );




process 

    begin

    sCLK <='0';

        wait for 10 ns;

    sCLK <='1';

        wait for 10 ns;
    
end process;


process

    begin 

	-- On reset pour bien tout initialiser

	sRESET<='0'; 
	wait for 30 ns;
	-- On initialise les valeurs pour que rien ne se passe

	sRESET<='1';
	sLOAD<='0';
	sLOADVAL<="11110000000000000000000000000000";
	sINC<='0';
	wait for 30 ns;

	-- On met seulement sLOAD à 1

	--SLOAD<='1';
	--wait for 50 ns;

	-- On met seulement sINC à 0

	sINC<='1';
	--sLOAD<='0';
	wait for 250 ns;

	-- On met les 2 à 1

	--sLOAD<='1';
	wait for 50 ns;


	
   
end process;

end Behavioral;
