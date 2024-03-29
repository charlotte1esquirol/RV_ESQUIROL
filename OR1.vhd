library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;



entity OR1 is



  Port (Din :  in STD_LOGIC_VECTOR (3 downto 0);
    	Dout : out STD_LOGIC);       


end OR1 ;

architecture Behavioral of OR1 is

alias bit0 : std_logic is Din ( 0 );
alias bit1 : std_logic is Din ( 1 );
alias bit2 : std_logic is Din ( 2 );
alias bit3 : std_logic is Din ( 3 );


begin
	process ( Din )

	begin

	if ( bit0 = '1' ) then
		Dout <= '1';
	elsif ( bit1 = '1' ) then 
		Dout <= '1';
	elsif ( bit2 = '1' ) then 
		Dout <= '1';
	elsif ( bit3 = '1' ) then 
		Dout <= '1';
	else 
		Dout <= '0';
	end if;

	end process;

end Behavioral;

