library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_DSP_convmax is
end tb_DSP_convmax;

library work;
use work.conv_package.all;

architecture tb_architecture of tb_DSP_convmax is
    signal CLK, reset : std_logic := '0';
    signal output_tb : output;
signal img : integer_3d_vector :=
   (((0, 7, 8),(0, 7, 8), (5, 8, 8),(9, 3, 1),(8, 5, 8),(2, 9, 3), (3, 7, 8),(8, 5, 1)),
    ((10, 6, 10),(8, 4, 8),(7, 7, 2),(7, 8, 5),(5, 7, 2),(4, 6, 2),(3, 4, 3),(3, 7, 2)),
((3, 8, 4),(7, 0, 4),(6, 6, 4),(1, 6, 0),(3, 9, 4),(9, 3, 4),(9, 1, 5),(3, 1, 4)),
((0, 1, 9), (3, 5, 1), (2, 9, 9), (3, 5, 5), (4, 4, 2), (6, 6, 2), (1, 1, 6), (4, 4, 1)),
    ((8, 10, 2), (3, 4, 4), (1, 1, 9), (5, 5, 6), (6, 0, 3), (8, 5, 10), (10, 6, 4), (9, 0, 1)),
    ((4, 1, 4), (7, 8, 8), (4, 5, 10), (8, 4, 9), (8, 4, 1), (1, 6, 9), (7, 2, 3), (2, 8, 6)),
((9, 9, 8), (3, 8, 3), (6, 4, 4), (9, 2, 10), (4, 7, 8), (6, 5, 4), (2, 4, 8), (5, 2, 8)),
((10, 5, 8), (6, 5, 4), (1, 4, 2), (2, 10, 5), (4, 3, 9), (6, 6, 0), (5, 6, 2), (1, 8, 4)));  
    signal kernel : integer_4d_vector :=
 (
(((7, 8, 9, 0, 9, 4, 8, 8, 5, 8, 8, 7, 10, 4, 9, 6), (0, 5, 8, 8, 4, 1, 1, 7, 9, 10, 7, 10, 1, 9, 9, 10), (0, 1, 0, 4, 4, 2, 9, 6, 9, 6, 6, 2, 6, 8, 3, 6)),
((1, 2, 5, 0, 0, 0, 7, 4, 5, 9, 2, 3, 4, 6, 3, 4), (8, 8, 10, 0, 1, 3, 2, 6, 1, 1, 8, 0, 8, 9, 9, 9), (2, 5, 10, 0, 5, 8, 0, 4, 1, 5, 10, 3, 3, 6, 7, 5)),
((6, 8, 5, 3, 7, 5, 8, 1, 2, 9, 3, 10, 5, 6, 9, 8), (2, 1, 4, 5, 2, 8, 4, 2, 1, 1, 4, 3, 1, 1, 7, 9), (1, 8, 8, 8, 1, 6, 8, 6, 1, 2, 8, 2, 3, 6, 10, 5))),
(((5, 2, 8, 4, 7, 3, 5, 7, 5, 1, 10, 7, 9, 8, 9, 9), (7, 9, 7, 2, 8, 8, 7, 4, 5, 9, 1, 1, 9, 7, 3, 7), (8, 10, 4, 5, 9, 5, 1, 4, 8, 8, 0, 3, 8, 5, 5, 4)),
((4, 8, 3, 6, 10, 1, 4, 8, 1, 7, 0, 9, 9, 8, 8, 7), (9, 9, 7, 2, 9, 5, 7, 9, 0, 3, 0, 6, 3, 1, 6, 2), (2, 8, 1, 8, 7, 2, 4, 4, 3, 7, 5, 4, 3, 8, 8, 5)),
((7, 10, 10, 8, 1, 6, 5, 6, 3, 9, 9, 4, 5, 2, 8, 5), (2, 9, 3, 1, 5, 5, 9, 3, 4, 5, 8, 7, 1, 2, 2, 2), (4, 4, 6, 7, 1, 10, 10, 2, 10, 1, 4, 6, 3, 9, 0, 2))),
       (((8, 9, 3, 2, 7, 8, 6, 5, 7, 7, 7, 2, 6, 9, 5, 6), (1, 10, 8, 9, 2, 8, 4, 4, 0, 4, 0, 2, 9, 1, 1, 1), (9, 9, 9, 2, 7, 1, 7, 6, 7, 5, 3, 7, 5, 6, 6, 3)),
((10, 0, 7, 6, 4, 4, 9, 8, 6, 5, 8, 6, 0, 6, 5, 4), (6, 4, 7, 3, 0, 3, 0, 8, 5, 5, 1, 6, 5, 10, 1, 3), (3, 2, 5, 1, 7, 4, 2, 3, 4, 8, 5, 1, 4, 4, 4, 5)),
((5, 9, 9, 8, 7, 1, 1, 5, 10, 7, 2, 4, 3, 9, 6, 10), (10, 1, 7, 1, 1, 2, 7, 0, 4, 6, 5, 2, 3, 9, 4, 8), (2, 3, 2, 6, 4, 10, 4, 2, 8, 9, 9, 1, 1, 1, 4, 4)))
    );

begin
    -- Instantiate the DSP_convmax entity
    DUT : entity work.YOLO_VHDL_Source
        port map (
            CLK => CLK,
            reset => reset,
            img => img,
            kernel => kernel,
            new_img => output_tb
            
            
        );

    -- Clock process
    CLK_process: process
    begin
        while now < 7000 ns loop
            CLK <= not CLK;
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Initialize inputs here if needed

        -- Apply reset
        reset <= '1';
        wait for 10 ns;
        reset <= '0';

        -- Wait for some time before applying inputs
        wait for 10 ns;

        -- Apply test input data here if needed

        -- Wait for some time to observe the output
        wait for 100 ns;

        -- Add assertions for expected output data here if needed

        wait;

    end process;

end tb_architecture;