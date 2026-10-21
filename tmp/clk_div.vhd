library ieee;
use ieee.std_logic_1164.all;

entity clk_div is
    generic(MAX_CICLES : natural := 25000000); -- half of 50 000 000 = 50Mhz
    
    port(
        clk: in std_logic;
        out_clk: out std_logic
    );
end entity;

architecture divisor of clk_div is
    signal aux_clk: std_logic := '0';
begin
    process( clk ) is

        variable cicle_counter: natural range 0 to MAX_CICLES := 0;

    begin
        if rising_edge( clk ) then
            cicle_counter := cicle_counter + 1;

            if( cicle_counter = MAX_CICLES ) then
                cicle_counter := 0;
                aux_clk <= not aux_clk;
            end if;
        end if;
    end process;

    out_clk <= aux_clk;
end architecture;