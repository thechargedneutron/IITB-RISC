library ieee;
use ieee.std_logic_1164.all;

entity RegisterFileInputD3 is
	port (t1 : IN STD_LOGIC_VECTOR(15 downto 0);
				SE9spl : IN STD_LOGIC_VECTOR(15 downto 0);
        R7 : IN STD_LOGIC_VECTOR(15 downto 0);
				t2 : IN STD_LOGIC_VECTOR(15 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op : OUT STD_LOGIC_VECTOR(15 downto 0));
end RegisterFileInputD3;


architecture behave of RegisterFileInputD3 is
  constant S5: STD_LOGIC_VECTOR(4 downto 0) := "00110";
  constant S51: STD_LOGIC_VECTOR(4 downto 0) := "00111";
  constant S6: STD_LOGIC_VECTOR(4 downto 0) := "01000";
  constant S9: STD_LOGIC_VECTOR(4 downto 0) := "01100";
  constant S10: STD_LOGIC_VECTOR(4 downto 0) := "01101";
  constant S12: STD_LOGIC_VECTOR(4 downto 0) := "01110";
  constant SZ: STD_LOGIC_VECTOR(4 downto 0) := "10010";

  begin
    process (current_state, t1, SE9spl, R7, t2)
    begin
      case current_state is
        when S5 | S51 =>
                op <= t1;
				when S6 =>
								op <= SE9spl;
				when S9 | S10 =>
								op <= R7;
        when SZ | S12 =>
                op <= t2;
				when others =>
								op <= "0000000000000000";
      end case;
    end process;
end behave;
