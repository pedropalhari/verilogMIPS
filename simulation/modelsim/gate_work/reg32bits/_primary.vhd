library verilog;
use verilog.vl_types.all;
entity reg32bits is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        dataIn          : in     vl_logic_vector(31 downto 0);
        dataOut         : out    vl_logic_vector(31 downto 0)
    );
end reg32bits;
