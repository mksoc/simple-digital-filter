-- file tb_checker.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity checker is 
    port (input_A: in integer;
          input_B: in integer;
          hw_sum: in integer;
          error: out std_logic);
end entity;

architecture behavior of checker is    
begin
    check: process(hw_sum)
    begin
        if hw_sum = input_A + input_B then
            error <= '0';
        else
            error <= '1';
        end if;
    end process;
end behavior;