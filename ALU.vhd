library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
entity ALU is
  port (current_state: IN STD_LOGIC_VECTOR(4 downto 0);
        PC: IN STD_LOGIC_VECTOR(15 downto 0);
        t1: IN STD_LOGIC_VECTOR(15 downto 0);
        t2: IN STD_LOGIC_VECTOR(15 downto 0);
        SE6_op: IN STD_LOGIC_VECTOR(15 downto 0);
        SE9_op: IN STD_LOGIC_VECTOR(15 downto 0);
        condition: IN STD_LOGIC_VECTOR(1 downto 0);
        C_in: IN STD_LOGIC;
        Z_in: IN STD_LOGIC;

        ALU_out: OUT STD_LOGIC_VECTOR(15 downto 0);
        C_out: OUT STD_LOGIC;
        Z_out: OUT STD_LOGIC
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
  constant one: STD_LOGIC_VECTOR(15 downto 0) := "0000000000000001";

  variable ALU_out1 : std_logic_vector(16 downto 0); -- 17 bits , for compensating a carry

  begin
    process (current_state,PC,t1,t2,SE6_op,SE9_op,condition,C_in,Z_in) --many more
    begin
      case current_state is
        when S1 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned(one));
                Z_out <= Z_in;
                C_out <= C_in;
        when S3 =>
                ALU_out1 := STD_LOGIC_VECTOR(('0' & unsigned(PC)) + ('0' & unsigned(one)));
                ALU_out <= ALU_out1(15 downto 0);
					 if ALU_out1(15 downto 0) = "0000000000000000" then
						Z_out <= '1';
					 else 
						Z_out <= '0';
   				 C_out <= ALU_out1(16);
					 end if;
        when S31 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned(one));
                Z_out <= Z_in;
                C_out <= C_in;
        when S4 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned(one));
                Z_out <= Z_in;
                C_out <= C_in;
        when S9 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned(SE9_op));
                Z_out <= Z_in;
                C_out <= C_in;
        when S12 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned(one));
                Z_out <= Z_in;
                C_out <= C_in;
        when S14 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned(one));
                Z_out <= Z_in;
                C_out <= C_in;
        when S15 =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(PC) + unsigned(SE6_op));
                Z_out <= Z_in;
                C_out <= C_in;
        when SZ =>
                ALU_out <= STD_LOGIC_VECTOR(unsigned(t2) + unsigned(one));
                if ALU_out1(15 downto 0) = "0000000000000000" then
						Z_out <= '1';
					 else 
						Z_out <= '0';
                C_out <= C_in;
					 end if;
        when others =>
                ALU_out <= "0000000000000000";
                C_out <= C_in;
                Z_out <= Z_in;
      end case;
    end process;
end behave;
