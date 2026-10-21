library ieee;
use ieee.std_logic_1164.all;


entity tb_binto7seg is
end entity;

architecture test_binto7seg of tb_binto7seg is
    constant N : positive :=  15;

    type input_type is array (N downto 0) of std_logic_vector(3 downto 0);
    constant inputs : input_type := (
        "0000",
        "0001",
        "0010",
        "0011",
        "0100",
        "0101",
        "0110",
        "0111",
        "1000",
        "1001",
        "1010",
        "1011",
        "1100",
        "1101",
        "1110",
        "1111"
    );

    type output_type is array (N downto 0) of std_logic_vector(7 downto 0);
    constant outputs : output_type := (
        "00000011",
        "10011111",
        "00100101",
        "00001101",
        "10011001",
        "01001001",
        "01000001",
        "00011111",
        "00000001",
        "00001001",
        "00010001",
        "11000001",
        "01100011",
        "10000101",
        "01100001",
        "01110001"
    );

    signal tb_aux_input : std_logic_vector(3 downto 0);
    signal tb_aux_output : std_logic_vector(7 downto 0);
begin

binto7Seg_one: entity work.binto7seg(seg_machine)
    port map( input => tb_aux_input, display => tb_aux_output);

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

            report "SUCESSO";
            wait;

    end process;

end architecture;