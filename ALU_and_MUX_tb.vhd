library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity ALU_and_MUX_tb is

end ALU_and_MUX_tb; 


architecture Behavioral of ALU_and_MUX_tb is

component ALU_and_MUX

generic (DWIDTH: natural := 32  );  -- Number of data bits per input/output

  Port (RS1_VALUE, PC_VALUE :  in STD_LOGIC_VECTOR (DWIDTH-1 downto 0);
	RS2_VALUE, I_IMMEDIATE, U_IMMEDIATE, S_IMMEDIATE : in STD_LOGIC_VECTOR (DWIDTH-1 downto 0);
	SEL1ALU : in STD_LOGIC;
	SEL2ALU : in STD_LOGIC_VECTOR (1 downto 0);
        SELOP : in STD_LOGIC_VECTOR (3 downto 0);
    	ALU_VAL : out STD_LOGIC_VECTOR (DWIDTH-1 downto 0));

end component; 

     
constant N : natural := 32;


signal sRS1, sPC, sRS2, sI, sU, sS, sALU_VAL: STD_LOGIC_VECTOR(N-1 downto 0);

signal sSEL1: STD_LOGIC; 

signal sSEL2 : STD_LOGIC_VECTOR (1 downto 0);

signal sSELOP : STD_LOGIC_VECTOR (3 downto 0);



begin 



UUT : ALU_and_MUX generic map (DWIDTH=>N) port map ( RS1_VALUE=>sRS1, PC_VALUE=>sPC, RS2_VALUE=>sRS2, I_IMMEDIATE=>sI, U_IMMEDIATE=>sU, S_IMMEDIATE=>sS, ALU_VAL=>sALU_VAL, SEL1ALU=>sSEL1, SEL2ALU=>sSEL2, SELOP=>sSELOP );


process

    begin 

	-- On reset pour bien tout initialiser

	sRESET<='1'; 

	-- On initialise les valeurs pour que rien ne se passe

	sRESET<='0';
	sLOAD<='0';
	sLOADVAL<="11110000000000000000000000000000";
	sINC<='0';
	wait for 30 ns;

	-- On met seulement sLOAD à 1

	SLOAD<='1';
	wait for 50 ns;

	-- On met seulement sINC à 0

	sINC<='1';
	sLOAD<='0';
	wait for 50 ns;

	-- On met les 2 à 1

	sLOAD<='1';
	wait for 50 ns;


	
   
end process;

end Behavioral;
