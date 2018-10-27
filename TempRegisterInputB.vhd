library ieee;
use ieee.std_logic_1164.all;

entity TempRegisterInputB is
	port (Rf_d2 : IN STD_LOGIC_VECTOR(15 downto 0);
				alu_out : IN STD_LOGIC_VECTOR(15 downto 0);
				mem_d : IN STD_LOGIC_VECTOR(15 downto 0);
        Rf_d1 : IN STD_LOGIC_VECTOR(15 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op_data : OUT STD_LOGIC_VECTOR(15 downto 0);
				t2_write : OUT STD_LOGIC);
end TempRegisterInputB;


architecture behave of TempRegisterInputB is
  constant S2: STD_LOGIC_VECTOR(4 downto 0) := "00010";
  constant S31: STD_LOGIC_VECTOR(4 downto 0) := "00100";
  constant S7: STD_LOGIC_VECTOR(4 downto 0) := "01001";
	constant S71: STD_LOGIC_VECTOR(4 downto 0) := "01010";
  constant S13: STD_LOGIC_VECTOR(4 downto 0) := "01111";

  begin
    process (current_state, Rf_d1, Rf_d2, alu_out, mem_d)
    begin
      case current_state is
        when S2 =>
                op_data <= Rf_d2;
								t2_write <= '1';
				when S31 =>
								op_data <= alu_out;
								t2_write <= '1';
				when S7 | S71 =>
								op_data <= mem_d;
								t2_write <= '1';
				when S13 =>
								op_data <= Rf_d1;
								t2_write <= '1';
				when others =>
								op_data <= "0000000000000000";
								t2_write <= '0';
      end case;
    end process;
end behave;
