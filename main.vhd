library ieee;
use ieee.std_logic_1164.all;

entity IITB_RISC is
	port (d : IN STD_LOGIC_VECTOR(15 downto 0);
				ld : IN STD_LOGIC;
				clr : IN STD_LOGIC;
				clk : IN STD_LOGIC;

				q : OUT STD_LOGIC_VECTOR(15 downto 0));
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

    alu: ALU port map (alu_a, alu_b, operation, alu_out, C_in, Z_in);

    SE6: SignExtended6 port map
    
end behave;
