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
    type state_type is (q0, q1, q2, q3);
    signal current_state, next_state : state_type;
    signal timer : natural range 0 to 255 := tempo_para_desarme;
begin

    process (clock, reset, input, timer)
    begin
        if reset = '1' then
            current_state <= q0;
            timer <= tempo_para_desarme;

        elsif (clock'event and clock = '1') then 
            if (current_state = q1 or current_state = q2) and timer > 0 then
                timer <= timer - 1;
            end if;

            case current_state is
                when q0 =>
                    timer <= tempo_para_desarme;
                    current_state <= q1;
                    
                when q1 => 
                    if timer = 0 then
                        current_state <= q0;
                    elsif input'event then
                        current_state <= q2;
                    else
                        current_state <= q1;
                    end if;
    
                when q2 => 
                    if input = std_logic_vector(to_unsigned(senha, input'length)) and timer > 0 then 
                        current_state <= q3;
                    elsif timer = 0 then
                        current_state <= q0;
                    else
                        current_state <= q1;
                    end if;

                when q3 =>
                    timer <= 0;
                    current_state <= q3;
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
                trava_out <= '1';

            when q2 =>
                segundos <= std_logic_vector(to_unsigned(timer, segundos'length));
                trava_out <= '1';

            when q3 =>
                segundos <= std_logic_vector(to_unsigned(timer, segundos'length));
                trava_out <= '0';
        end case;
    end process;
end architecture;
