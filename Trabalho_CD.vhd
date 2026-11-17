library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Trabalho_cd is
    port (
        A : in  std_logic_vector(4 downto 0);
        B : in  std_logic_vector(4 downto 0);
        Ctrl : in  std_logic;
        S : out std_logic_vector(4 downto 0);
        Ovf : out std_logic;
        Sig : out std_logic;
        HEX_Dez : out std_logic_vector(6 downto 0);
        HEX_Uni : out std_logic_vector(6 downto 0)
    );
end Trabalho_cd;

architecture arch_Trabalho_cd of Trabalho_cd is

    component full_adder is
        port (
            A : in  std_logic;
            B : in  std_logic;
            Cin : in  std_logic;
            S : out std_logic;
            Cout : out std_logic
        );
    end component;

    component xor_block is
        port (
            B : in  std_logic_vector(4 downto 0);
            Ctrl : in  std_logic;
            B_out : out std_logic_vector(4 downto 0)
        );
    end component;

    component bcd_converter is
        port (
            S : in  std_logic_vector(4 downto 0);
            Dez : out std_logic_vector(3 downto 0);
            Uni : out std_logic_vector(3 downto 0);
            Sig : out std_logic
        );
    end component;

    component decoder_7seg is
        port (
            Bcd : in  std_logic_vector(3 downto 0);
            Seg : out std_logic_vector(6 downto 0)
        );
    end component;

    signal B_xor  : std_logic_vector(4 downto 0);
    signal C      : std_logic_vector(4 downto 0);
    signal S_temp : std_logic_vector(4 downto 0);
    signal Dez_s  : std_logic_vector(3 downto 0);
    signal Uni_s  : std_logic_vector(3 downto 0);

begin

    U_XOR: xor_block port map (B => B, Ctrl => Ctrl, B_out => B_xor);

    FA0: full_adder port map (A => A(0), B => B_xor(0), Cin => Ctrl, S => S_temp(0), Cout => C(0));

    FA1: full_adder port map (A => A(1), B => B_xor(1), Cin => C(0), S => S_temp(1), Cout => C(1));

    FA2: full_adder port map (A => A(2), B => B_xor(2), Cin => C(1), S => S_temp(2), Cout => C(2));

    FA3: full_adder port map (A => A(3), B => B_xor(3), Cin => C(2), S => S_temp(3), Cout => C(3));

    FA4: full_adder port map (A => A(4), B => B_xor(4), Cin => C(3), S => S_temp(4), Cout => C(4));

    S <= S_temp;

    Ovf <= C(3) xor C(4);

    U_BCD: bcd_converter port map (S => S_temp, Dez => Dez_s, Uni => Uni_s, Sig => Sig);

    DEC_DEZ: decoder_7seg port map (Bcd => Dez_s, Seg => HEX_Dez);

    DEC_UNI: decoder_7seg port map (Bcd => Uni_s, Seg => HEX_Uni);

end arch_Trabalho_cd;