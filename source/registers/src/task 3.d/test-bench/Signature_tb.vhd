library ieee;
use ieee.std_logic_1164.all;

entity Signature_tb is
	generic (N : integer := 4);
end Signature_tb;

architecture TESTBENCH of Signature_tb is			 
	component Signature		   
		generic (N : integer := 4);
		port(
			CLK: in std_logic;
			RST: in std_logic;
			Pin: in std_logic;
			State: out std_logic_vector(0 to N-1);
			Pout: out std_logic
			);
	end component;
	signal CLK: std_logic := '0';
	signal RST: std_logic := '0';		 
	signal Pin: std_logic := '0';
	
	signal State: std_logic_vector(0 to N-1);
	signal Pout: std_logic;
	
	constant clock_period: time := 10 ns;
	constant test_polynom : std_logic_vector := "11000011";
begin
	uut: Signature port map (
		CLK => CLK,
		RST => RST,		
		State => State,
		Pin => Pin,
		Pout => Pout
		);
		
	simulate: process
	begin	
		wait for clock_period;
		for i in test_polynom'length-1 downto 0 loop
			Pin <= test_polynom(i);					
			wait for clock_period*2;
		end loop;	
	end process;
	CLK <= not CLK after clock_period;
end TESTBENCH;