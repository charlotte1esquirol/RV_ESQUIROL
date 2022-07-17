library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity Regfile_1_clock_edge_tb is

end Regfile_1_clock_edge_tb; 


architecture Behavioral of Regfile_1_clock_edge_tb is

component Regfile_1_clock_edge

Port ( W_DATA : in STD_LOGIC_VECTOR (31 downto 0);
         W_ADDRESS : in STD_LOGIC_VECTOR (4 downto 0);
         W_COMMAND : in STD_LOGIC;
         R0_DATA : out STD_LOGIC_VECTOR (31 downto 0);
         R0_ADDRESS: in STD_LOGIC_VECTOR (4 downto 0);
         R0_COMMAND : in STD_LOGIC;
         R1_DATA : out STD_LOGIC_VECTOR (31 downto 0);
         R1_ADDRESS: in STD_LOGIC_VECTOR (4 downto 0);
         R1_COMMAND : in STD_LOGIC;
         RESET : in STD_LOGIC;
         CLK : in STD_LOGIC);

end component; 

     

signal sWD,sR0D,sR1D : STD_LOGIC_VECTOR(31 downto 0);

signal sWA,sR0A,sR1A : STD_LOGIC_VECTOR(4 downto 0);

signal sCLK, sRESET, sWC, sR0C, sR1C : STD_LOGIC; 



begin 



UUT : Regfile_1_clock_edge port map ( W_DATA=>sWD, W_ADDRESS=>sWA, W_COMMAND=>sWC, R0_DATA=>sR0D, R0_ADDRESS=>sR0A, R0_COMMAND=>sR0C, R1_DATA=>sR1D, R1_ADDRESS=>sR1A, R1_COMMAND=>sR1C, RESET=>sRESET, CLK => sCLK );



process 

    begin

    sCLK <='0';

        wait for 10 ns;

    sCLK <='1';

        wait for 10 ns;

    end process;





process

    begin 

    -- on commence par un reset pour tout bien mettre à 0

	sReset<='0';
	wait for 30 ns;

    -- cas où aucune permission ( ni read ni write )

   	sRESET<='1'; 

	sWD<="00000000000000000000000000000011";

        sWA<="00001";

        sWC<='0';

        sR0A<="00000";

        sR0C<='0'; 

        sR1A<="00001";

        sR1C<='0';

        

        wait for 30 ns;

     -- cas où w_command='1'

        sWC<='1';

        wait for 30 ns; 

     -- cas où r0_command='1'

        sR0C<='1'; 

        wait for 30 ns; 

     -- cas où r1_command='1'

        sR1C<='1';

        wait for 30 ns;

     -- on reset  

     sRESET<='1'; 

        wait for 200 ns; 

     end process;

end Behavioral;

        








