library ieee;
use ieee.std_logic_1164.all;

entity MemoryAddressInput is
	port (t1 : IN STD_LOGIC_VECTOR(15 downto 0);
				PC : IN STD_LOGIC_VECTOR(15 downto 0);
				t2 : IN STD_LOGIC_VECTOR(15 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op : OUT STD_LOGIC_VECTOR(15 downto 0));
end MemoryAddressInput;


architecture behave of MemoryAddressInput is
	constant S1: STD_LOGIC_VECTOR(4 downto 0) := "00001";
  constant S7: STD_LOGIC_VECTOR(4 downto 0) := "01001";
  constant S71: STD_LOGIC_VECTOR(4 downto 0) := "01010";
  constant S8: STD_LOGIC_VECTOR(4 downto 0) := "01011";
  constant S14: STD_LOGIC_VECTOR(4 downto 0) := "10000";

  begin
    process (current_state, t1, t2, PC)
    begin
      case current_state is
        when S14 | S71 =>
                op <= t1;
				when S1 =>
								op <= PC;
				when S7 | S8 =>
								op <= t2;
				when others =>
								op <= "0000000000000000";
      end case;
    end process;
end behave;
