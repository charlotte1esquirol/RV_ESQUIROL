--!
--! File InstrMemory.vhd
--! \brief Slave InstrMemory of the amba protocol of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!InstrMemory design with :\n
--!	 - 2 packages : rv_esquirol_pkg and rv_esquirol_application_image_pkg\n
--!      - 5 input signals : clk, PADDRX, PSTRB, PENABLE, PSEL\n
--!      - 2 output signals : PREADY, PRDATA\n
--!\n
--! **behavior** 
--!      - Copy the value at the (PADDRX)-position of the table of the slave and paste it in PRDATA byte per byte if PSTRB(bit per bit) is a 1.\n
--!      - Link PREADY to PENABLE\n
--!

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.rv_esquirol_pkg.all;
use work.rv_esquirol_application_image_pkg.all;




entity InstrMemory is

generic (X: natural := 16  );  -- Number of address bits


  Port (
	CLK : in STD_LOGIC;
	PRDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
	PREADY : out STD_LOGIC;
	PADDRX : in STD_LOGIC_VECTOR ( X-1 downto 0 );
	PSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
	PENABLE : in STD_LOGIC;
	PSEL : in STD_LOGIC);


end InstrMemory;


architecture Behavioral of InstrMemory is 


constant mem_rom : mem32_t(0 to 2**X-1) := mem32_init_f(application_image, 2**X);

alias B0 : std_logic is PSTRB ( 0 );
alias B1 : std_logic is PSTRB ( 1 );
alias B2 : std_logic is PSTRB ( 2 );
alias B3 : std_logic is PSTRB ( 3 );


alias BYTE0 : std_logic_vector is PRDATA ( 7 downto 0 );
alias BYTE1 : std_logic_vector is PRDATA ( 15 downto 8 );
alias BYTE2 : std_logic_vector is PRDATA ( 23 downto 16 );
alias BYTE3 : std_logic_vector is PRDATA ( 31 downto 24 );


constant ZERO : STD_LOGIC_VECTOR ( 7 downto 0 ) := "00000000";


begin 

    react: Process (clk) is

    begin




     if rising_edge(clk) then
	
	if (PSEL='1') then
          -- clock edge reaction here

            -- PSTRB0

	    if ( B0 = '1' ) then
	
		BYTE0 <= mem_rom(to_integer(unsigned(PADDRX)))( 7 downto 0) ;

	    else 
		BYTE0 <= ZERO;

	    end if; 

	    -- PSTRB1

            if ( B1 = '1' ) then
	
		BYTE1 <= mem_rom(to_integer(unsigned(PADDRX)))( 15 downto 8);

	    else 
		BYTE1 <= ZERO;

	    end if;

	    -- PSTRB2

            if ( B2 = '1' ) then
	
		BYTE2 <= mem_rom(to_integer(unsigned(PADDRX)))( 23 downto 16);

	    else 
		BYTE2 <= ZERO;

	    end if;

	    -- PSTRB3

            if ( B3 = '1' ) then
	
		BYTE3 <= mem_rom(to_integer(unsigned(PADDRX)))( 31 downto 24);

	    else 
		BYTE3 <= ZERO;

	    end if;
	
	end if;



      end if;

   
    end process react;

PREADY<=PENABLE; 


end Behavioral;


