module tb_PISO();
reg load_ti;
reg clk_ti;
reg rst_ti;
reg [31:0]din_ti;
wire dout_to;

//instantiation
PISO DUT(.din_i(din_ti), 
   .load_i(load_ti), 
   .clk_i(clk_ti), 
   .rst_i(rst_ti), 
   .dout_o(dout_to));

//clock
initial begin
   clk_ti = 1'b0;
   forever
      #5 clk_ti = ~clk_ti;
end

//feeding
initial begin
rst_ti = 1'b1;
load_ti = 1'b0;
din_ti = 32'h00000000;
#10 rst_ti = 1'b0;
load_ti = 1'b1;
din_ti = 32'h84fac960;
#10 load_ti = 1'b0;
din_ti = 32'hffffffff;
#330 load_ti = 1'b1;
#10 load_ti = 1'b0;
#50 load_ti = 1'b1;
#10 $finish;
end

//capture
initial begin
$monitor("Time: %0t | Load: %b, Clk: %b | Input: %h | Output: %h", $time, load_ti, clk_ti, din_ti, dout_to);
$dumpfile("PISO.vcd");
$dumpvars(0, tb_PISO);
end
endmodule