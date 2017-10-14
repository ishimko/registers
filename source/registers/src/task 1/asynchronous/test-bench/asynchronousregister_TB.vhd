library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  
use IEEE.NUMERIC_STD.all;

entity asynchronousregister_tb is
	generic (n : integer := 4);
end asynchronousregister_tb;

architecture TB_ARCHITECTURE of asynchronousregister_tb is	
component AsynchronousRegister
	generic (n : integer := 4);
		port(
			Din : in STD_LOGIC_VECTOR(n-1 downto 0);
			EN : in STD_LOGIC;
			Dout : out STD_LOGIC_VECTOR(n-1 downto 0) 
			);
	end component;
	
	signal Din : STD_LOGIC_VECTOR(n-1 downto 0) := (others => '0');
	signal EN : STD_LOGIC := '0';
	
	signal Dout_beh : STD_LOGIC_VECTOR(n-1 downto 0);
	signal Dout_struct : STD_LOGIC_VECTOR(n-1 downto 0);
	
	constant register_size : integer := 4;
	constant delay : time := 10 ns;
begin
	
	beh : entity AsynchronousRegister(beh)
	generic map (n => register_size)
	
	port map (
		Din => Din,
		EN => EN,
		Dout => Dout_beh
		);	
	
	struct : entity AsynchronousRegister(struct)
	generic map (n => register_size)
	
	port map (
		Din => Din,
		EN => EN,
		Dout => Dout_struct
		);
	
	Din <= Din + "1" after delay;
	EN <= not EN after delay;
	
end TB_ARCHITECTURE;

