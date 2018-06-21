library verilog;
use verilog.vl_types.all;
entity cpu is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        out1            : out    vl_logic_vector(31 downto 0);
        out2            : out    vl_logic_vector(31 downto 0);
        out3            : out    vl_logic_vector(31 downto 0);
        out4            : out    vl_logic_vector(31 downto 0)
    );
end cpu;
