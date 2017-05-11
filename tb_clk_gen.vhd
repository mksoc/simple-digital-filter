-- file tb_clk_gen.vhd
library ieee;
use ieee.std_logic_1164.all;

entity clk_gen is
    port (clk: out std_logic;
          rstn: out std_logic;
          start: out std_logic);
end clk_gen;

architecture behavior of clk_gen is
    constant T: time := 50 ns;
    
begin 
    clk_generation: process
    begin 
        clk <= '1', '0' after T/2, '1' after T;
        wait for T;
    end process;
    
    rstn <= '0', '1' after 120 ns;
    start <= '0', '1' after 270 ns;
    
end behavior;
