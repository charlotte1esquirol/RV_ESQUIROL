library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.rv_esquirol_pkg.all;
use work.rv_esquirol_controlunit_image_pkg.all;
--use work.rom_mem_pkg_body.all;



entity DataMemory is

generic (X: natural := 16  );  -- Number of data bits per input/output


  Port (
	CLK : in STD_LOGIC;
	RST : in STD_LOGIC;
	PRDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
	PREADY : out STD_LOGIC;
	PADDRX : in STD_LOGIC_VECTOR ( X-1 downto 0 );
	PSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
	PWRITE : in STD_LOGIC;
	PWDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
	PENABLE : in STD_LOGIC;
	PSEL : in STD_LOGIC);


end DataMemory;


architecture Behavioral of DataMemory is 


constant mem_rom : mem32_t(0 to 31) := mem32_init_f(rom_memory, 32);

alias B0 : std_logic is PSTRB ( 0 );
alias B1 : std_logic is PSTRB ( 1 );
alias B2 : std_logic is PSTRB ( 2 );
alias B3 : std_logic is PSTRB ( 3 );

signal DATA : STD_LOGIC_VECTOR ( 31 downto 0 );
alias BYTE0 : std_logic_vector is DATA ( 7 downto 0 );
alias BYTE1 : std_logic_vector is DATA ( 15 downto 8 );
alias BYTE2 : std_logic_vector is DATA ( 23 downto 16 );
alias BYTE3 : std_logic_vector is DATA ( 31 downto 24 );

signal TABL : STD_LOGIC_VECTOR ( 31 downto 0 );
alias T0 : std_logic_vector is TABL ( 7 downto 0 );
alias T1 : std_logic_vector is TABL ( 15 downto 8 );
alias T2 : std_logic_vector is TABL ( 23 downto 16 );
alias T3 : std_logic_vector is TABL ( 31 downto 24 );

signal ZERO : STD_LOGIC_VECTOR ( 7 downto 0 );


begin 

    react: Process (clk, penable) is

    begin

     TABL<=mem_rom(to_integer(unsigned(PADDRX)));
     ZERO<="00000000";


     if rising_edge(clk) then
	
	if (PSEL='1') then
          -- clock edge reaction here

            -- PSTRB0

	    if ( B0 = '1' ) then
	
		BYTE0 <= T0;

	    else 
		BYTE0 <= ZERO;

	    end if; 

	    -- PSTRB1

            if ( B1 = '1' ) then
	
		BYTE1 <= T1;

	    else 
		BYTE1 <= ZERO;

	    end if;

	    -- PSTRB2

            if ( B2 = '1' ) then
	
		BYTE2 <= T2;

	    else 
		BYTE2 <= ZERO;

	    end if;

	    -- PSTRB3

            if ( B3 = '1' ) then
	
		BYTE3 <= T3;

	    else 
		BYTE3 <= ZERO;

	    end if;
	
	end if;

	PREADY<=PENABLE; 

      end if;

   
    end process react;


end Behavioral;


