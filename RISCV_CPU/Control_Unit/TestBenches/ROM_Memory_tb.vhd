--!
--! File ROM_Memory_tb.vhd
--! \brief TestBench of the ROM table used in the Control Unit of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date May 2022
--!
--!
--!ROM_Memory_tb design with :\n
--!	 - 2 packages : rv_esquirol_pkg and rv_esquirol_controlunit_image_pkg\n
--!      - 5 input signals : clk, ADDRESS, waitmem, membusy, rst\n
--!      - 1 output signal : DATA\n
--!\n
--! **behavior** 
--!      - Test all the behaviours.\n




library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.rv_esquirol_pkg.all;
use work.rv_esquirol_controlunit_image_pkg.all;


entity ROM_Memory_tb is

end ROM_Memory_tb; 


architecture Behavioral of ROM_Memory_tb is

component ROM_Memory

  Port ( 
         ADDRESS : in STD_LOGIC_VECTOR (7 downto 0);
         DATA : out STD_LOGIC_VECTOR (31 downto 0);
         WAITMEM : in STD_LOGIC;
	 MEMBUSY : in STD_LOGIC;
	RST : in STD_LOGIC;
         CLK : in STD_LOGIC);

end component; 

     

signal sDATA : STD_LOGIC_VECTOR(31 downto 0);

signal sADDRESS: STD_LOGIC_VECTOR(7 downto 0);

signal sCLK, sRST, sWAITMEM, sMEMBUSY: STD_LOGIC; 

constant mem_rom : mem32_t(0 to 31) := mem32_init_f(control_unit_image, 32);


begin 



UUT : ROM_Memory port map ( RST=>sRST, DATA=>sDATA, ADDRESS=>sADDRESS, WAITMEM=>sWAITMEM, MEMBUSY=>sMEMBUSY, CLK => sCLK );



process 

    begin

    sCLK <='0';

        wait for 10 ns;

    sCLK <='1';

        wait for 10 ns;
    
end process;





process

    begin 

	-- On initialise les entrees pour que rien ne se passe
	sRST<='0'; 

	sWAITMEM<='1';
	sMEMBUSY<='1';
	sADDRESS<="00000000";
	
	wait until rising_edge(sCLK);
	wait for 5 ns;

	-- On met seulement sWAITMEM à 0

	sRST<='1';
	SWAITMEM<='0';
	wait until rising_edge(sCLK);
	wait for 5 ns;

	-- On met seulement MEMBUSY à 0

	sWAITMEM<='1';
	sMEMBUSY<='0';
	wait until rising_edge(sCLK);
	wait for 5 ns;

	-- On met les 2 à 0

	sWAITMEM<='0';
	wait until rising_edge(sCLK);
	wait for 5 ns;

	-- On change la valeur de ADDRESS

	sADDRESS<="00000001";
	wait until rising_edge(sCLK);
	wait for 5 ns;

	-- On change la valeur de ADDRESS

	sADDRESS<="00000010";
	wait until rising_edge(sCLK);
	wait for 5 ns;
	-- On change la valeur de ADDRESS

	sADDRESS<="00001000";
	wait until rising_edge(sCLK);
	wait for 5 ns;

	-- On change la valeur de ADDRESS

	sADDRESS<="11111111";
	for i in 0 to 6 loop
		wait until rising_edge(sCLK);
	end loop;
	wait for 5 ns;


   
end process;

end Behavioral;

        








