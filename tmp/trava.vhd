library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trava is
  generic (
    senha: natural range 0 to 255; -- Número usado como senha para destravar
    tempo_para_desarme: natural range 0 to 255 -- Em segundos
  );

  port (
    clock: in std_logic; -- Entrada de clock 1hz para contagem do tempo
    reset: in std_logic; -- Reset do tempo
    input: in std_logic_vector(7 downto 0);     -- Chaves para destravar
    segundos: out std_logic_vector(7 downto 0); -- Tempo para desbloqueio
    trava_out: out std_logic -- Sinal de led: 1 para travado, 0 para destravado
  );

end entity;

architecture behavioral of trava is
    type state_type is (q0, q1);
    signal current_state : state_type;
    signal timer : natural range 0 to 255 := tempo_para_desarme;
begin

    process (clock, reset)
    begin
        if reset = '1' then
            current_state <= q0;
            timer <= tempo_para_desarme;
        elsif rising_edge(clock) then
            case current_state is
                when q0 =>
                    if timer = 0 then
                        current_state <= q1;
                    elsif input = std_logic_vector(to_unsigned(senha, segundos'length)) then
                        current_state <= q1;
                    else
                        timer <= timer - 1;
                    end if;

                when q1 =>
                    null;
              end case;
        end if;
    end process;

    process(current_state, timer)
    begin
        case current_state is
            when q0 =>
                segundos <= std_logic_vector(to_unsigned(timer, segundos'length));
                trava_out <= '1';

            when q1 =>
                segundos <= std_logic_vector(to_unsigned(timer, segundos'length));
                trava_out <= '0';
        end case;
    end process;
end architecture;
