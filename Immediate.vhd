library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;




entity Immediate is

  Port (RI :  in STD_LOGIC_VECTOR(31 downto 0);
        I : out STD_LOGIC_VECTOR(11 downto 0);
	S : out STD_LOGIC_VECTOR(11 downto 0);
    	U : out STD_LOGIC_VECTOR(19 downto 0);
	B : out STD_LOGIC_VECTOR(19 downto 0);
	J : out STD_LOGIC_VECTOR(19 downto 0));
       


end Immediate;






architecture Behavioral of Immediate is

alias ImmI : std_logic_vector is RI ( 31 downto 20 );
alias ImmS1 : std_logic_vector is RI ( 31 downto 25 );
alias ImmS2 : std_logic_vector is RI ( 11 downto 7 );
alias ImmB1 : std_logic is RI ( 31 );
alias ImmB2 : std_logic is RI ( 7 );
alias ImmB3 : std_logic_vector is RI ( 30 downto 25 );
alias ImmB4 : std_logic_vector is RI ( 11 downto 8 );
alias ImmJ1 : std_logic is RI ( 31 );
alias ImmJ2 : std_logic_vector is RI ( 19 downto 12 );
alias ImmJ3 : std_logic is RI ( 20 );
alias ImmJ4 : std_logic_vector is RI ( 30 downto 21 );
alias ImmU : std_logic_vector is RI ( 31 downto 12 );



alias S1 : std_logic_vector is S ( 11 downto 5 );
alias S2 : std_logic_vector is S ( 4 downto 0 );
alias B1 : std_logic is B ( 11 );
alias B2 : std_logic is B ( 10 );
alias B3 : std_logic_vector is B ( 9 downto 4 );
alias B4 : std_logic_vector is B ( 3 downto 0 );
alias J1 : std_logic is J ( 19 );
alias J2 : std_logic_vector is J ( 18 downto 11 );
alias J3 : std_logic is J ( 10 );
alias J4 : std_logic_vector is J ( 9 downto 0 );


    begin


	I<=ImmI;
	U<=ImmU;
	S1<=ImmS1;
	S2<=ImmS2;
	B1<=ImmB1;
	B2<=ImmB2;
	B3<=ImmB3;
	B4<=ImmB4;
	J1<=ImmJ1;
	J2<=ImmJ2;
	J3<=ImmJ3;
	J4<=ImmJ4;



end Behavioral;

