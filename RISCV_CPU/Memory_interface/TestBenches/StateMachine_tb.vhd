--! File StateMachine_tb.vhd
--! \brief TestBench of the Common StateMachine of the Memory Interface
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!StateMachine_tb design with :\n
--!      - 5 input signals : clk, rst, trigger, pready, unaligned \n
--!      - 6 output signals : op1, op2, first_cycle, busy_sel, preq_sel, penable \n
--!\n
--! **behavior** 
--!      - Test all the behaviours.



library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity StateMachine_tb is

end StateMachine_tb; 


architecture Behavioral of StateMachine_tb is

component StateMachine

	port
	(
		clk : in std_logic;
		rst	 : in	std_logic;
		trigger	 : in	std_logic;
		PREADY	 : in	std_logic;
		unaligned : in std_logic;
		op1 : out std_logic;
		op2 : out std_logic;
		first_cycle : out std_logic;
		busy_sel : out std_logic_vector (1 downto 0) ;
		preq_sel : out std_logic;
		PENABLE : out std_logic);

end component; 

     


signal sbusy : STD_LOGIC_VECTOR(1 downto 0);

signal sCLK, sRST, strigger, sPREADY, sunaligned, sop1, sop2, sfirst, sPENABLE, spreq : STD_LOGIC; 



begin 



UUT : StateMachine port map ( clk=>sCLK, rst=>sRST, trigger=>strigger, PREADY=>sPREADY, unaligned=>sunaligned, op1=>sop1, op2=>sop2, first_cycle=>sfirst, preq_sel=>spreq, busy_sel=>sbusy, PENABLE => sPENABLE );



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

	sRST<='0';
	wait for 30 ns;

    -- cas où on reste à s0

   	sRST<='1'; 

	strigger<='0';

        sPREADY<='0';

        sunaligned<='0';
        
        wait for 30 ns;

     -- cas où on passe à s1 et y reste

        strigger<='1';

        wait for 30 ns; 

     -- cas où on revient à s1 et repasse à s0 au prochain clock edge

        sPREADY<='1'; 

        wait for 40 ns; 

     -- cas où on passe à s2 et ensuite forcement à s3 puis à s0

        sunaligned<='1';

        wait for 200 ns;

     end process;

end Behavioral;

        








