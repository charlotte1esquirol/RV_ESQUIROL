library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity item_controlu_tb is

end item_controlu_tb; 


architecture Behavioral of item_controlu_tb is

component item_controlu

  Port (
	CLK_co : in STD_LOGIC;
	RST_co : in STD_LOGIC;
	MemBusy_co : in STD_LOGIC;
	wIR_co : in STD_LOGIC;
	Value_Imem : in STD_LOGIC_VECTOR( 31 downto 0 );
	funct3 : out STD_LOGIC_VECTOR ( 2 downto 0 );
	rs1 : out STD_LOGIC_VECTOR ( 4 downto 0 );
	rs2 : out STD_LOGIC_VECTOR ( 4 downto 0 );
	rd : out STD_LOGIC_VECTOR ( 4 downto 0);
	Iim : out STD_LOGIC_VECTOR ( 31 downto 0);
	Sim : out STD_LOGIC_VECTOR ( 31 downto 0);
	Uim : out STD_LOGIC_VECTOR ( 31 downto 0);
	Bim : out STD_LOGIC_VECTOR ( 31 downto 0);
	Jim : out STD_LOGIC_VECTOR ( 31 downto 0);
	CONTROL_signal : out STD_LOGIC_VECTOR ( 31 downto 0));

end component; 


signal sValue_Imem, sIim, sSim, sUim, sBim, sJim, sCONTROL_signal: STD_LOGIC_VECTOR(31 downto 0);
signal sMemBusy_co, sCLK_co, sRST_co, swIR_co: STD_LOGIC; 
signal srs1, srs2, srd: STD_LOGIC_VECTOR(4 downto 0);
signal sfunct3: STD_LOGIC_VECTOR(2 downto 0);



begin 



UUT : item_controlu port map ( Value_Imem=>sValue_Imem, Iim=>sIim, Sim=>sSim, Bim=>sBim, Jim=>sJim, CONTROL_signal=>sCONTROL_signal, MemBusy_co=>sMemBusy_co, CLK_co=>sCLK_co, RST_co=>sRST_co, wIR_co=>swIR_co, rs1=>srs1, rs2=>srs2, rd=>srd, funct3=>sfunct3 );

process 

    begin

    sCLK_co <='0';

        wait for 10 ns;

    sCLK_co <='1';

        wait for 10 ns;

    end process;


process

    begin 

	-- On reset pour bien demarrer

	sRST_co<='0';
	wait for 30 ns;

	-- On initialise

	sRST_co<='1';
	sValue_Imem<="00000000000000000101000000010011";
	sMemBusy_co<='0';
	swIR_co<='1';
	
	wait for 30 ns; 

	swIR_co<='0';
	wait for 30 ns;

	sValue_Imem<="00000000000000000001000000110011";
	wait for 30 ns;

	swIR_co<='1';
	sMemBusy_co<='1';
	wait for 30 ns;

	sMemBusy_co<='0';
	wait for 50 ns;



	
   
end process;

end Behavioral;
