library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
entity Memory is
  port (addr: IN STD_LOGIC_VECTOR(15 downto 0);
        din: IN STD_LOGIC_VECTOR(15 downto 0);
		    we: IN STD_LOGIC;
        clk: IN STD_LOGIC;

        dout: OUT STD_LOGIC_VECTOR(15 downto 0)
		  );
end Memory;


architecture behave of Memory is
type mem_array is array	(0	to 2**7 -1) of
	std_logic_vector(15 downto 0);
signal RAM:	mem_array:= (x"3051", x"3255", x"0050", others => x"0000");

begin
process(clk)
	begin
	if rising_edge(clk) then
		if we = '1' then
			RAM(to_integer(unsigned(addr(6 downto 0)))) <= din;
		end if;
  end if;
end process;
			dout <= RAM (to_integer (unsigned(addr(6 downto 0))));
end behave;
