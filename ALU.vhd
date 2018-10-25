library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
entity ALU is
  port (operation: IN STD_LOGIC_VECTOR(2 downto 0);
        alu_a: IN STD_LOGIC_VECTOR(15 downto 0);
        alu_b: IN STD_LOGIC_VECTOR(15 downto 0);
		  
        ALU_out: OUT STD_LOGIC_VECTOR(15 downto 0);
        C_out: OUT STD_LOGIC;
        Z_out: OUT STD_LOGIC;
        beq_out: OUT STD_LOGIC;
        C_en: OUT STD_LOGIC;
        Z_en: OUT STD_LOGIC;
		beq_en: OUT STD_LOGIC
        
		  );
end ALU;


architecture behave of ALU is
  variable ALU_out1 : std_logic_vector(16 downto 0); -- 17 bits , for compensating a carry

  begin
    process (operation,alu_a,alu_b)
    begin
      case operation is
        when "000" => -- add without flag updates
                ALU_out <= STD_LOGIC_VECTOR(unsigned(alu_a) + unsigned(alu_b));
                Z_out <= '0';
                C_out <= '0';

					Z_en  <= '0';
					C_en  <= '0';
					beq_en <= '0';
        when "001" => -- add with flag updates
                ALU_out1 := STD_LOGIC_VECTOR(('0' & unsigned(alu_a)) + ('0' & unsigned(alu_b)));
                ALU_out <= ALU_out1(15 downto 0);
					if ALU_out1(15 downto 0) = "0000000000000000" then
						Z_out <= '1';
					else 
						Z_out <= '0';
					end if;
   				C_out <= ALU_out1(16);
   				beq_out <= '0';
					Z_en  <= '1';
					C_en  <= '1';
					beq_en <= '0';
				
        when "010" =>-- nand with z flag
					ALU_out1 := ('0' & alu_a) nand ('0' & alu_b);--change pc and one here
					ALU_out <= ALU_out1(15 downto 0);
					if ALU_out1(15 downto 0) = "0000000000000000" then
						Z_out <= '1';
					else 
						Z_out <= '0';
					end if;
				    C_out <= '0';
				    beq_out <= '0';
				    Z_en  <= '1';
				    C_en  <= '0';
					beq_en <= '0';
        when "011" =>
					if alu_a = alu_b then
						beq_out <= '1';
					else 
						beq_out <= '0';
					end if;
				    C_out <= '0';
				    Z_en  <= '0';
					C_en  <= '0';
					beq_en <= '1';
        when "111" => -- doubtful implementation
					ALU_out <= STD_LOGIC_VECTOR(unsigned(alu_a) + unsigned(alu_b));
					if ALU_out1(15 downto 0) = "0000000000000000" then
						Z_out <= '1';
					else 
						Z_out <= '0';
					end if;
					C_out <= '0';
					beq_out <= '0';
					Z_en  <= '1';
					C_en  <= '0';
					beq_en <= '0';
        when others =>
                ALU_out <= "0000000000000000";
                C_out <= '0';
                Z_out <= '0';
				beq_out <= '0';
				Z_en  <= '0';
				C_en  <= '0';
				beq_en <= '0';					 
      end case;
    end process;
end behave;