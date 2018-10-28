library ieee;
use ieee.std_logic_1164.all;

entity NextStateFSMLogic is
  port (current_state: IN STD_LOGIC_VECTOR(4 downto 0);
        op_code: IN STD_LOGIC_VECTOR(3 downto 0);
        condition: IN STD_LOGIC_VECTOR(1 downto 0);
        C, Z: IN STD_LOGIC;
        temp_z : IN STD_LOGIC;
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
    process (current_state, op_code, C, Z, condition, PE0, temp_z) --many more
    begin
      case current_state is
        when S1 =>
                next_state <= S2;
        when S2 =>
                if op_code = "0001" then
                  next_state <= S3;
                elsif op_code = "0011" then
                  next_state <= S6;
                elsif op_code = "1000" then
                  next_state <= S9;
                elsif op_code = "1001" then
                  next_state <= S10;
		elsif op_code = "0110" then
                  next_state <= S71;
		elsif op_code = "0111" then
                  next_state <= S13;
		elsif op_code(3 downto 1) = "010" then
                  next_state <= S31;
		elsif ((op_code(3 downto 0) = "1100") OR (((op_code(3 downto 0) = "0000") OR (op_code(3 downto 0) = "0010")) AND ((condition = "00") OR (condition = "01" AND Z='1') OR (condition = "10" AND C='1'))))  then
                  next_state <= S4;
		else
		  next_state <= S1;
                end if;


        when S3 =>
                next_state <= S5;

        when S4 =>
		if op_code = "0000" or op_code = "0010" then
                  next_state <= S51;
                elsif (op_code = "1100" AND temp_z = '1') then
                  next_state <= S15;
		else
                  next_state <= S1;
                end if;

        when S31 =>
                if op_code ="0100" then
                  next_state <= S7;
                else
                  next_state <= S8;
                end if;
        when S5 =>
                next_state <= S1;
        when S51 =>
                next_state <= S1;
        when S6 =>
                next_state <= S1;
        when S7 =>
                next_state <= SZ;
        when S71 =>
		if PE0 ='1' then
                  next_state <= S1;
                else
                  next_state <= S12;
                end if;

        when S8 =>
		next_state <= S1;
        when S9 =>
		next_state <= S1;
        when S10 =>
		next_state <= S1;
        when S12 =>
		next_state <= S71;
        when S13 =>
                if PE0 ='1' then
                  next_state <= S1;
                else
                  next_state <= S14;
                end if;
        when S14 =>
		next_state <= S13;
        when S15 =>
		next_state <= S1;
        when SZ =>
		next_state <= S1;


	when others =>
                next_state <= S1;
      end case;
    end process;
end behave;
