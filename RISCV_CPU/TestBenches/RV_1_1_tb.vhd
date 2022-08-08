--!
--! File RV_1_1_tb.vhd
--! \brief TestBench of the RV part ( link of item_controlu, the item_PC, the Regfile, the ALU_and_MUX, the Memory_interface_symbol and 2 MUXs )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!RV_1_1_tb design with :\n
--!      - 4 input signals : clk_ma, rst_ma, prdata, pready \n
--!      - 6 output signals : paddr, pstrb, pwdata, pwrite, penable, preq \n
--!\n
--! **behavior** 
--!      - Test all the behaviours \n

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity RV_1_1_tb is

end RV_1_1_tb; 


architecture Behavioral of RV_1_1_tb is

component RV_1_1

  Port (
	CLK_ma : in STD_LOGIC;
	RST_ma : in STD_LOGIC;
	PRDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
	PREADY : in STD_LOGIC;
	PADDR : out STD_LOGIC_VECTOR ( 29 downto 0 );
	PSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
	PWDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
	PWRITE : out STD_LOGIC;
	PENABLE : out STD_LOGIC;
	PREQ : out STD_LOGIC);

end component; 


signal sPRDATA, sPWDATA: STD_LOGIC_VECTOR(31 downto 0);
signal sPREADY, sCLK_ma, sRST_ma, sPWRITE, sPENABLE, sPREQ: STD_LOGIC; 
signal sPADDR: STD_LOGIC_VECTOR(29 downto 0);
signal sPSTRB: STD_LOGIC_VECTOR(3 downto 0);



begin 

UUT : RV_1_1 port map ( PRDATA=>sPRDATA, PWDATA=>sPWDATA, PREADY=>sPREADY, CLK_ma=>sCLK_ma, RST_ma=>sRST_ma, PWRITE=>sPWRITE, PENABLE=>sPENABLE, PREQ=>sPREQ, PADDR=>sPADDR, PSTRB=>sPSTRB);

process 

    begin

    sCLK_ma <='0';

        wait for 10 ns;

    sCLK_ma <='1';

        wait for 10 ns;

    end process;


process

    begin 

	-- On reset pour bien demarrer

	sRST_ma<='0';
	wait until rising_edge(sCLK_ma);
	wait until rising_edge(sCLK_ma);
	wait for 5 ns;

	-- On initialise

	sRST_ma<='1';
	sPRDATA<="00111111110000000101000000010011";
	sPREADY<='1';
	
	wait until rising_edge(sCLK_ma);
	wait until rising_edge(sCLK_ma);
	wait until rising_edge(sCLK_ma);
	wait for 5 ns; 

	sPREADY<='0';

	wait until rising_edge(sCLK_ma);
	wait until rising_edge(sCLK_ma);
	wait until rising_edge(sCLK_ma);
	wait for 55 ns;





	
   
end process;

end Behavioral;
