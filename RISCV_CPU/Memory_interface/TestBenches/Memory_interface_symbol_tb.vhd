--!
--! File memory_interface_symbol_tb.vhd
--! \brief  TestBench of the Memory part ( link of the item_size, the memory_item_paddr, the memory_item_pwdata, memory_item_pwrite, memory_item_rdata, the StateMachine, the register, the OR and 2 MUXs )of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!memory_interface_symbol_tb design with :\n
--!      - 10 input signals : clkm, rstm, prdatam, preadym, rd_im, wr_im, addr_im, unsigned_im, size_im, wdata_im \n
--!      - 9 output signals :  paddrm, pstrbm, pwdatam, pwritem, penablem, preqm, busy_om, rdata_om, rdata_unbuff_om \n
--!\n
--! **behavior** 
--!      - Test all the behaviours


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity Memory_interface_symbol_tb is

end Memory_interface_symbol_tb; 


architecture Behavioral of Memory_interface_symbol_tb is

component Memory_interface_symbol

generic (DWIDTH: natural := 32  );  -- Number of data bits per input/outp



  Port (CLKm : in STD_LOGIC;
	RSTm : in STD_LOGIC;
	PRDATAm : in STD_LOGIC_VECTOR (31 downto 0);
	PREADYm : in STD_LOGIC;
	rd_im : in STD_LOGIC;
	wr_im : in STD_LOGIC;
	addr_im : in STD_LOGIC_VECTOR (31 downto 0);
	unsigned_im: in STD_LOGIC;
	size_im : in STD_LOGIC_VECTOR (1 downto 0);
	wdata_im : in STD_LOGIC_VECTOR (31 downto 0);
	PADDRm : out STD_LOGIC_VECTOR (29 downto 0);
	PSTRBm : out STD_LOGIC_VECTOR (3 downto 0);
	PWDATAm : out STD_LOGIC_VECTOR (31 downto 0);
	PWRITEm : out STD_LOGIC;
	PENABLEm : out STD_LOGIC;
	PREQm: out STD_LOGIC;
	busy_om : out STD_LOGIC;
	rdata_om : out STD_LOGIC_VECTOR (31 downto 0);
	rdata_unbuff_om : out STD_LOGIC_VECTOR (31 downto 0));

end component; 

constant N : natural := 32;

signal ssize_im: STD_LOGIC_VECTOR(1 downto 0);
signal sPSTRBm: STD_LOGIC_VECTOR(3 downto 0);
signal saddr_im, sPRDATAm, swdata_im, srdata_om, srdata_unbuff_om, sPWDATAm : STD_LOGIC_VECTOR(31 downto 0);
signal sPADDRm: STD_LOGIC_VECTOR(29 downto 0);
signal sCLKm, sRSTm, sunsigned_im, sPWRITEm, sPENABLEm, sPREQm, sbusy_om,  sPREADYm, srd_im, swr_im: STD_LOGIC; 

begin 

UUT : Memory_interface_symbol generic map (DWIDTH=>N) port map ( CLKm=>sCLKm, size_im=>ssize_im, PSTRBm=>sPSTRBm, addr_im=>saddr_im, PRDATAm=>sPRDATAm, wdata_im=>swdata_im, rdata_om=>srdata_om, rdata_unbuff_om=>srdata_unbuff_om, PWDATAm=>sPWDATAm, PADDRm=>sPADDRm, RSTm=>sRSTm, unsigned_im=>sunsigned_im, PWRITEm=>sPWRITEm, PENABLEm=>sPENABLEm, PREQm=>sPREQm, busy_om=>sbusy_om, PREADYm=>sPREADYm, rd_im=>srd_im, wr_im=>swr_im );

process 

    begin

    sCLKm <='0';

        wait for 10 ns;

    sCLKm <='1';

        wait for 10 ns;

    end process;


process

    begin 


	-- RESET

	sRSTm<='0';

	-- On initialise



	sPRDATAm<="00000000000000001111111111111111";
	sPREADYm<='1';
	srd_im<='1';
	swr_im<='1';
	saddr_im<="00000000000000001111111100000000";
	ssize_im<="01";
	sunsigned_im<='1';
	swdata_im<="11111111000000001111111100000000";
	wait for 30 ns; 

	----
	sRSTm<='1'; 

	wait for 30 ns; 


	sPREADYm<='0';
	wait for 30 ns;

	----
	srd_im<='0';
	wait for 30 ns;

	swr_im<='0';
	wait for 30 ns;

	----

	ssize_im<="10";
	wait for 30 ns;

	sunsigned_im<='0';
	wait for 50 ns;


	ssize_im<="11";
	wait for 30 ns;


	
   
end process;

end Behavioral;
