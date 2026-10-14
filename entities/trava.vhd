library ieee;
use ieee.std_logic_1164.all;

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
    trava: out std_logic -- Sinal de led: 1 para travado, 0 para destravado
  );

end entity;