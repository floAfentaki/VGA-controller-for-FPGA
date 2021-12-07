module FourMegaHertz (reset, clk, enable, clkdiv4);
input reset, clk, enable;
output clkdiv4;
reg [1:0] cnt;

assign clkdiv4 = (cnt==2'd3);
always @(posedge reset or posedge clk)
  if (reset) cnt <= 0;
   else if (enable) 
          if (clkdiv4) cnt <= 0;
            else cnt <= cnt + 1;
endmodule


module top (reset, clk, pixelClk);
input reset, clk;
output pixelClk;

FourMegaHertz clk0 (reset, clk, 1, pixelClk);

endmodule
