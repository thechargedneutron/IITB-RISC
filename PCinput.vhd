library ieee;
use ieee.std_logic_1164.all;

entity PCInput is
	port (Rf_d1 : IN STD_LOGIC_VECTOR(15 downto 0);
				alu_out : IN STD_LOGIC_VECTOR(15 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op_data : OUT STD_LOGIC_VECTOR(15 downto 0);
				pc_write : OUT STD_LOGIC);
end PCInput;


architecture behave of PCInput is
  constant S1: STD_LOGIC_VECTOR(4 downto 0) := "00001";
  constant S9: STD_LOGIC_VECTOR(4 downto 0) := "01100";
  constant S10: STD_LOGIC_VECTOR(4 downto 0) := "01101";
  constant S15: STD_LOGIC_VECTOR(4 downto 0) := "10001";

  begin
    process (current_state, Rf_d1, alu_out)
    begin
      case current_state is
        when S10 =>
                op_data <= Rf_d1;
								pc_write <= '1';
				when S9 | S15 | S1 =>
								op_data <= alu_out;
								pc_write <= '1';
				when others =>
								op_data <= "0000000000000000";
								pc_write <= '0';
      end case;
    end process;
end behave;
