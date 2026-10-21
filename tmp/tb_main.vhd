library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_main is
end;

architecture test_main of tb_main is

    signal test_clock, reset_sw, trava_led_out : std_logic;
    signal input_from_sw    : std_logic_vector(7 downto 0) := (others => '0');
    signal display_L_out, display_R_out : std_logic_vector(7 downto 0);

begin

    main_entity: entity work.main(container)
        port map(
            real_clk => test_clock,
            reset_sw => reset_sw,
            input_sw => input_from_sw,
            trava_out => trava_led_out,
            display_R => display_R_out,
            display_L => display_L_out
        );

    process is

         type linha_entradas is record
            clk_1hz : std_logic;
            reset_sw : std_logic;
            input_from_sw : std_logic_vector(7 downto 0);
            trava_led_out : std_logic;
            display_L, display_R : std_logic_vector( 7 downto 0);
        end record;

        type vet_linha_entradas is array(0 to 12) of linha_entradas;
        constant tabela_verdade : vet_linha_entradas := (
        --  1hz  rst_sw  in_sws   trava  display_L   display_R 
            ('0', '1', "00000000", '1', "00000000", "00000000"), -- fica em q0 fazendo nada
            ('1', '1', "00000000", '1', "00000000", "00000000"), -- fica em q0 fazendo nada
            ('0', '1', "00000000", '1', "00000000", "00000000"), -- fica em q0 fazendo nada
            ('1', '1', "00000000", '1', "00000000", "00000000"), -- fica em q0 fazendo nada
            ('0', '0', "00000000", '1', "00000000", "00000000"), -- vai a q1 onde segundos comecam a decrescer
            ('1', '0', "00000000", '1', "00000000", "00000000"), -- fica em q1 descontando segundos
            ('0', '0', "00000000", '1', "00000000", "00000000"), -- fica em q1 descontando segundos
            ('1', '0', "00000000", '1', "00000000", "00000000"), -- fica em q1 descontando segundos
            ('0', '0', "00000000", '1', "00000000", "00000000"), -- fica em q1 descontando segundos
            ('1', '0', "00000001", '0', "00000000", "00000001"), -- entrada muda, senha é correta, vai a q2 pois 
            ('0', '0', "00000001", '0', "00000000", "00000001"), -- fica em q2 fazendo nada
            ('1', '0', "00000001", '0', "00000000", "00000001"), -- fica em q2 fazendo nada
            ('0', '1', "00000001", '1', "00000000", "00000001")  -- volta a q0 fazendo nada
        );

    begin

        for i in tabela_verdade'range loop
            test_clock <= tabela_verdade(i).clk_1hz;
            reset_sw <= tabela_verdade(i).reset_sw;
            input_from_sw <= tabela_verdade(i).input_from_sw;

            wait for 1 ns;

            report "Displays: " & display_L_out(7);

            assert trava_led_out = tabela_verdade(i).trava_led_out
                report "TEST " & integer'image(i) & " expected/given " &
                    std_logic'image(tabela_verdade(i).trava_led_out) &
                    " at time " & time'image(now)
                severity error;

        end loop;

    end process;

end architecture;