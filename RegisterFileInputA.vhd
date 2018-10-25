library ieee;
use ieee.std_logic_1164.all;

entity RegisterFileInputA is
	port (ir911 : IN STD_LOGIC_VECTOR(2 downto 0);
				ir678 : IN STD_LOGIC_VECTOR(2 downto 0);
				PEout : IN STD_LOGIC_VECTOR(2 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op : OUT STD_LOGIC_VECTOR(2 downto 0));
end RegisterFileInputA;


architecture behave of RegisterFileInputA is
  constant S2: STD_LOGIC_VECTOR(4 downto 0) := "00010";
  constant S10: STD_LOGIC_VECTOR(4 downto 0) := "01101";
  constant S13: STD_LOGIC_VECTOR(4 downto 0) := "01111";

  begin
    process (current_state, PEout, ir911, ir678)
    begin
      case current_state is
        when S2 =>
                op <= ir911;
				when S10 =>
								op <= ir678;
				when S13 =>
								op <= PEout;
				when others =>
								op <= "000";
      end case;
    end process;
end behave;
