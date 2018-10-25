library ieee;
use ieee.std_logic_1164.all;

entity SignExtended9 is
	port (inp : IN STD_LOGIC_VECTOR(8 downto 0);

				op : OUT STD_LOGIC_VECTOR(15 downto 0));
end SignExtended9;


architecture description of SignExtended9 is
		begin
			process (inp)
			begin
        op <= ("0000000" & inp);
			end process;
end description;
