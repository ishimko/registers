library ieee;
use ieee.std_logic_1164.all;	

entity shiftregister_tb is	
		generic(
		N : INTEGER := 3 );
end shiftregister_tb;

architecture TB_ARCHITECTURE of shiftregister_tb is	
	component shiftregister
		generic(
		N : INTEGER := 3 );
	port(
		Sin : in STD_LOGIC;
		SE : in STD_LOGIC;
		CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
		Dout : out STD_LOGIC_VECTOR(N-1 downto 0) );
	end component;
	
	signal Sin : STD_LOGIC := '0';
	signal SE : STD_LOGIC := '1';
	signal CLK : STD_LOGIC := '0';
	signal RST : STD_LOGIC := '1';
	
	signal Dout : STD_LOGIC_VECTOR(N-1 downto 0);
	
	constant clock_period : time := 10 ns;
begin
	UUT : entity shiftregister(beh)
		generic map (
			N => N
		)

		port map (
			Sin => Sin,
			SE => SE,
			CLK => CLK,
			RST => RST,
			Dout => Dout
		);	
	  
	RST <= '1' after clock_period * N * 2 when RST = '0' else '0' after clock_period;
	CLK <= not CLK after clock_period;
	Sin <= not Sin after clock_period;
	SE <= not SE after clock_period * N * 2;	

end TB_ARCHITECTURE;

