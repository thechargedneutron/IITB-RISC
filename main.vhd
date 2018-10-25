library ieee;
use ieee.std_logic_1164.all;

entity IITB_RISC is
	port (clock : IN STD_LOGIC;
end IITB_RISC;


architecture behave of IITB_RISC is

  component ALU is
  port (state: IN STD_LOGIC_VECTOR(4 downto 0);
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
  end component;

  component sixteenBitRegister is
  	port (d : IN STD_LOGIC_VECTOR(15 downto 0);
  				ld : IN STD_LOGIC;
  				clr : IN STD_LOGIC;
  				clk : IN STD_LOGIC;

  				q : OUT STD_LOGIC_VECTOR(15 downto 0));
  end component;

  component oneBitRegister is
	port (d : IN STD_LOGIC;
				ld : IN STD_LOGIC;
				clr : IN STD_LOGIC;
				clk : IN STD_LOGIC;

				q : OUT STD_LOGIC);
  end component;

  component registerFileAccess is
	port (R0, R1, R2, R3, R4, R5, R6, R7 : IN STD_LOGIC_VECTOR(15 downto 0);
				Rf_a : IN STD_LOGIC_VECTOR(2 downto 0);

				Rf_d : OUT STD_LOGIC_VECTOR(15 downto 0));
  end component;

  component registerFileWriteEnable is
	port (Rf_a3 : IN STD_LOGIC_VECTOR(2 downto 0);
        R0_enable, R1_enable, R2_enable, R3_enable, R4_enable, R5_enable, R6_enable, R7_enable : OUT STD_LOGIC
        );
  end component;

  component RegisterFileInputA is
	port (ir911 : IN STD_LOGIC_VECTOR(2 downto 0);
				ir678 : IN STD_LOGIC_VECTOR(2 downto 0);
				PEout : IN STD_LOGIC_VECTOR(2 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op : OUT STD_LOGIC_VECTOR(2 downto 0));
  end component;

  component RegisterFileInputD3 is
	port (t1 : IN STD_LOGIC_VECTOR(15 downto 0);
				SE9spl : IN STD_LOGIC_VECTOR(15 downto 0);
        R7 : IN STD_LOGIC_VECTOR(15 downto 0);
				t2 : IN STD_LOGIC_VECTOR(15 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op : OUT STD_LOGIC_VECTOR(15 downto 0));
  end component;


  component ALUInput is
  port (state: IN STD_LOGIC_VECTOR(4 downto 0);
        PC: IN STD_LOGIC_VECTOR(15 downto 0);
        t1: IN STD_LOGIC_VECTOR(15 downto 0);
        t2: IN STD_LOGIC_VECTOR(15 downto 0);
        SE6_op: IN STD_LOGIC_VECTOR(15 downto 0);
        SE9_op: IN STD_LOGIC_VECTOR(15 downto 0);

        ALU_a: OUT STD_LOGIC_VECTOR(15 downto 0);
        ALU_b: OUT STD_LOGIC_VECTOR(15 downto 0);
        operation: OUT STD_LOGIC_VECTOR(2 downto 0));
  end component;

  component SignExtended6 is
	port (inp : IN STD_LOGIC_VECTOR(5 downto 0);

				op : OUT STD_LOGIC_VECTOR(15 downto 0));
  end component;

  component SignExtended9 is
	port (inp : IN STD_LOGIC_VECTOR(8 downto 0);

				op : OUT STD_LOGIC_VECTOR(15 downto 0));
  end component;

  component SignExtended9spl is
	port (inp : IN STD_LOGIC_VECTOR(8 downto 0);

				op : OUT STD_LOGIC_VECTOR(15 downto 0));
  end component;


    --List of all bunch of signals
    signal clear : STD_LOGIC;


    signal t1_out : STD_LOGIC_VECTOR(15 downto 0); --Init
    signal t2_out : STD_LOGIC_VECTOR(15 downto 0);

    signal t1_in : STD_LOGIC_VECTOR(15 downto 0);
    signal t2_in : STD_LOGIC_VECTOR(15 downto 0);

    signal PC_out : STD_LOGIC_VECTOR(15 downto 0);

    signal C_in : STD_LOGIC;
    signal C_out : STD_LOGIC;

    signal Z_in : STD_LOGIC;
    signal Z_out : STD_LOGIC;

    signal alu_a : STD_LOGIC_VECTOR(15 downto 0);
    signal alu_b : STD_LOGIC_VECTOR(15 downto 0);

    signal alu_out : STD_LOGIC_VECTOR(15 downto 0);

    signal SE6_out : STD_LOGIC_VECTOR(15 downto 0);
    signal SE9_out : STD_LOGIC_VECTOR(15 downto 0);
    signal SE9spl_out : STD_LOGIC_VECTOR(15 downto 0);

    signal instruction : STD_LOGIC_VECTOR(15 downto 0);
    signal current_state : STD_LOGIC_VECTOR(4 downto 0);

    --Registers
    signal R0 : STD_LOGIC_VECTOR(15 downto 0); signal R0_enable : STD_LOGIC;
    signal R1 : STD_LOGIC_VECTOR(15 downto 0); signal R1_enable : STD_LOGIC;
    signal R2 : STD_LOGIC_VECTOR(15 downto 0); signal R2_enable : STD_LOGIC;
    signal R3 : STD_LOGIC_VECTOR(15 downto 0); signal R3_enable : STD_LOGIC;
    signal R4 : STD_LOGIC_VECTOR(15 downto 0); signal R4_enable : STD_LOGIC;
    signal R5 : STD_LOGIC_VECTOR(15 downto 0); signal R5_enable : STD_LOGIC;
    signal R6 : STD_LOGIC_VECTOR(15 downto 0); signal R6_enable : STD_LOGIC;
    signal R7 : STD_LOGIC_VECTOR(15 downto 0); signal R7_enable : STD_LOGIC;

    signal Rf_d1 : STD_LOGIC_VECTOR(15 downto 0);
    signal Rf_d2 : STD_LOGIC_VECTOR(15 downto 0);
    signal Rf_d3 : STD_LOGIC_VECTOR(15 downto 0);
    signal Rf_a1 : STD_LOGIC_VECTOR(2 downto 0);
    signal Rf_a2 : STD_LOGIC_VECTOR(2 downto 0);
    signal Rf_a3 : STD_LOGIC_VECTOR(2 downto 0);

    ----------CONTROL SIGNALS ---------------------
    signal carry_enable : STD_LOGIC;
    signal zero_enable : STD_LOGIC;
    signal t1_write_enable: STD_LOGIC;
    signal t2_write_enable: STD_LOGIC;
    ---MORE TO COME
    ---------END CONTROL SIGNALS-------------------

    ----------REGISTER PORT MAPPINGS---------------
    C: oneBitRegister port map(C_in, carry_enable, clear, clock, C_out);
    Z: oneBitRegister port map(Z_in, zero_enable, clear, clock, Z_out);

    t1: sixteenBitRegister port map(t1_in, t1_write_enable, clear, clock, t1_out);
    t2: sixteenBitRegister port map(t2_in, t2_write_enable, clear, clock, t2_out);

    aluInput: port map(state, PC_out, t1_out, t2_out, SE6_op, SE9_op)  --CHECK THIS
    alu: ALU port map(alu_a, alu_b, operation, alu_out, C_in, Z_in);

    SE6: SignExtended6 port map(instruction(5 downto 0), SE6_out);
    SE9: SignExtended9 port map(instruction(8 downto 0), SE9_out);
    SE9spl: SignExtended9spl port map(instruction(8 downto 0), SE9spl_out);

    RF1: registerFileAccess port map(R0, R1, R2, R3, R4, R5, R6, R7, Rf_a1, Rf_d1);
    RF2: registerFileAccess port map(R0, R1, R2, R3, R4, R5, R6, R7, Rf_a2, Rf_d2);

    RegWriteEnable: registerFileWriteEnable port map(Rf_a3, R0_enable, R1_enable, R2_enable, R3_enable, R4_enable, R5_enable, R6_enable, R7_enable);
    Reg0: sixteenBitRegister port map(Rf_d3, R0_enable, clear, clock, R0);
    Reg1: sixteenBitRegister port map(Rf_d3, R1_enable, clear, clock, R1);
    Reg2: sixteenBitRegister port map(Rf_d3, R2_enable, clear, clock, R2);
    Reg3: sixteenBitRegister port map(Rf_d3, R3_enable, clear, clock, R3);
    Reg4: sixteenBitRegister port map(Rf_d3, R4_enable, clear, clock, R4);
    Reg5: sixteenBitRegister port map(Rf_d3, R5_enable, clear, clock, R5);
    Reg6: sixteenBitRegister port map(Rf_d3, R6_enable, clear, clock, R6);
    Reg7: sixteenBitRegister port map(Rf_d3, R7_enable, clear, clock, R7);

    RegInpA: RegisterFileInputA port map(instruction(11 downto 9), instruction(8 downto 6), PE_out, current_state, Rf_a1);
    RegInpB: Rf_a2 <= instruction(8 downto 6); --No need of Multiplexing
    RegInpC: RegisterFileInputC port map(instruction(5 downto 3), instruction(8 downto 6), instruction(11 downto 9), PE_out, current_state, Rf_a3);
    RegInpD3: RegisterFileInputD3 port map(t1_out, SE9spl_out, R7, t2_out, current_state, Rf_d3);

end behave;
