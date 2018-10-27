library ieee;
use ieee.std_logic_1164.all;
entity ALU is
  port (ALU_a : IN STD_LOGIC_VECTOR(15 downto 0);
        ALU_b : IN STD_LOGIC_VECTOR(15 downto 0);
        operation : IN STD_LOGIC_VECTOR(2 downto 0);

        ALU_out: OUT STD_LOGIC_VECTOR(15 downto 0);
        C_out: OUT STD_LOGIC; carry_enable: OUT STD_LOGIC;
        Z_out: OUT STD_LOGIC; zero_enable: OUT STD_LOGIC;
        ALU_temp_z : OUT STD_LOGIC
        );
end ALU;


architecture behave of ALU is
  constant S1: STD_LOGIC_VECTOR(4 downto 0) := "00001";
  constant S3: STD_LOGIC_VECTOR(4 downto 0) := "00011";
  constant S31: STD_LOGIC_VECTOR(4 downto 0) := "00100";
  constant S4: STD_LOGIC_VECTOR(4 downto 0) := "00101";
  constant S9: STD_LOGIC_VECTOR(4 downto 0) := "01100";
  constant S12: STD_LOGIC_VECTOR(4 downto 0) := "01110";
  constant S14: STD_LOGIC_VECTOR(4 downto 0) := "10000";
  constant S15: STD_LOGIC_VECTOR(4 downto 0) := "10001";
  constant SZ: STD_LOGIC_VECTOR(4 downto 0) := "10010";



  begin
    process (current_state, op_code, C, Z, condition, PE0) --many more
    begin
      case current_state is
        when S1 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned("00000001"));
                Z_out <= Z_in;
                C_out <= C_in;
        when S3 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned("00000001"));
                Z_out <= Z_in;
                C_out <= C_in;
        when S31 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned("00000001"));
                Z_out <= Z_in;
                C_out <= C_in;
        when S4 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned("00000001"));
                Z_out <= Z_in;
                C_out <= C_in;
        when S9 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned(SE9_out));
                Z_out <= Z_in;
                C_out <= C_in;
        when S12 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned("00000001"));
                Z_out <= Z_in;
                C_out <= C_in;
        when S14 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned("00000001"));
                Z_out <= Z_in;
                C_out <= C_in;
        when S15 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned(SE6_out));
                Z_out <= Z_in;
                C_out <= C_in;
        when SZ =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(t2) + unsigned("00000000"));
                Z_out <= Z_in;
                C_out <= C_in;
        when others =>
                ALU_out <= "00000000";
                C_out <= C_in;
                Z_out <= Z_in;
      end case;
    end process;
end behave;
