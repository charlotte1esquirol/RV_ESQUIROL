--!
--! File MUXs_tb.vhd
--! \brief  TestBench of the MUXs blocs of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date May 2022
--!
--!
--!MUXs_tb design with different inputs :\n

--!\n
--! **behavior** 
--!      - Test all the behaviours


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;

entity MUXs_tb is

end MUXs_tb;

architecture Behavioral of MUXs_tb is

	constant N : natural := 32;

	component MUX2TO1 

	generic (
		DWIDTH: natural := 32  );  -- Number of data bits per input/output

		Port ( SEL: in std_logic;
			DATA0: in std_logic_vector (DWIDTH-1 downto 0);
			DATA1: in std_logic_vector (DWIDTH-1 downto 0);
			RESULT: out std_logic_vector (DWIDTH-1 downto 0));	

	end component MUX2TO1;

	component MUX4TO1 

	generic (
		DWIDTH: natural := 32  );  -- Number of data bits per input/output

		port ( SEL: in std_logic_vector (1 downto 0);
			DATA0: in std_logic_vector (DWIDTH-1 downto 0);
			DATA1: in std_logic_vector (DWIDTH-1 downto 0);
			DATA2: in std_logic_vector (DWIDTH-1 downto 0);
			DATA3: in std_logic_vector (DWIDTH-1 downto 0);
			RESULT: out std_logic_vector (DWIDTH-1 downto 0));	

	end component MUX4TO1;
     

signal sSEL_MUX2: STD_LOGIC;
signal sSEL_MUX4: STD_LOGIC_VECTOR (1 downto 0);

signal sDATA0_MUX2, sDATA0_MUX4, sDATA1_MUX2, sDATA1_MUX4, sDATA2_MUX4, sDATA3_MUX4, sRESULT_MUX2, sRESULT_MUX4 : STD_LOGIC_VECTOR(N-1 downto 0);




begin 



	mux2 : MUX2TO1 generic map (DWIDTH=>N) port map (DATA0=>sDATA0_MUX2, DATA1=>sDATA1_MUX2, SEL =>sSEL_MUX2, RESULT=>sRESULT_MUX2 );
	mux4 : MUX4TO1 generic map (DWIDTH=>N) port map (DATA0=>sDATA0_MUX4, DATA1=>sDATA1_MUX4, DATA2=>sDATA2_MUX4, DATA3=>sDATA3_MUX4, SEL =>sSEL_MUX4, RESULT=>sRESULT_MUX4 );





process

    begin 

    -- on commence par donner des valeurs aux DATA

	sDATA0_MUX2<="00000000000000000000000000000000";
	sDATA1_MUX2<="00000000000000000000000000000001";
	sDATA0_MUX4<="10000000000000000000000000000000";
	sDATA1_MUX4<="10000000000000000000000000000001";
	sDATA2_MUX4<="10000000000000000000000000000010";	
	sDATA3_MUX4<="10000000000000000000000000000011";

    -- on met des premières valeurs au SELs ( 0 pour les 2 )
	sSEL_MUX2<='0';
	sSEL_MUX4<="00";

	wait for 30 ns;

    -- on met d'autres valeurs

	sSEL_MUX2<='1';
	sSEL_MUX4<="00";
        wait for 30 ns; 

    -- 
	sSEL_MUX2<='0';
	sSEL_MUX4<="01";

        wait for 30 ns; 

     -- 

	sSEL_MUX4<="10";

        wait for 30 ns;

     -- on reset  

	sSEL_MUX4<="11";

        wait for 30 ns; 

     -- on reset  

	sSEL_MUX2<='1';
	
	wait for 200 ns;

     end process;

end Behavioral;

        








