-- file tb_data_fetch.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity data_fetch is 
    port (clock: in std_logic;
          enable: in std_logic; -- this will be the WR_B signal 
          data_in: in std_logic_vector(7 downto 0));
end data_fetch;

architecture behavior of data_fetch is    
    signal data_in_int: integer;
    
begin
    data_in_int <= to_integer(signed(data_in));

    output_data: process(clock)
        -- open file in write mode and define line variable
        file output_file: text open write_mode is "testbench/output_data.txt";
        variable buf_line: line;
    begin
        if (clock'event and clock = '1') then   
            if enable = '1' then
                write(buf_line, data_in_int); -- write data tu buffer
                writeline(output_file, buf_line); -- write buffer to file
            end if;
        end if;
    end process;
end behavior;