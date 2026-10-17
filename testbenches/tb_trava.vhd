library ieee;
use ieee.std_logic_1164.all;

entity tb_trava is
end;

architecture test_trava of tb_trava is
    constant senha : positive := 56;
    constant tempo_para_desarme : natural := 30;

    signal clock, reset, trava_out : std_logic;
    signal input     : std_logic_vector(7 downto 0) := (others => '0');
    signal segundos : std_logic_vector(7 downto 0);
begin
    trava_one : entity work.trava(behavioral)
        generic map (senha => senha, tempo_para_desarme => tempo_para_desarme)
        port map (clock => clock, reset => reset, input => input, segundos => segundos, trava_out => trava_out);

    clk_gen: process
    begin
        clock <= '0';
        wait for 10 ns/2;
        clock <= '1';
        wait for 10 ns/2;
    end process;

    estimulo_check : process is
      type linha_tv is record
        reset, trava_out : std_logic;
        input : std_logic_vector(7 downto 0);
      end record;

      type vet_linha_tv is array(0 to 4) of linha_tv;
      constant tabela_verdade : vet_linha_tv := (
    -- reset  tr_out     input  
      ('1',    '1',  "00111000"), 
      ('0',    '0',  "00111000"),
      ('0',    '0',  "10000000"),
      ('1',    '1',  "10000000"),
      ('0',    '1',  "10000000")
      );
    begin
        for i in tabela_verdade'range loop
            reset <= tabela_verdade(i).reset;
            input <= tabela_verdade(i).input;

            wait until rising_edge(clock); 
            wait for 1 ns;

        assert trava_out = tabela_verdade(i).trava_out
            report "TEST " & integer'image(i) & " expected/given " &
                std_logic'image(tabela_verdade(i).trava_out) &
                "/" &
                std_logic'image(trava_out)
            severity failure;
      end loop;

      report "SUCESSO CARALHOOOOOO";
      wait;

    end process;
end architecture;