library ieee;
use ieee.std_logic_1164.all;

entity IITB_RISC is
	port (clock : IN STD_LOGIC);
end IITB_RISC;


architecture behave of IITB_RISC is

	component NextStateFSMLogic is
  port (current_state: IN STD_LOGIC_VECTOR(4 downto 0);
        op_code: IN STD_LOGIC_VECTOR(3 downto 0);
        condition: IN STD_LOGIC_VECTOR(1 downto 0);
        C, Z: IN STD_LOGIC;
				temp_z : IN STD_LOGIC;
        PE0: IN STD_LOGIC;

        next_state: OUT STD_LOGIC_VECTOR(4 downto 0));
	end component;

	component ALULogic is
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
	end component;

	component Memory is
	  port (addr: IN STD_LOGIC_VECTOR(15 downto 0);
	        din: IN STD_LOGIC_VECTOR(15 downto 0);
			    we: IN STD_LOGIC;
	        clk: IN STD_LOGIC;

	        dout: OUT STD_LOGIC_VECTOR(15 downto 0)
			  );
	end component;

	component MemoryAddressInput is
	port (t1 : IN STD_LOGIC_VECTOR(15 downto 0);
				PC : IN STD_LOGIC_VECTOR(15 downto 0);
				t2 : IN STD_LOGIC_VECTOR(15 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op : OUT STD_LOGIC_VECTOR(15 downto 0));
	end component;

	component MemoryWrite is
	port (t1 : IN STD_LOGIC_VECTOR(15 downto 0);
				t2 : IN STD_LOGIC_VECTOR(15 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op_val : OUT STD_LOGIC_VECTOR(15 downto 0);
				op_enable : OUT STD_LOGIC);
	end component;

	component InstructionEnable is
	port (current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op : OUT STD_LOGIC);
	end component;

	component ResetState is
	port (current_state : IN STD_LOGIC_VECTOR(4 downto 0);
        clear_enable : OUT STD_LOGIC
        );
	end component;

  component sixteenBitRegister is
  	port (d : IN STD_LOGIC_VECTOR(15 downto 0);
  				ld : IN STD_LOGIC;
  				clr : IN STD_LOGIC;
  				clk : IN STD_LOGIC;

  				q : OUT STD_LOGIC_VECTOR(15 downto 0));
  end component;

	component conditionalsixteenBitRegister is
	port (d : IN STD_LOGIC_VECTOR(15 downto 0);
				e : IN STD_LOGIC_VECTOR(15 downto 0);
				ld1 : IN STD_LOGIC;
				ld2 : IN STD_LOGIC;
				clr : IN STD_LOGIC;
				clk : IN STD_LOGIC;

				q : OUT STD_LOGIC_VECTOR(15 downto 0));
	end component;

	component eightBitRegister is
  	port (d : IN STD_LOGIC_VECTOR(7 downto 0);
  				ld : IN STD_LOGIC;
  				clr : IN STD_LOGIC;
  				clk : IN STD_LOGIC;

  				q : OUT STD_LOGIC_VECTOR(7 downto 0));
  end component;

	component conditionalEightBitRegister is
	port (d : IN STD_LOGIC_VECTOR(7 downto 0);
				e : IN STD_LOGIC_VECTOR(7 downto 0);
				ld1 : IN STD_LOGIC;
				ld2 : IN STD_LOGIC;
				clr : IN STD_LOGIC;
				clk : IN STD_LOGIC;

				q : OUT STD_LOGIC_VECTOR(7 downto 0));
	end component;

	component fiveBitRegister is
  	port (d : IN STD_LOGIC_VECTOR(4 downto 0);
  				ld : IN STD_LOGIC;
  				clr : IN STD_LOGIC;
  				clk : IN STD_LOGIC;

  				q : OUT STD_LOGIC_VECTOR(4 downto 0));
  end component;

  component oneBitRegister is
	port (d : IN STD_LOGIC;
				ld : IN STD_LOGIC;
				clr : IN STD_LOGIC;
				clk : IN STD_LOGIC;

				q : OUT STD_LOGIC);
  end component;

	component PriorityEncoder is
	port (PriorityEncoderReg : STD_LOGIC_VECTOR(7 downto 0);

				PE_out : OUT STD_LOGIC_VECTOR(2 downto 0);
        PE0 : OUT STD_LOGIC);
	end component;

	component PriorityModify is
	port (PriorityEncoderReg : IN STD_LOGIC_VECTOR(7 downto 0);
				PE_out : IN STD_LOGIC_VECTOR(2 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				PE_zero_enable : OUT STD_LOGIC;
				ModifiedPriorityReg : OUT STD_LOGIC_VECTOR(7 downto 0)
        );
	end component;

  component registerFileAccess is
	port (R0, R1, R2, R3, R4, R5, R6, R7 : IN STD_LOGIC_VECTOR(15 downto 0);
				Rf_a : IN STD_LOGIC_VECTOR(2 downto 0);

				Rf_d : OUT STD_LOGIC_VECTOR(15 downto 0));
  end component;

  component registerFileWriteEnable is
	port (Rf_a3 : IN STD_LOGIC_VECTOR(2 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);
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

	component RegisterFileInputC is
	port (ir345 : IN STD_LOGIC_VECTOR(2 downto 0);
				ir678 : IN STD_LOGIC_VECTOR(2 downto 0);
        ir911 : IN STD_LOGIC_VECTOR(2 downto 0);
				PEout : IN STD_LOGIC_VECTOR(2 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op : OUT STD_LOGIC_VECTOR(2 downto 0));
end component;

	component TempRegisterInputA is
		port (Rf_d1 : IN STD_LOGIC_VECTOR(15 downto 0);
					alu_out : IN STD_LOGIC_VECTOR(15 downto 0);
					current_state : IN STD_LOGIC_VECTOR(4 downto 0);

					op_data : OUT STD_LOGIC_VECTOR(15 downto 0);
					t1_write : OUT STD_LOGIC);
		end component;

		component TempRegisterInputB is
			port (Rf_d2 : IN STD_LOGIC_VECTOR(15 downto 0);
						alu_out : IN STD_LOGIC_VECTOR(15 downto 0);
						mem_d : IN STD_LOGIC_VECTOR(15 downto 0);
		        Rf_d1 : IN STD_LOGIC_VECTOR(15 downto 0);
						current_state : IN STD_LOGIC_VECTOR(4 downto 0);

						op_data : OUT STD_LOGIC_VECTOR(15 downto 0);
						t2_write : OUT STD_LOGIC);
		end component;

		component Register7Input is
			port (Rf_d1 : IN STD_LOGIC_VECTOR(15 downto 0);
						alu_out : IN STD_LOGIC_VECTOR(15 downto 0);
						PC : IN STD_LOGIC_VECTOR(15 downto 0);
						current_state : IN STD_LOGIC_VECTOR(4 downto 0);

						op_data : OUT STD_LOGIC_VECTOR(15 downto 0);
						r7_write : OUT STD_LOGIC);
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

	component PEEnable is
	port (current_state : IN STD_LOGIC_VECTOR(4 downto 0);
        PE_enable : OUT STD_LOGIC
        );
	end component;

	component PCInput is
	port (Rf_d1 : IN STD_LOGIC_VECTOR(15 downto 0);
				alu_out : IN STD_LOGIC_VECTOR(15 downto 0);
				current_state : IN STD_LOGIC_VECTOR(4 downto 0);

				op_data : OUT STD_LOGIC_VECTOR(15 downto 0);
				pc_write : OUT STD_LOGIC);
	end component;


    --List of all bunch of signals
    signal clear : STD_LOGIC;


    signal t1_out : STD_LOGIC_VECTOR(15 downto 0); --Init
    signal t2_out : STD_LOGIC_VECTOR(15 downto 0);

    signal t1_in : STD_LOGIC_VECTOR(15 downto 0);
    signal t2_in : STD_LOGIC_VECTOR(15 downto 0);

		signal PC_in : STD_LOGIC_VECTOR(15 downto 0);
		signal PC_out : STD_LOGIC_VECTOR(15 downto 0):=x"0000";

    signal C_in : STD_LOGIC;
    signal C_out : STD_LOGIC;

    signal Z_in : STD_LOGIC;
    signal Z_out : STD_LOGIC;

		signal temp_z : STD_LOGIC; --For BEQ

    signal alu_out : STD_LOGIC_VECTOR(15 downto 0);

    signal SE6_out : STD_LOGIC_VECTOR(15 downto 0);
    signal SE9_out : STD_LOGIC_VECTOR(15 downto 0);
    signal SE9spl_out : STD_LOGIC_VECTOR(15 downto 0);

    signal instruction : STD_LOGIC_VECTOR(15 downto 0);
    signal current_state : STD_LOGIC_VECTOR(4 downto 0) := "00000";
		signal next_state : STD_LOGIC_VECTOR(4 downto 0);

    --Registers
    signal R0 : STD_LOGIC_VECTOR(15 downto 0); signal R0_enable : STD_LOGIC;
    signal R1 : STD_LOGIC_VECTOR(15 downto 0); signal R1_enable : STD_LOGIC;
    signal R2 : STD_LOGIC_VECTOR(15 downto 0); signal R2_enable : STD_LOGIC;
    signal R3 : STD_LOGIC_VECTOR(15 downto 0); signal R3_enable : STD_LOGIC;
    signal R4 : STD_LOGIC_VECTOR(15 downto 0); signal R4_enable : STD_LOGIC;
    signal R5 : STD_LOGIC_VECTOR(15 downto 0); signal R5_enable : STD_LOGIC;
    signal R6 : STD_LOGIC_VECTOR(15 downto 0); signal R6_enable : STD_LOGIC;
    signal R7 : STD_LOGIC_VECTOR(15 downto 0); signal R7_enable : STD_LOGIC;
		signal R7_in : STD_LOGIC_VECTOR(15 downto 0); --Enable in enable pins section

		signal PriorityEncoderReg : STD_LOGIC_VECTOR(7 downto 0);
		signal PE0 : STD_LOGIC;
		signal PE_out : STD_LOGIC_VECTOR(2 downto 0);
		signal ModifiedPriorityReg : STD_LOGIC_VECTOR(7 downto 0);

    signal Rf_d1 : STD_LOGIC_VECTOR(15 downto 0);
    signal Rf_d2 : STD_LOGIC_VECTOR(15 downto 0);
    signal Rf_d3 : STD_LOGIC_VECTOR(15 downto 0);
    signal Rf_a1 : STD_LOGIC_VECTOR(2 downto 0);
    signal Rf_a2 : STD_LOGIC_VECTOR(2 downto 0);
    signal Rf_a3 : STD_LOGIC_VECTOR(2 downto 0);

		signal mem_d : STD_LOGIC_VECTOR(15 downto 0);
		signal mem_a : STD_LOGIC_VECTOR(15 downto 0);
		signal mem_data_in : STD_LOGIC_VECTOR(15 downto 0);

    ----------CONTROL SIGNALS ---------------------
    signal carry_enable : STD_LOGIC;
    signal zero_enable : STD_LOGIC;
    signal t1_write_enable: STD_LOGIC;
    signal t2_write_enable: STD_LOGIC;
		signal PC_enable : STD_LOGIC;
		signal R7_direct_enable : STD_LOGIC;
		signal PE_enable : STD_LOGIC;
		signal PE_zero_enable : STD_LOGIC;  --Make the just read register 0.
		signal instruction_write_enable : STD_LOGIC;
		signal memory_write_enable : STD_LOGIC;
    ---MORE TO COME
    ---------END CONTROL SIGNALS-------------------

		begin
    ----------REGISTER PORT MAPPINGS---------------

		--Next State Transition
		NxtState : NextStateFSMLogic port map(current_state, instruction(15 downto 12), instruction(1 downto 0), C_out, Z_out, temp_z, PE0, next_state);
		StateChange: fiveBitRegister port map(next_state, '1', '0', clock, current_state); --State Transition

		init: ResetState port map (current_state, clear);

		mem: Memory port map (mem_a, mem_data_in, memory_write_enable, clock, mem_d);
		mem_write: MemoryWrite port map (t1_out, t2_out, current_state, mem_data_in, memory_write_enable);
		mem_add_mux: MemoryAddressInput port map (t1_out, PC_out, t2_out, current_state, mem_a);
		get_ir_enable: InstructionEnable port map (current_state, instruction_write_enable);
		get_ir: sixteenBitRegister port map (mem_d, instruction_write_enable, clear, clock, instruction);

    C: oneBitRegister port map(C_in, carry_enable, clear, clock, C_out);
    Z: oneBitRegister port map(Z_in, zero_enable, clear, clock, Z_out);

    t1: sixteenBitRegister port map(t1_in, t1_write_enable, clear, clock, t1_out);
    t2: sixteenBitRegister port map(t2_in, t2_write_enable, clear, clock, t2_out);

		alu: ALULogic port map (current_state, instruction(15 downto 12), PC_out, t1_out, t2_out, SE6_out, SE9_out, ALU_out, C_in, carry_enable, Z_in, zero_enable, temp_z);

    SE6: SignExtended6 port map(instruction(5 downto 0), SE6_out);
    SE9: SignExtended9 port map(instruction(8 downto 0), SE9_out);
    SE9spl: SignExtended9spl port map(instruction(8 downto 0), SE9spl_out);

    RF1: registerFileAccess port map(R0, R1, R2, R3, R4, R5, R6, R7, Rf_a1, Rf_d1);
    RF2: registerFileAccess port map(R0, R1, R2, R3, R4, R5, R6, R7, Rf_a2, Rf_d2);

    RegWriteEnable: registerFileWriteEnable port map(Rf_a3, current_state, R0_enable, R1_enable, R2_enable, R3_enable, R4_enable, R5_enable, R6_enable, R7_enable);
    Reg0: sixteenBitRegister port map(Rf_d3, R0_enable, clear, clock, R0);
    Reg1: sixteenBitRegister port map(Rf_d3, R1_enable, clear, clock, R1);
    Reg2: sixteenBitRegister port map(Rf_d3, R2_enable, clear, clock, R2);
    Reg3: sixteenBitRegister port map(Rf_d3, R3_enable, clear, clock, R3);
    Reg4: sixteenBitRegister port map(Rf_d3, R4_enable, clear, clock, R4);
    Reg5: sixteenBitRegister port map(Rf_d3, R5_enable, clear, clock, R5);
    Reg6: sixteenBitRegister port map(Rf_d3, R6_enable, clear, clock, R6);
--    Reg7: sixteenBitRegister port map(Rf_d3, R7_enable, clear, clock, R7);

		Reg7: conditionalsixteenBitRegister port map(R7_in, Rf_d3, R7_direct_enable, R7_enable, clear, clock, R7);

    RegInpA: RegisterFileInputA port map(instruction(11 downto 9), instruction(8 downto 6), PE_out, current_state, Rf_a1);
    RegInpB: Rf_a2 <= instruction(8 downto 6); --No need of Multiplexing
    RegInpC: RegisterFileInputC port map(instruction(5 downto 3), instruction(8 downto 6), instruction(11 downto 9), PE_out, current_state, Rf_a3);
    RegInpD3: RegisterFileInputD3 port map(t1_out, SE9spl_out, R7, t2_out, current_state, Rf_d3);

		TempRegA: TempRegisterInputA port map(Rf_d1, alu_out, current_state, t1_in, t1_write_enable);
		TempRegB: TempRegisterInputB port map(Rf_d2, alu_out, mem_d, Rf_d1, current_state, t2_in, t2_write_enable);

	--	PC: sixteenBitRegister port map(PC_in, PC_enable, clear, clock, PC_out);
		PCInput1: PCInput port map (Rf_d1, alu_out, current_state, PC_in, PC_enable);

		R7Input: Register7Input port map (Rf_d1, alu_out, PC_out, current_state, R7_in, R7_direct_enable);
--		Reg7Direct: sixteenBitRegister port map(R7_in, R7_direct_enable, clear, clock, R7);

--		PCDirect: sixteenBitRegister port map (Rf_d3, R7_enable , clear, clock, PC_out);  --Write to PC when R7 is being modified
		PC_conditional_inp: conditionalsixteenBitRegister port map (Rf_d3, PC_in, R7_enable, PC_enable, clear, clock, PC_out);

		--Priority Encoder code goes here
	--	PriorityEncoderBlock: eightBitRegister port map (instruction(7 downto 0), PE_enable, clear, clock, PriorityEncoderReg); --In State2
		PEEnableBlock : PEEnable port map (current_state, PE_enable);
		PEBlock: PriorityEncoder port map (PriorityEncoderReg, PE_out, PE0);

		PriorityModif : PriorityModify port map (PriorityEncoderReg, PE_out, current_state, PE_zero_enable, ModifiedPriorityReg);
--		Modify : eightBitRegister port map (ModifiedPriorityReg, PE_zero_enable, clear, clock, PriorityEncoderReg);

		PriorityEncoderCondition: conditionalEightBitRegister port map (instruction(7 downto 0), ModifiedPriorityReg, PE_enable, PE_zero_enable, clear, clock, PriorityEncoderReg);
		--Priority Encoder code ends here


end behave;
