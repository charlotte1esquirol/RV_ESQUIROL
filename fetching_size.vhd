library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;





entity fetching_size is

  Port (CONTROL :  in STD_LOGIC_VECTOR(31 downto 0);
	funct3n2 : in STD_LOGIC_VECTOR(1 downto 0);
	funcfetch : out STD_LOGIC_VECTOR( 1 downto 0));
       


end fetching_size;

architecture Behavioral of fetching_size is

alias fetching : std_logic is CONTROL ( 29 );

begin

    react: Process (funct3n2, CONTROL) is

    begin

	if (fetching='1') then

		funcfetch<="11";
	else
		funcfetch<=funct3n2;

	end if;

	end process react;

end Behavioral;

