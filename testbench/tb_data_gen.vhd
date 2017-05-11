-- file tb_data_gen.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity data_gen is
    port (clk: in std_logic;
          rstn: in std_logic;
          enable: in std_logic;
          data_out: out std_logic_vector(7 downto 0));
end data_gen;

architecture behavior of data_gen is
    constant LINES: positive := 1024;
   
begin
    read_data: process(clk, rstn)
        file in_file: text open read_mode is "tb_random_data.txt";
        variable in_line: line;
        variable data_in: integer := 0;
        variable line_count: positive := 1;
    begin
        if rstn = '0' then
            data_out <= (others => '0');
        elsif clk'event and clk = '1' then
            if enable = '1' and line_count <= LINES then
                -- read data in line
                readline(in_file, in_line);
                read(in_line, data_in);
                
                -- assign read data
                data_out <= std_logic_vector(to_signed(data_in, 8));
                
                -- increment counter
                line_count := line_count + 1;
            else
                data_out <= (others => '0');
            end if;
        end if;
    end process;
end behavior;