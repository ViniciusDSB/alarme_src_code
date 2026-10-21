library ieee;
use ieee.std_logic_1164.all;

entity main is

    port(
        real_clk: in std_logic;

        reset_sw: in std_logic;
        input_sw: in std_logic_vector(7 downto 0);
        led: out std_logic_vector(7 downto 0);
        trava_out_led: out std_logic;

        -- Saida dos segundos
        display_R: out std_logic_vector(7 downto 0);
        display_L: out std_logic_vector(7 downto 0)
    );

end entity;

architecture container of main is

    signal clk_1hz: std_logic;

    constant senha: natural := 42; -- Senha para destravar
    constant tempo_para_desarme: natural := 10; -- Tempo para desarme em segundos

    signal aux_segundos: std_logic_vector( 7 downto 0 );

    signal left_bits: std_logic_vector( 3 downto 0 );   -- xxxx(xxxx)
    signal right_bits: std_logic_vector( 3 downto 0 ) ; -- (xxxx)xxxx

begin
    led <= input_sw;

    divisor_clock: entity work.clk_div(divisor)
        generic map(
          MAX_CICLES => 25000000
        )

        port map(
            clk => real_clk,
            out_clk => clk_1hz
        );


    trava_core: entity work.trava( behavioral )
        generic map(
            senha => senha,
            tempo_para_desarme => tempo_para_desarme
        )
        port map(
            clock => clk_1hz,
            reset => reset_sw,
            input => input_sw,
            segundos => aux_segundos,
            trava_out => trava_out_led
        );

    
    right_display: entity work.binto7seg( seg_machine )
        port map(
            input => right_bits,
            display => display_R
        );

    left_display: entity work.binto7seg( seg_machine )
        port map(
            input => left_bits,
            display => display_L
        );

    right_bits <= aux_segundos( 3 downto 0 );
    left_bits <= aux_segundos( 7 downto 4 );

end architecture;