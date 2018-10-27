library ieee;
use ieee.std_logic_1164.all;

entity NextStateFSMLogic is
  port (current_state: IN STD_LOGIC_VECTOR(4 downto 0);
        op_code: IN STD_LOGIC_VECTOR(3 downto 0);
        condition: IN STD_LOGIC_VECTOR(1 downto 0);
        C, Z: IN STD_LOGIC;
        PE0: IN STD_LOGIC;

        next_state: OUT STD_LOGIC_VECTOR(4 downto 0));
end NextStateFSMLogic;

architecture behave of NextStateFSMLogic is
  constant S1: STD_LOGIC_VECTOR(4 downto 0) := "00001";
  constant S2: STD_LOGIC_VECTOR(4 downto 0) := "00010";
  constant S3: STD_LOGIC_VECTOR(4 downto 0) := "00011";
  constant S31: STD_LOGIC_VECTOR(4 downto 0) := "00100";
  constant S4: STD_LOGIC_VECTOR(4 downto 0) := "00101";
  constant S5: STD_LOGIC_VECTOR(4 downto 0) := "00110";
  constant S51: STD_LOGIC_VECTOR(4 downto 0) := "00111";
  constant S6: STD_LOGIC_VECTOR(4 downto 0) := "01000";
  constant S7: STD_LOGIC_VECTOR(4 downto 0) := "01001";
  constant S71: STD_LOGIC_VECTOR(4 downto 0) := "01010";
  constant S8: STD_LOGIC_VECTOR(4 downto 0) := "01011";
  constant S9: STD_LOGIC_VECTOR(4 downto 0) := "01100";
  constant S10: STD_LOGIC_VECTOR(4 downto 0) := "01101";
  constant S12: STD_LOGIC_VECTOR(4 downto 0) := "01110";
  constant S13: STD_LOGIC_VECTOR(4 downto 0) := "01111";
  constant S14: STD_LOGIC_VECTOR(4 downto 0) := "10000";
  constant S15: STD_LOGIC_VECTOR(4 downto 0) := "10001";
  constant SZ: STD_LOGIC_VECTOR(4 downto 0) := "10010";

  begin
    process (current_state, op_code, C, Z, condition, PE0) --many more
    begin
      case current_state is
        when S1 =>
                next_state <= S2;

        when S3 =>
                next_state <= S5;

        when S31 =>
                if op_code(3) ='0' then
                  next_state <= S7;
                else
                  next_state <= S8;
                end if;
        when others =>
                next_state <= S9;
      end case;
    end process;
end behave;
