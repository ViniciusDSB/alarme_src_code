library ieee;
use ieee.std_logic_1164.all;


entity tb_trava is
end entity;

architecture test_trava of tb_trava is
    constant N : positive :=  15;

    type input_type is array (N downto 0) of std_logic_vector(3 downto 0);
    constant inputs : input_type; -- := ("...");

    -type output_type is array (N downto 0) of std_logic_vector(7 downto 0);
    constant outputs : output_type; -- := ("...");

    signal tb_aux_input : std_logic_vector(3 downto 0);
    signal tb_aux_output : std_logic_vector(7 downto 0);
begin

trava_one: entity work.trava(behavioral)
    -- port map( ... );

    process
    begin
        
        for i in inputs'range loop
            
            tb_aux_input <= inputs(i);
            wait for 1 ns;
            
            assert
                tb_aux_output = outputs(i)
                report "Input " & integer'image(i) & "failed"
                severity failure;
            
        end loop; 

            report "SUCESSO CARALHOOOOOO";
            wait;

    end process;

end architecture;