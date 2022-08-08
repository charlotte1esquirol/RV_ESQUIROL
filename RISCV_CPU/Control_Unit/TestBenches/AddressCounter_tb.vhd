--!
--! File AddressCounter_tb.vhd
--! \brief TestBench of the Address Counter of the Control Unit of the RISC-V design design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!AddressCounter_tb design with :\n
--!      - 7 inputs signals : reset, clk, waitmem, membusy, load, load_val, restart \n
--!      - 1 output signal : valu \n
--!\n
--! **behavior** 
--!      - Test all the behaviors*


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

signal sWAITMEM, sMEMBUSY, sLOAD, sRESET, sCLK, sRESTART : STD_LOGIC; 



begin 



UUT : AddressCounter port map ( LOAD_VAL=>sLOAD_VAL, VALU=>sVALU, RESTART=>sRESTART, WAITMEM=>sWAITMEM, MEMBUSY=>sMEMBUSY, LOAD=>sLOAD, RESET=>sRESET, CLK=>sCLK );




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

	-- On initialise les valeurs 

	sRESET<='1';
	sWAITMEM<='1';
	sMEMBUSY<='1';
	sLOAD_VAL<="11110000";
	sLOAD<='0';
	sRESTART<='0';

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
	wait for 30 ns;

	-- Le compteur comptait de 1 en 1 car sLOAD et sRESTART sont à 0, on met sLOAD à 1

	sLOAD<='1';
	wait for 100 ns;

	-- On en met sRESTART à 0

	sRESTART<='1';

	wait for 30 ns;

	
   
end process;

end Behavioral;

