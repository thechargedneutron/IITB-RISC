library ieee;
use ieee.std_logic_1164.all;

entity InstructionEnable is
	port (current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op : OUT STD_LOGIC);
end InstructionEnable;


architecture behave of InstructionEnable is
	constant S1: STD_LOGIC_VECTOR(4 downto 0) := "00001";

  begin
    process (current_state)
    begin
      case current_state is
        when S1 =>
                op <= '1';
				when others =>
								op <= '0';
      end case;
    end process;
end behave;
