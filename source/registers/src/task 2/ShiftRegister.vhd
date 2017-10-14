library ieee;
use ieee.std_logic_1164.all;

entity ShiftRegister is
	generic (N: integer:= 3);
	port(
		Sin, 
		SE, 
		CLK, 
		RST: in std_logic;
		Dout: out std_logic_vector(N-1 downto 0)
		);
end ShiftRegister;				  

architecture beh of ShiftRegister is
	signal register_state: std_logic_vector(N-1 downto 0);
begin
	main: process (CLK, RST)
	begin
		if RST = '1' then
			register_state <= (others => '0');
		elsif rising_edge(CLK) then
			if SE = '1' then
				register_state <= register_state(N-2 downto 0) & Sin;
			end if;
		end if;
	end process;	
	
	Dout <= register_state; 
end beh;

architecture struct of ShiftReg is
	component FDCE is
		port (
			CLK: in std_logic;
			E: in std_logic;
			CLR: in std_logic;
			D: in std_logic;
			Q: out std_logic
			);
	end component;	  					   
	signal outS: std_logic_vector(N-1 downto 0);
begin			   
	U_0: entity FDCE 
	port map(
		CLK => CLK, 
		E => SE, 
		CLR => RST, 
		D => Sin,
		Q => outS(0)
		);
	reg: for I in 1 to N-1 generate			
		U_I: entity FDCE 
		port map (
			CLK => CLK,
			E => SE,
			CLR => RST,
			D => outS(I-1),
			Q => outS(I)
			);
	end generate;				 
	Dout <= outS;
end struct;