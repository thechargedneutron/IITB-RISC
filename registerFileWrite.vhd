library ieee;
use ieee.std_logic_1164.all;

entity registerFileWriteEnable is
	port (Rf_a3 : IN STD_LOGIC_VECTOR(2 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);
        R0_enable, R1_enable, R2_enable, R3_enable, R4_enable, R5_enable, R6_enable, R7_enable : OUT STD_LOGIC
        );
end registerFileWriteEnable;


architecture description of registerFileWriteEnable is
  constant S5: STD_LOGIC_VECTOR(4 downto 0) := "00110";
  constant S51: STD_LOGIC_VECTOR(4 downto 0) := "00111";
  constant S6: STD_LOGIC_VECTOR(4 downto 0) := "01000";
  constant S9: STD_LOGIC_VECTOR(4 downto 0) := "01100";
  constant S10: STD_LOGIC_VECTOR(4 downto 0) := "01101";
  constant S12: STD_LOGIC_VECTOR(4 downto 0) := "01110";
  constant SZ: STD_LOGIC_VECTOR(4 downto 0) := "10010";

		begin
			process (Rf_a3, current_state)
			begin
				if (current_state = S5) or (current_state = S51) or (current_state = S6) or (current_state = S9) or (current_state = S10) or (current_state = S12) or (current_state = SZ) then
					case Rf_a3 is
		        when "000" =>
		                R0_enable <= '1'; R1_enable <= '0'; R2_enable <= '0'; R3_enable <= '0'; R4_enable <= '0'; R5_enable <= '0'; R6_enable <= '0'; R7_enable <= '0';
						when "001" =>
	          	      R0_enable <= '0'; R1_enable <= '1'; R2_enable <= '0'; R3_enable <= '0'; R4_enable <= '0'; R5_enable <= '0'; R6_enable <= '0'; R7_enable <= '0';
						when "010" =>
	                  R0_enable <= '0'; R1_enable <= '0'; R2_enable <= '1'; R3_enable <= '0'; R4_enable <= '0'; R5_enable <= '0'; R6_enable <= '0'; R7_enable <= '0';
						when "011" =>
	                  R0_enable <= '0'; R1_enable <= '0'; R2_enable <= '0'; R3_enable <= '1'; R4_enable <= '0'; R5_enable <= '0'; R6_enable <= '0'; R7_enable <= '0';
						when "100" =>
	                  R0_enable <= '0'; R1_enable <= '0'; R2_enable <= '0'; R3_enable <= '0'; R4_enable <= '1'; R5_enable <= '0'; R6_enable <= '0'; R7_enable <= '0';
						when "101" =>
	                  R0_enable <= '0'; R1_enable <= '0'; R2_enable <= '0'; R3_enable <= '0'; R4_enable <= '0'; R5_enable <= '1'; R6_enable <= '0'; R7_enable <= '0';
						when "110" =>
	                  R0_enable <= '0'; R1_enable <= '0'; R2_enable <= '0'; R3_enable <= '0'; R4_enable <= '0'; R5_enable <= '0'; R6_enable <= '1'; R7_enable <= '0';
						when "111" =>
	                  R0_enable <= '0'; R1_enable <= '0'; R2_enable <= '0'; R3_enable <= '0'; R4_enable <= '0'; R5_enable <= '0'; R6_enable <= '0'; R7_enable <= '1';
						when others =>
										R0_enable <= '0'; R1_enable <= '0'; R2_enable <= '0'; R3_enable <= '0'; R4_enable <= '0'; R5_enable <= '0'; R6_enable <= '0'; R7_enable <= '0';
		      	end case;
				else
					R0_enable <= '0'; R1_enable <= '0'; R2_enable <= '0'; R3_enable <= '0'; R4_enable <= '0'; R5_enable <= '0'; R6_enable <= '0'; R7_enable <= '0';
			end if;

			end process;
end description;
