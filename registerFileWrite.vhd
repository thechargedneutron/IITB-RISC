library ieee;
use ieee.std_logic_1164.all;

entity registerFileWriteEnable is
	port (Rf_a3 : IN STD_LOGIC_VECTOR(2 downto 0);
        R0_enable, R1_enable, R2_enable, R3_enable, R4_enable, R5_enable, R6_enable, R7_enable : OUT STD_LOGIC
        );
end registerFileWriteEnable;


architecture description of registerFileWriteEnable is
		begin
			process (Rf_a3)
			begin
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
	      end case;
			end process;
end description;
