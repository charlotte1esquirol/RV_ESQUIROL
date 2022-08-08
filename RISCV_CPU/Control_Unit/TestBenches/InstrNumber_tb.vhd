--!
--! File InstrNumber_tb.vhd
--! \brief TestBench of the InstrNumber bloc of the Control Unit of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!InstrNumber_tb design with :\n
--!      - 4 input signals : opcode, func3, func7, func12 \n
--!      - 1 output signal : number \n
--!\n
--! **behavior** 
--!      - Test all the behaviours of InstrNumber

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity InstrNumber_tb is

end InstrNumber_tb; 


architecture Behavioral of InstrNumber_tb is

component InstrNumber

  Port (FUNC12 : in STD_LOGIC;
	FUNC7 : in STD_LOGIC;
	FUNC3 : in STD_LOGIC_VECTOR ( 2 downto 0 );
	OPCODE : in STD_LOGIC_VECTOR ( 4 downto 0 );
	NUMBER : out STD_LOGIC_VECTOR ( 7 downto 0));

end component; 

     

signal sFUNC3 : STD_LOGIC_VECTOR(2 downto 0);

signal sOPCODE : STD_LOGIC_VECTOR(4 downto 0);

signal sNUMBER: STD_LOGIC_VECTOR(7 downto 0);

signal sFUNC12, sFUNC7: STD_LOGIC; 



begin 



UUT : InstrNumber port map ( FUNC3=>sFUNC3, FUNC7=>sFUNC7, FUNC12=>sFUNC12, OPCODE=>sOPCODE, NUMBER=>sNUMBER );



process

    begin 

	-- On initialise les valeurs 

	sFUNC3<="000";
	sFUNC7<='0';
	sFUNC12<='0';
	sOPCODE<="00100";

	wait for 30 ns;

	-- On en met d'autres ( verification de func12 )

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

        




