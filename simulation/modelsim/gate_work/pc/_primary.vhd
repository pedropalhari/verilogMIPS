library verilog;
use verilog.vl_types.all;
entity pc is
    port(
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        dataOut         : out    vl_logic_vector(9 downto 0)
    );
end pc;
