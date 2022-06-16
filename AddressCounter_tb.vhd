library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity AddressCounter_tb is

end AddressCounter_tb; 


architecture Behavioral of AddressCounter_tb is

component AddressCounter

  Port (WAITMEM : in STD_LOGIC;
	MEMBUSY : in STD_LOGIC;
	LOAD : in STD_LOGIC;
	LOAD_VAL : in STD_LOGIC_VECTOR ( 7 downto 0);
	VALU : out STD_LOGIC_VECTOR ( 7 downto 0);
	RESTART : in STD_LOGIC;
	RESET : in STD_LOGIC;
	CLK : in STD_LOGIC );

end component; 

     



signal sLOAD_VAL, sVALU: STD_LOGIC_VECTOR(7 downto 0);

signal sWAITMEM, sMEMBUSY, sLOAD, sRESET, sCLK : STD_LOGIC; 



begin 



UUT : AddressCounter port map ( LOAD_VAL=>sLOAD_VAL, VALU=>sVALU, WAITMEM=>sWAITMEM, MEMBUSY=>sMEMBUSY, LOAD=>sLOAD, RESET=>sRESET, CLK=>sCLK );




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

	sRESET='1'; 

	-- On initialise les valeurs 

	sRESET<='0';
	sWAITMEM<='1';
	sMEMBUSY<='1';
	sLOAD_VAL<="11110000";

	sFUNC3<="000";
	sFUNC7<='0';
	sFUNC12<='0';
	sOPCODE<="00100";

	wait for 30 ns;

	-- On met seulement sWAITMEM à 0

	SWAITMEM<='0';
	wait for 30 ns;

	-- On met seulement MEMBUSY à 0

	sWAITMEM<='1';
	sMEMBUSY<='0';
	wait for 30 ns;

	-- On met les 2 à 0

	sWAITMEM<='0';
	wait for 30 ns;-- On en met d'autres ( verification de func12 )

	sFUNC3<="000";
	sFUNC7<='0';
	sFUNC12<='1';
	sOPCODE<="11100";

	-- On en met d'autres ( verification de func7 )

	sFUNC3<="101";
	sFUNC7<='1';
	sFUNC12<='0';
	sOPCODE<="01100";

	wait for 30 ns;

	-- On en met d'autres ( verification de func3 )

	sFUNC3<="111";
	sFUNC7<='0';
	sFUNC12<='0';
	sOPCODE<="01100";

	wait for 30 ns;

	-- On en met d'autres ( verification de la valeur si aucune correspondance )

	sFUNC3<="111";
	sFUNC7<='0';
	sFUNC12<='0';
	sOPCODE<="11111";

	wait for 200 ns;

   
end process;

end Behavioral;

