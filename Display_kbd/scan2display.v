module scan_2_7seg (scan, ss);
  input  [7:0] scan;
  output [7:0] ss;

  
  assign ss = (scan == 8'h45) ? 8'b01111110 :
              (scan == 8'h16) ? 8'b00110000 :
              (scan == 8'h1E) ? 8'b01101101 :
              (scan == 8'h26) ? 8'b01111001 :
              (scan == 8'h25) ? 8'b00110011 :
              (scan == 8'h2E) ? 8'b01011011 :
              (scan == 8'h36) ? 8'b01011111 :
              (scan == 8'h3D) ? 8'b01110010 :
              (scan == 8'h3E) ? 8'b01111111 :
              (scan == 8'h46) ? 8'b01111011 : 8'b10000000 ;
endmodule 


module scan_2_bin(ss, bin);
  input  [7:0] ss;
  output [3:0] bin;
  wire [3:0] bin;
  
  assign bin = //ss == 8'h45)? 4'b0000 :		//0
              (ss == 8'h16)? 4'b0001 :		//1
              (ss == 8'h1E)? 4'b0010 :		//2
              (ss == 8'h26)? 4'b0011 :		//3
              (ss == 8'h25)? 4'b0100 :
              (ss == 8'h2E)? 4'b0101 :
              (ss == 8'h36)? 4'b0110 :
              (ss == 8'h3D)? 4'b0111 :
              (ss == 8'h3E)? 4'b1000 :
			  (ss == 8'h46)? 4'b1001 : 		//9
			  (ss == 8'h2D)? 4'b1010 : 		//red
			  (ss == 8'h34)? 4'b1011 : 		//green
			  (ss == 8'h32)? 4'b1100 : 4'b0000; //blue
			  
endmodule

module bin2bcd(bin, bcd);
input  [7:0] bin;
output [11:0] bcd;
reg [11:0] bcd;
reg [3:0] i;

always@(bin)
	begin 
		bcd=0;
		for(i=0; i<8; i=i+1)
		begin 
			bcd = {bcd[10:0],bin[7-i]};
			
			if(i<7 && bcd[3:0]>4)
				bcd[3:0] = bcd[3:0] +3;
			if(i<7 && bcd[7:4]>4)
				bcd[7:4] = bcd[7:4] +3;	
			if(i<7 && bcd[11:8]>4)
				bcd[11:8] = bcd[11:8] +3;
		end
		
	end
	

endmodule


module bcd_2_7seg (bcd, display);
  input  [11:0] bcd;
  output [7:0] display;

  
  assign display = (bcd  == 12'd0) ? 8'b01111110 :		//0
              (bcd == 12'd1) ? 8'b00110000 :		//1
              (bcd  == 12'd2) ? 8'b01101101 :		//2
              (bcd  == 12'd3) ? 8'b01111001 :		//3
              (bcd  == 12'd4) ? 8'b00110011 :
              (bcd  == 12'd5) ? 8'b01011011:
              (bcd  == 12'd6) ? 8'b01011111 :
              (bcd  == 12'd7) ? 8'b01110010 :
              (bcd  == 12'd8) ? 8'b01111111 :
              (bcd  == 12'd9) ? 8'b01111011 : 8'b10000000 ;
				  
				   
				  				  
endmodule 

