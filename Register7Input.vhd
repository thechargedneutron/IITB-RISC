library ieee;
use ieee.std_logic_1164.all;

entity Register7Input is
	port (Rf_d1 : IN STD_LOGIC_VECTOR(15 downto 0);
				alu_out : IN STD_LOGIC_VECTOR(15 downto 0);
				PC : IN STD_LOGIC_VECTOR(15 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op_data : OUT STD_LOGIC_VECTOR(15 downto 0);
				r7_write : OUT STD_LOGIC);
end Register7Input;


architecture behave of Register7Input is
	constant S1: STD_LOGIC_VECTOR(4 downto 0) := "00001";
  constant S9: STD_LOGIC_VECTOR(4 downto 0) := "01100";
  constant S10: STD_LOGIC_VECTOR(4 downto 0) := "01101";
  constant S15: STD_LOGIC_VECTOR(4 downto 0) := "10001";

  begin
    process (current_state, Rf_d1, alu_out, PC)
    begin
      case current_state is
        when S10 =>
                op_data <= Rf_d1;
								r7_write <= '1';
				when S9 | S15 =>
								op_data <= alu_out;
								r7_write <= '1';
				when S1 =>
								op_data <= PC;
								r7_write <= '1';
				when others =>
								op_data <= "0000000000000000";
								r7_write <= '0';
      end case;
    end process;
end behave;
