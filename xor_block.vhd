library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_block is
    port (
        B : in  std_logic_vector(4 downto 0);
        Ctrl : in  std_logic;
        B_out : out std_logic_vector(4 downto 0)
    );
end xor_block;

architecture arch_xor_block of xor_block is
begin
    B_out(0) <= B(0) xor Ctrl;
    B_out(1) <= B(1) xor Ctrl;
    B_out(2) <= B(2) xor Ctrl;
    B_out(3) <= B(3) xor Ctrl;
    B_out(4) <= B(4) xor Ctrl;
end arch_xor_block;