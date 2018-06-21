library verilog;
use verilog.vl_types.all;
entity registerfile is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        dataIn          : in     vl_logic_vector(31 downto 0);
        dataInRegister  : in     vl_logic_vector(3 downto 0);
        enableSavingDataIn: in     vl_logic;
        dataOutRegisterA: in     vl_logic_vector(3 downto 0);
        dataOutRegisterB: in     vl_logic_vector(3 downto 0);
        registerA       : out    vl_logic_vector(31 downto 0);
        registerB       : out    vl_logic_vector(31 downto 0)
    );
end registerfile;
