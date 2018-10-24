library ieee;
use ieee.std_logic_1164.all;

entity ALUInput is
  port (state: IN STD_LOGIC_VECTOR(4 downto 0);
        PC: IN STD_LOGIC_VECTOR(15 downto 0);
        t1: IN STD_LOGIC_VECTOR(15 downto 0);
        t2: IN STD_LOGIC_VECTOR(15 downto 0);
        SE6_op: IN STD_LOGIC_VECTOR(15 downto 0);
        SE9_op: IN STD_LOGIC_VECTOR(15 downto 0);

        ALU_a: OUT STD_LOGIC_VECTOR(15 downto 0);
        ALU_b: OUT STD_LOGIC_VECTOR(15 downto 0));
end ALUInput;

architecture behave of ALUInput is
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
                ALU_a <= PC;
                ALU_b <= "00000001";
        when S3 =>
                ALU_a <= t1;
                ALU_b <= SE6_op;
        when S31 =>
                ALU_a <= t2;
                ALU_b <= SE6_op;
        when S4 =>
                ALU_a <= t1;
                ALU_b <= t2;
        when S9 =>
                ALU_a <= PC;
                ALU_b <= SE9_op;
        when S12 =>
                ALU_a <= t2;
                ALU_b <= "00000001";
        when S14 =>
                ALU_a <= t1;
                ALU_b <= "00000001";
        when S15 =>
                ALU_a <= PC;
                ALU_b <= SE6_op;
        when SZ =>
                ALU_a <= "00000000";
                ALU_b <= t2;
      end case;
    end process;
end behave;
