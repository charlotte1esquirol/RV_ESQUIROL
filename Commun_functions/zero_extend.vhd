--!
--! File zero_extend.vhd
--! \brief zero_extend bloc of the Memory Interface of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!zero_extend design with :\n
--!      - 1 input signal : Din\n
--!      - 1 output signal : Dout (result of a 32-bits extension) \n
--!\n
--! **behavior** 
--!      - Take a 32-bits input signal.  \n
--!      - Extend this signal in a 64_bit signal \n
--!

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;



entity zero_extend is



  Port (Din :  in STD_LOGIC_VECTOR (31 downto 0);
    	Dout : out STD_LOGIC_VECTOR (63 downto 0));       


end zero_extend;

architecture Behavioral of zero_extend is

signal sig1 : STD_LOGIC_VECTOR ( 63 downto 0 );
alias sigsize : std_logic_vector is sig1 ( 31 downto 0 );
alias sigzero : std_logic_vector is sig1 ( 63 downto 32 );


begin

	sigzero <= "00000000000000000000000000000000";
	sigsize <= Din;
	Dout <= sig1;
		

end Behavioral;

