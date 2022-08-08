--! File Regfile_2_clock_edge_tb.vhd
--! \brief TestBench of the Regfile bloc of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date May 2022
--!
--!
--!Regfile_2_clock_edge_tb design with :\n
--!      - 7 input signals : w_data, w_address, w_command,  r0_address, r1_address, clk, reset\n
--!      - 2 output signals : r0_data, r1_data \n
--!\n
--! **behavior** 
--!      - Test all the behaviours \n
--!

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity MUX_tb is

end MUX_tb; 


architecture Behavioral of MUX_tb is

component MUX

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



UUT : MUX port map ( W_DATA=>sWD, W_ADDRESS=>sWA, W_COMMAND=>sWC, R0_DATA=>sR0D, R0_ADDRESS=>sR0A, R0_COMMAND=>sR0C, R1_DATA=>sR1D, R1_ADDRESS=>sR1A, R1_COMMAND=>sR1C, RESET=>sRESET, CLK => sCLK );



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

    -- cas où aucune permission ( ni read ni write ) et que Write_address = 0 pour tester si r0 est bien ignoré.

   	sRESET<='1'; 

	sWD<="00000000000000000000000000000011";

        sWA<="00000";

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



    -- On va maintenant remplir le tableau regfile
	sR0C<='0';
	sR1C<='0'; 

	sWD<="00000000000000000000000001100100";
        sWA<="00000";
	wait for 20 ns;

	sWD<="00000000000000000000000001100011";
        sWA<="00001";
	wait for 20 ns;

	sWD<="00000000000000000000000001100010";
        sWA<="00010";
	wait for 20 ns;

	sWD<="00000000000000000000000001100001";
        sWA<="00011";
	wait for 20 ns;



	sWD<="00000000000000000000000001000111";
        sWA<="11101";
	wait for 20 ns;

	sWD<="00000000000000000000000001000110";
        sWA<="11110";
	wait for 20 ns;

	sWD<="00000000000000000000000001000101";
        sWA<="11111";
	wait for 20 ns;

    -- On va maintenant lire les registres
	sR0C<='1';
	sR1C<='1'; 


	sR0A<="00000";
	sR1A<="00001";
	wait for 20 ns;

	sR0A<="00001";
	sR1A<="00010";
	wait for 20 ns;

	sR0A<="00011";
	sR1A<="11101";
	wait for 20 ns;

	sR0A<="11110";
	sR1A<="11111";
	wait for 20 ns;
	

     -- on reset  

     sRESET<='1'; 

        wait for 30 ns; 

     end process;

end Behavioral;

        








