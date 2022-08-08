--! File StateMachine.vhd
--! \brief Common StateMachine of the Memory Interface
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!StateMachine design with :\n
--!      - 5 input signals : clk, rst, trigger, pready, unaligned \n
--!      - 6 output signals : op1, op2, first_cycle, busy_sel, preq_sel, penable \n
--!\n
--! **behavior** 
--!      - It is a basic StateMachine with conditions to change of state.


library ieee;
use ieee.std_logic_1164.all;

entity StateMachine is

	port
	(
		clk : in std_logic;
		rst	 : in	std_logic;
		trigger	 : in	std_logic;
		PREADY	 : in	std_logic;
		unaligned : in std_logic;
		op1 : out std_logic;
		op2 : out std_logic;
		first_cycle : out std_logic;
		busy_sel : out std_logic_vector (1 downto 0) ;
		preq_sel : out std_logic;
		PENABLE : out std_logic);
	
end entity;

architecture rtl of StateMachine is

	-- Build an enumerated type for the state machine
	type state_type is (stOp1A, stOp1B, stOp2A, stOp2B);
	
	-- Register to hold the current state
	signal state : state_type;

begin
	process (clk, rst)
	begin
		if rst = '0' then
			state <= stOp1A;
		elsif (rising_edge(clk)) then
			-- Determine the next state synchronously, based on
			-- the current state and the input
			case state is
				when stOp1A=>
					if (trigger='1') then
						state <= stOp1B;
					else
						state <= stOp1A;
					end if;
				when stOp1B=>
					if (PREADY='1' and unaligned='1') then
						state <= stOp2A;
					elsif (PREADY='1' and unaligned='0') then
						state <= stOp1A;
					else
						state <= stOp1B;
					end if;
				when stOp2A=>
					--if data_in = '1' then
						state <= stOp2B;
					--else
						--state <= s2;
					--end if;
				when stOp2B=>
					if PREADY = '1' then
						state <= stOp1A;
					else
						state <= stOp2B;
					end if;
			end case;
			
		end if;
	end process;
	

	process (state)
	begin
		case state is
			when stOp1A=>
				op1 <= '1';
				op2  <= '0';
				first_cycle  <= '1';
				busy_sel  <= "00";
				preq_sel  <= '0';
				PENABLE  <= '0';
			when stOp1B=>
				op1 <= '1';
				op2  <= '0';
				first_cycle  <= '0';
				busy_sel  <= "01";
				preq_sel  <= '1';
				PENABLE  <= '1';
			when stOp2A=>
				op1 <= '0';
				op2  <= '1';
				first_cycle  <= '0';
				busy_sel  <= "10";
				preq_sel  <= '1';
				PENABLE  <= '0';
			when stOp2B=>
				op1 <= '0';
				op2  <= '1';
				first_cycle  <= '0';
				busy_sel  <= "11";
				preq_sel  <= '1';
				PENABLE  <= '1';
		end case;
	end process;
	
end rtl;
