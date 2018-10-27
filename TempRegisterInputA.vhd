library ieee;
use ieee.std_logic_1164.all;

entity TempRegisterInputA is
	port (Rf_d1 : IN STD_LOGIC_VECTOR(15 downto 0);
				alu_out : IN STD_LOGIC_VECTOR(15 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op_data : OUT STD_LOGIC_VECTOR(15 downto 0);
				t1_write : OUT STD_LOGIC);
end TempRegisterInputA;


architecture behave of TempRegisterInputA is
  constant S2: STD_LOGIC_VECTOR(4 downto 0) := "00010";
  constant S3: STD_LOGIC_VECTOR(4 downto 0) := "00011";
  constant S4: STD_LOGIC_VECTOR(4 downto 0) := "00101";
	constant S12: STD_LOGIC_VECTOR(4 downto 0) := "01110";
  constant S14: STD_LOGIC_VECTOR(4 downto 0) := "10000";

  begin
    process (current_state, Rf_d1, alu_out)
    begin
      case current_state is
        when S2 =>
                op_data <= Rf_d1;
								t1_write <= '1';
				when S3 | S4 | S14 | S12 =>
								op_data <= alu_out;
								t1_write <= '1';
				when others =>
								op_data <= "0000000000000000";
								t1_write <= '0';
      end case;
    end process;
end behave;
