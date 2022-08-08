--!
--! File AddressCounter.vhd
--! \brief Address Counter of the Control Unit of the RISC-V design
--! \author Esquirol Charlotte
--! \version 0.1
--! \date June 2022
--!
--!
--!AddressCounter design with :\n
--!      - 7 inputs signals : reset, clk, waitmem, membusy, load, load_val, restart \n
--!      - 1 output signal : valu \n
--!\n
--! **behavior**\n
--!     - 1)The address counter resets asynchronously to 0x00 (binary) with reset; otherwise,\n
--!      - 2)If the counter is enabled, then on the rising edge of the clock:\n
--!          - a)If EOI = 1 then the address counter resets synchronously to the value 0x01; otherwise,\n
--!          - b)If EOF = 1 then the address counter loads INUM+1; otherwise,\n
--!          - c)If none of the above, the address counter counts up.\n
--!
--!**The address counter is enabled if:**\n
--!      - There is no ongoing memory operation (waitMEM = 0), or\n
--!      - There is an ongoing memory operation (waitMEM = 1) and the memory interface has signaled this is the last cycle of the operation (membusy = 0).\n

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity AddressCounter is

  Port (WAITMEM : in STD_LOGIC;
	MEMBUSY : in STD_LOGIC;
	LOAD : in STD_LOGIC;
	LOAD_VAL : in STD_LOGIC_VECTOR ( 7 downto 0);
	VALU : out STD_LOGIC_VECTOR ( 7 downto 0);
	RESTART : in STD_LOGIC;
	RESET : in STD_LOGIC;
	CLK : in STD_LOGIC );
	

       

end AddressCounter;

architecture Behavioral of AddressCounter is

signal ONE : STD_LOGIC_VECTOR(7 downto 0);
signal VALU_bis : STD_LOGIC_VECTOR(7 downto 0);


begin 
	ONE <= "00000001";


    react: Process (reset, clk) is

    begin
	
	

	if (reset = '0') then
          -- reset action here
		VALU <= "00000000";
		VALU_bis <= "00000000";

	elsif rising_edge(clk) then

          -- clock edge reaction here
		if  (WAITMEM='0' or MEMBUSY='0') then
			if (RESTART='1') then
				VALU <= "00000001";
				VALU_bis <= "00000001";
			else 
				if (LOAD='1') then
					VALU <= std_logic_vector((unsigned(LOAD_VAL) + unsigned(ONE)));
					VALU_bis <= std_logic_vector((unsigned(LOAD_VAL) + unsigned(ONE)));
				else
					VALU <= std_logic_vector((unsigned(VALU_bis) + unsigned(ONE)));
					VALU_bis <= std_logic_vector((unsigned(VALU_bis) + unsigned(ONE)));
				end if;
			end if;
			
		end if;
	end if;

     end process react;

end Behavioral;
