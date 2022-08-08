--! File TargetAddress.vhd
--! \brief TargetAddress bloc of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date May 2022
--!
--!
--!TargetAddress design with :\n
--!      - 2 input signals : DATA0, DATA1\n
--!      - 1 output signals : TARGET_PC \n
--!\n
--! **behavior** 
--!      - Does an addition between the two inputs and copies it in the output\n
--!


library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.muxs_pkg.all;


entity TargetAddress is


  Port (DATA0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
	DATA1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
	TARGET_PC : out STD_LOGIC_VECTOR ( 31 downto 0 ));


end TargetAddress;

architecture Behavioral of TargetAddress is

	begin

		TARGET_PC <= std_logic_vector((unsigned(DATA0) + unsigned(DATA1)));

end architecture Behavioral;

