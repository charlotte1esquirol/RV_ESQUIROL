--!
--! File MUXs.vhd
--! \brief  MUXs blocs of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date May 2022
--!
--!
--!MUXs design with different inputs :\n

--!\n
--! **behavior** 
--!      - Creation of different multiplexers with different input sizes. We will use these multiplexers in all the design

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity MUX2TO1 is

generic (
	DWIDTH: natural := 32  );  -- Number of data bits per input/output

port (
	SEL: in std_logic;
	DATA0: in std_logic_vector (DWIDTH-1 downto 0);
	DATA1: in std_logic_vector (DWIDTH-1 downto 0);
	RESULT: out std_logic_vector (DWIDTH-1 downto 0));

end entity MUX2TO1;



architecture Behavioral of MUX2TO1 is

begin

	RESULT <= DATA0 when (SEL = '0')
		else  DATA1;

end architecture Behavioral;




library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity MUX2TO1single is


port (
	SEL: in std_logic;
	DATA0: in std_logic;
	DATA1: in std_logic;
	RESULT: out std_logic);

end entity MUX2TO1single;



architecture Behavioral of MUX2TO1single is

begin

	RESULT <= DATA0 when (SEL = '0')
		else  DATA1;

end architecture Behavioral;





library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MUX4TO1 is

generic (
	DWIDTH: natural := 32  );  -- Number of data bits per input/output

port (
	SEL: in std_logic_vector (1 downto 0) ;
	DATA0: in std_logic_vector (DWIDTH-1 downto 0);
	DATA1: in std_logic_vector (DWIDTH-1 downto 0);
	DATA2: in std_logic_vector (DWIDTH-1 downto 0);
	DATA3: in std_logic_vector (DWIDTH-1 downto 0);
	RESULT: out std_logic_vector (DWIDTH-1 downto 0));

end entity MUX4TO1;

architecture Behavioral of MUX4TO1 is

begin

	RESULT <= DATA0 when (SEL = "00")
		else DATA1 when (SEL = "01")
		else DATA2 when (SEL = "10")
		else DATA3;

end architecture Behavioral;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MUX4TO1single is


port (
	SEL: in std_logic_vector (1 downto 0) ;
	DATA0: in std_logic;
	DATA1: in std_logic;
	DATA2: in std_logic;
	DATA3: in std_logic;
	RESULT: out std_logic);

end entity MUX4TO1single;

architecture Behavioral of MUX4TO1single is

begin

	RESULT <= DATA0 when (SEL = "00")
		else DATA1 when (SEL = "01")
		else DATA2 when (SEL = "10")
		else DATA3;

end architecture Behavioral;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MUX3TO1 is

generic (
	DWIDTH: natural := 32  );  -- Number of data bits per input/output

port (
	SEL: in std_logic_vector (1 downto 0) ;
	DATA0: in std_logic_vector (DWIDTH-1 downto 0);
	DATA1: in std_logic_vector (DWIDTH-1 downto 0);
	DATA2: in std_logic_vector (DWIDTH-1 downto 0);
	RESULT: out std_logic_vector (DWIDTH-1 downto 0));

end entity MUX3TO1;

architecture Behavioral of MUX3TO1 is

begin

	RESULT <= DATA0 when (SEL = "00")
		else DATA1 when (SEL = "01")
		else DATA2 when (SEL = "10")
		else DATA0;

end architecture Behavioral;

