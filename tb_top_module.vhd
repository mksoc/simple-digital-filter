-- file tb_top_module.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_top_module is
end tb_top_module;

architecture structure of tb_top_module is
    -- component declarations
    component clk_gen is
        port (clk: out std_logic;
              rstn: out std_logic;
              start: out std_logic);
    end component;
    
    component data_gen is
        port (clk: in std_logic;
              rstn: in std_logic;
              enable: in std_logic;
              data_out: out std_logic_vector(7 downto 0));
    end component;
    
    -- component checker is
        -- port (input_A: in integer;
              -- input_B: in integer;
              -- hw_sum: in integer;
              -- error: out std_logic);
    -- end component;
    
    component a_simple_digital_filter is
        PORT ( DATA_IN                        : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			START, clk, async_rst, sync_clr : IN STD_LOGIC;
			DONE                            : OUT STD_LOGIC );
    end component;
    
    -- signal declarations
    signal clk_internal: std_logic;
    signal rstn_internal, reset: std_logic;
    signal start_internal, done_internal: std_logic;
    signal data_in_internal: std_logic_vector(7 downto 0);
    
begin
    reset <= not rstn_internal;
    
    -- component instantiations
    clk0: clk_gen port map (clk => clk_internal,
                            rstn => rstn_internal,
                            start => start_internal);
    
    data_gen0: data_gen port map (clk => clk_internal,
                                  rstn => rstn_internal,
                                  enable => start_internal,
                                  data_out => data_in_internal);    
                                   
    filter: a_simple_digital_filter port map (DATA_IN => data_in_internal,
                                              START => start_internal,
                                              clk => clk_internal,
                                              async_rst => reset,
                                              sync_clr => '0',
                                              DONE => done_internal);
                                              
end structure;