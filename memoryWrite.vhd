library ieee;
use ieee.std_logic_1164.all;

entity MemoryWrite is
	port (t1 : IN STD_LOGIC_VECTOR(15 downto 0);
				t2 : IN STD_LOGIC_VECTOR(15 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op_val : OUT STD_LOGIC_VECTOR(15 downto 0);
				op_enable : OUT STD_LOGIC);
end MemoryWrite;


architecture behave of MemoryWrite is
  constant S8: STD_LOGIC_VECTOR(4 downto 0) := "01011";
  constant S14: STD_LOGIC_VECTOR(4 downto 0) := "10000";

  begin
    process (current_state, t1, t2)
    begin
      case current_state is
        when S8 =>
                op_val <= t1;
								op_enable <= '1';
				when S14 =>
								op_val <= t2;
								op_enable <= '1';
				when others =>
								op_val <= "0000000000000000";
								op_enable <= '0';
      end case;
    end process;
end behave;
