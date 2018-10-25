library ieee;
use ieee.std_logic_1164.all;

entity RegisterFileInputC is
	port (ir345 : IN STD_LOGIC_VECTOR(2 downto 0);
				ir678 : IN STD_LOGIC_VECTOR(2 downto 0);
        ir911 : IN STD_LOGIC_VECTOR(2 downto 0);
				PEout : IN STD_LOGIC_VECTOR(2 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op : OUT STD_LOGIC_VECTOR(2 downto 0));
end RegisterFileInputC;


architecture behave of RegisterFileInputC is
  constant S5: STD_LOGIC_VECTOR(4 downto 0) := "00110";
  constant S51: STD_LOGIC_VECTOR(4 downto 0) := "00111";
  constant S6: STD_LOGIC_VECTOR(4 downto 0) := "01000";
  constant S9: STD_LOGIC_VECTOR(4 downto 0) := "01100";
  constant S10: STD_LOGIC_VECTOR(4 downto 0) := "01101";
  constant S12: STD_LOGIC_VECTOR(4 downto 0) := "01110";
  constant SZ: STD_LOGIC_VECTOR(4 downto 0) := "10010";

  begin
    process (current_state, PEout, ir911, ir678, ir345)
    begin
      case current_state is
        when S51 =>
                op <= ir345;
				when S5 =>
								op <= ir678;
				when S6 | S9 | S10 | SZ =>
								op <= ir911;
        when S12 =>
                op <= PEout;
				when others =>
								op <= "000";
      end case;
    end process;
end behave;
