library ieee;
use ieee.std_logic_1164.all;

entity JohnsonCounter_tb is
end JohnsonCounter_tb;

architecture TESTBENCH of JohnsonCounter_tb is
	component JohnsonCounter
		port (
			CLK: in std_logic;
			RST: in std_logic;			
			Pout: out std_logic_vector(0 to 3)
			);
	end component;
	signal CLK: std_logic := '0';
	signal RST: std_logic := '1';
	
	signal Pout: std_logic_vector(0 to 3);
	constant clock_period : time := 10 ns;
begin
	UUT: JohnsonCounter port map (
		CLK => CLK,
		RST => RST,		
		POut => POut
		);
	
	CLK <= not CLK after clock_period;
	
	reset: process
	begin
		RST <= '1';
		wait for clock_period;
		RST <= '0';
		wait for clock_period * 20;
	end process;
	
end TESTBENCH;