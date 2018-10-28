library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALULogic is
  port (current_state: IN STD_LOGIC_VECTOR(4 downto 0);
        opcode: IN STD_LOGIC_VECTOR(3 downto 0);
        PC: IN STD_LOGIC_VECTOR(15 downto 0);
        t1: IN STD_LOGIC_VECTOR(15 downto 0);
        t2: IN STD_LOGIC_VECTOR(15 downto 0);
        SE6_op: IN STD_LOGIC_VECTOR(15 downto 0);
        SE9_op: IN STD_LOGIC_VECTOR(15 downto 0);

        ALU_out: OUT STD_LOGIC_VECTOR(15 downto 0);
        C_out: OUT STD_LOGIC; carry_enable: OUT STD_LOGIC;
        Z_out: OUT STD_LOGIC; zero_enable: OUT STD_LOGIC;
        ALU_temp_z : OUT STD_LOGIC);
end ALULogic;

architecture behave of ALULogic is
  constant S1: STD_LOGIC_VECTOR(4 downto 0) := "00001";
  constant S3: STD_LOGIC_VECTOR(4 downto 0) := "00011";
  constant S31: STD_LOGIC_VECTOR(4 downto 0) := "00100";
  constant S4: STD_LOGIC_VECTOR(4 downto 0) := "00101";
  constant S9: STD_LOGIC_VECTOR(4 downto 0) := "01100";
  constant S12: STD_LOGIC_VECTOR(4 downto 0) := "01110";
  constant S14: STD_LOGIC_VECTOR(4 downto 0) := "10000";
  constant S15: STD_LOGIC_VECTOR(4 downto 0) := "10001";
  constant SZ: STD_LOGIC_VECTOR(4 downto 0) := "10010";
  constant one: STD_LOGIC_VECTOR(15 downto 0) := "0000000000000001";
  constant zero: STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
  begin
    process (current_state, opcode, PC, t1, t2, SE6_op, SE9_op)
	 variable temp_answer: STD_LOGIC_VECTOR(15 downto 0);
    begin
      case current_state is
        when S1 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned(one));
                C_out <= '0'; --dont care
                carry_enable <= '0';
                Z_out <= '0'; --dont care
                zero_enable <= '0';
                ALU_temp_z <= '0';
        when S9 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned(SE9_op));
                C_out <= '0'; --dont care
                carry_enable <= '0';
                Z_out <= '0'; --dont care
                zero_enable <= '0';
                ALU_temp_z <= '0';
        when S15 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned(SE6_op));
                C_out <= '0'; --dont care
                carry_enable <= '0';
                Z_out <= '0'; --dont care
                zero_enable <= '0';
                ALU_temp_z <= '0';
        when S31 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(t2) + unsigned(SE6_op));
                C_out <= '0'; --dont care
                carry_enable <= '0';
                Z_out <= '0'; --dont care
                zero_enable <= '0';
                ALU_temp_z <= '0';
        when S12 | S14 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(t1) + unsigned(one));
                C_out <= '0'; --dont care
                carry_enable <= '0';
                Z_out <= '0'; --dont care
                zero_enable <= '0';
                ALU_temp_z <= '0';
        when S3 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(t1) + unsigned(SE6_op));
                temp_answer := STD_LOGIC_VECTOR(unsigned(t1) + unsigned(SE6_op));
                C_out <= (t1(15) and SE6_op(15) and (not temp_answer(15))) or ((not t1(15)) and (not SE6_op(15)) and temp_answer(15));
                carry_enable <= '1';
                zero_enable <= '1';
                if temp_answer = zero then
                  Z_out <= '1';
                else
                  Z_out <= '0';
                end if;
                ALU_temp_z <= '0';
        when SZ =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(t2) + unsigned(zero));
                C_out <= '0'; --dont care
                carry_enable <= '0';
                zero_enable <= '1';
                temp_answer := STD_LOGIC_VECTOR(unsigned(t2) + unsigned(zero));
                if temp_answer = zero then
                  Z_out <= '1';
                else
                  Z_out <= '0';
                end if;
                ALU_temp_z <= '0';
        when S4 =>
              if opcode = "0000" then
                ALU_out <= STD_LOGIC_VECTOR(unsigned(t2) + unsigned(t1));
                temp_answer := STD_LOGIC_VECTOR(unsigned(t2) + unsigned(t1));
                C_out <= (t1(15) and t2(15) and (not temp_answer(15))) or ((not t1(15)) and (not t2(15)) and temp_answer(15));
                carry_enable <= '1';
                zero_enable <= '1';
                if temp_answer = zero then
                  Z_out <= '1';
                else
                  Z_out <= '0';
                end if;
                ALU_temp_z <= '0';
              elsif opcode = "0010" then
                ALU_out <= t1 nand t2;
                C_out <= '0';
                carry_enable <= '0';
                zero_enable <= '1';
                temp_answer := t1 nand t2;
                if temp_answer = zero then
                  Z_out <= '1';
                else
                  Z_out <= '0';
                end if;
                ALU_temp_z <= '0';
              elsif opcode = "1100" then
                ALU_out <= "0000000000000001"; --dont care
                C_out <= '0';
                carry_enable <= '0';
                zero_enable <= '0';
                Z_out <= '0';
                if t1 = t2 then
                  ALU_temp_z <= '1';
                else
                  ALU_temp_z <= '0';
                end if;
              else
                ALU_out <= "0000000000000001"; --dont care
                C_out <= '0';
                carry_enable <= '0';
                zero_enable <= '0';
                Z_out <= '0';
                ALU_temp_z <= '0';
              end if;
        when others =>
            ALU_out <= "0000000000000001"; --dont care
            C_out <= '0';
            carry_enable <= '0';
            zero_enable <= '0';
            Z_out <= '0';
            ALU_temp_z <= '0';
      end case;
    end process;
end behave;
