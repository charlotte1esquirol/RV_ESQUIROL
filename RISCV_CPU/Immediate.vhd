--!
--! File Immediate.vhd
--! \brief Immediate bloc of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!Immediate design with :\n
--!      - 1 input signal : RI\n
--!      - 5 output signals : I, S, U, B,J\n
--!\n
--! **behavior** 
--!      - Take some bits of the RI instruction and reorganize them to create 12-bits  or 20-bits signed signals\n
--!      - Extend these signals in 32_bits signals \n
--!


library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;




entity Immediate is

  Port (RI :  in STD_LOGIC_VECTOR(31 downto 0);
        I : out STD_LOGIC_VECTOR(31 downto 0);
	S : out STD_LOGIC_VECTOR(31 downto 0);
    	U : out STD_LOGIC_VECTOR(31 downto 0);
	B : out STD_LOGIC_VECTOR(31 downto 0);
	J : out STD_LOGIC_VECTOR(31 downto 0));
       


end Immediate;






architecture Behavioral of Immediate is

alias ImmI1 : std_logic is RI ( 31);
alias ImmI2 : std_logic_vector is RI ( 30 downto 20 );

alias ImmS1 : std_logic is RI ( 31 );
alias ImmS2 : std_logic_vector is RI ( 30 downto 25 );
alias ImmS3 : std_logic_vector is RI ( 11 downto 7 );
alias ImmB1 : std_logic is RI ( 31 );
alias ImmB2 : std_logic is RI ( 7 );
alias ImmB3 : std_logic_vector is RI ( 30 downto 25 );
alias ImmB4 : std_logic_vector is RI ( 11 downto 8 );
alias ImmJ1 : std_logic is RI ( 31 );
alias ImmJ2 : std_logic_vector is RI ( 19 downto 12 );
alias ImmJ3 : std_logic is RI ( 20 );
alias ImmJ4 : std_logic_vector is RI ( 30 downto 21 );
alias ImmU1 : std_logic is RI ( 31 );
alias ImmU2 : std_logic_vector is RI ( 30 downto 12 );


alias I1 : std_logic is I ( 11 );
alias I2 : std_logic_vector is I ( 10 downto 0 );
alias I3 : std_logic_vector is I ( 31 downto 12 );

alias U1 : std_logic is U ( 19 );
alias U2 : std_logic_vector is U ( 18 downto 0 );
alias U3 : std_logic_vector is U ( 31 downto 20 );

alias S1 : std_logic is S ( 11 );
alias S2 : std_logic_vector is S ( 10 downto 5 );
alias S3 : std_logic_vector is S ( 4 downto 0 );
alias S4 : std_logic_vector is S ( 31 downto 12 );

alias B1 : std_logic is B ( 11 );
alias B2 : std_logic is B ( 10 );
alias B3 : std_logic_vector is B ( 9 downto 4 );
alias B4 : std_logic_vector is B ( 3 downto 0 );
alias B5 : std_logic_vector is B ( 31 downto 12 );

alias J1 : std_logic is J ( 19 );
alias J2 : std_logic_vector is J ( 18 downto 11 );
alias J3 : std_logic is J ( 10 );
alias J4 : std_logic_vector is J ( 9 downto 0 );
alias J5 : std_logic_vector is J ( 31 downto 20 );


    begin


	I1<=ImmI1;
	I2<=ImmI2;
	U1<=ImmU1;
	U2<=ImmU2;
	S1<=ImmS1;
	S2<=ImmS2;
	S3<=ImmS3;
	B1<=ImmB1;
	B2<=ImmB2;
	B3<=ImmB3;
	B4<=ImmB4;
	J1<=ImmJ1;
	J2<=ImmJ2;
	J3<=ImmJ3;
	J4<=ImmJ4;
	J5<=(others => ImmJ1);
	B5<=(others => ImmB1);
	S4<=(others => ImmS1);
	I3<=(others => ImmI1);
	U3<=(others => ImmU1);






end Behavioral;

