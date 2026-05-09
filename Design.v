module PISO(
   input [31:0] din_i, 
   input        load_i, 
   input        clk_i, 
   input        rst_i, 
   output reg   dout_o
);

//net(s)
reg [31:0] DATA;

//PISO Register
always@(posedge clk_i) begin
   if(rst_i)
      dout_o <= 1'b0;
   else if(load_i) begin
      DATA   <= din_i;
   end
   else begin
      dout_o <= DATA[0];
      DATA   <= {1'b0, DATA[31:1]};
   end
end

endmodule
