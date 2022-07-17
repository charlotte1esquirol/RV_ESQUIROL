library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity AddressCounter is

  Port (WAITMEM : in STD_LOGIC;
	MEMBUSY : in STD_LOGIC;
	LOAD : in STD_LOGIC;
	LOAD_VAL : in STD_LOGIC_VECTOR ( 7 downto 0);
	VALU : out STD_LOGIC_VECTOR ( 7 downto 0);
	RESTART : in STD_LOGIC;
	RESET : in STD_LOGIC;
	CLK : in STD_LOGIC );
	

       

end AddressCounter;

architecture Behavioral of AddressCounter is

signal ONE : STD_LOGIC_VECTOR(7 downto 0);
signal VALU_bis : STD_LOGIC_VECTOR(7 downto 0);


begin 
	ONE <= "00000001";


    react: Process (reset, clk) is

    begin
	
	

	if (reset = '0') then
          -- reset action here
		VALU <= "00000000";
		VALU_bis <= "00000000";

	elsif rising_edge(clk) then

          -- clock edge reaction here
		if  (WAITMEM='0' or MEMBUSY='0') then
			if (RESTART='1') then
				VALU <= "00000001";
				VALU_bis <= "00000001";
			else 
				if (LOAD='1') then
					VALU <= std_logic_vector((unsigned(LOAD_VAL) + unsigned(ONE)));
					VALU_bis <= std_logic_vector((unsigned(LOAD_VAL) + unsigned(ONE)));
				else
					VALU <= std_logic_vector((unsigned(VALU_bis) + unsigned(ONE)));
					VALU_bis <= std_logic_vector((unsigned(VALU_bis) + unsigned(ONE)));
				end if;
			end if;
			
		end if;
	end if;

     end process react;

end Behavioral;
