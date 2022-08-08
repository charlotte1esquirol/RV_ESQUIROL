--!
--! File size_strobes.vhd
--! \brief size_strobes bloc of the Memory Interface of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!size_strobes design with :\n
--!      - 1 input signal : size \n
--!      - 1 output signal : strobes \n
--!\n
--! **behavior** 
--!      - Take a 2-bits input signal. \n
--!      - According to this signal, strobes is the output which correspond \n
--!


library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;



entity size_strobes is



  Port (size :  in STD_LOGIC_VECTOR (1 downto 0);
    	strobes : out STD_LOGIC_VECTOR (7 downto 0));       


end size_strobes;

architecture Behavioral of size_strobes is



begin

	process ( size )

	begin

	if (size="00") then
		
		strobes <= "00000001";

	elsif ( size = "01" ) then
		
		strobes <= "00000011";

	elsif ( size = "10" or size="11" ) then
		
		strobes <= "00001111";

	end if; 

	end process;

		

end Behavioral;

