library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;





entity iPC_Control is

  Port (CONTROL :  in STD_LOGIC_VECTOR(31 downto 0);
	WaitMem : in STD_LOGIC;
	MemBusy : in STD_LOGIC;
        CONTROLSIG :out STD_LOGIC_VECTOR(31 downto 0));
       


end iPC_Control;

architecture Behavioral of iPC_Control is

alias iPC : std_logic is CONTROLSIG ( 5 );

begin

    react: Process (WaitMem, MemBusy, CONTROL) is

    begin

	if (WaitMem='0' or MemBusy='0') then

		CONTROLSIG<=CONTROL;
	else
		iPC<='0';

	end if;

	end process react;

end Behavioral;

