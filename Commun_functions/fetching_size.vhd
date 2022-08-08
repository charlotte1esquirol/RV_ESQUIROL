--!
--! File fetching_size.vhd
--! \brief fetching_size bloc of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date July 2022
--!
--!
--!fetching_size design with :\n
--!      - 2 input signals : CONTROL, funct3n2 ( the two LSB bits of funct3 )\n
--!      - 1 output signal : funcfetch\n
--!\n
--! **behavior** 
--!      - Take the bit 29 of the output, which is the signal fetching. It indicates if we are in a fetch instruction or not\n
--!      - If we are in a fetching instruction, PSTRB need to be 1111, so the new 2 LSB bits of funct3 need to be "11". If we are not in a fetch, the 2 LSB bits of funct3 doesn't change.  \n
--!



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

