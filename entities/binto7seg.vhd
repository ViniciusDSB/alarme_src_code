library ieee;
use ieee.std_logic_1164.all;

entity binto7seg is
  port (
    input: in std_logic_vector(3 downto 0); -- Valor binário a ser mostrado
    display: out std_logic_vector(7 downto 0) -- Leds do Display de 7 seg.
  );

end entity;

architecture seg_machine of binto7seg is


begin
  
  -- Entrada vem de trava.vhd, num de 4 bit entre 0 e 15
  -- Saida para o segmento de 7 segmentos com 8 bits, um por segmento
  -- Os 8 bits sao do 0 ao 7 indo do mais singiifcativo ao menos significativo
  -- Ex: Em 0000000, cada bit representa os segmentos 0, 1, 2 ... DP, de acordo com manual da DE-0
  PROCESS (input)
   BEGIN

    CASE input IS 
      
      -- Output 0
      WHEN "0000" =>
        display <= "00000011";

      -- Output 1
      WHEN "0001" =>
        display <= "10011111";

      -- Output 2
      WHEN "0010" =>
        display <= "00100101";

      -- Output 3
      WHEN "0011" =>
        display <= "00001101";

      -- Output 4
      WHEN "0100" =>
        display <= "10011001";

      -- Output 5
      WHEN "0101" =>
        display <= "01001001";

      -- Output 6
      WHEN "0110" =>
        display <= "01000001";

      -- Output 7
      WHEN "0111" =>
        display <= "00011111";

      -- Output 8
      WHEN "1000" =>
        display <= "00000001";

      -- Output 9
      WHEN "1001" =>
        display <= "00001001";

      -- Output 10 (A)
      WHEN "1010" =>
        display <= "00010001";

      -- Output 11 (b)
      WHEN "1011" =>
        display <= "11000001";

      -- Output 12 (C)
      WHEN "1100" =>
        display <= "01100011";

      -- Output 13 (d)
      WHEN "1101" =>
        display <= "10000101";

      -- Output 14 (E)
      WHEN "1110" =>
        display <= "01100001";

      -- Output 15 (F)
      WHEN "1111" =>
        display <= "01110001";

    END CASE;
   END PROCESS;

end architecture;