module oneFourthMegaHertz (reset, clk, enable, clkdiv4);
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



module oneFifthMegaHertz (reset, clk, enable, clkdiv5);
input reset, clk, enable;
output clkdiv5;
reg [2:0] cnt;

assign clkdiv5 = (cnt==2'd4);
always @(posedge reset or posedge clk)
  if (reset) cnt <= 0;
   else if (enable) 
          if (clkdiv5) cnt <= 0;
            else cnt <= cnt + 1;
endmodule

module vga_controller (clk, pixelClk, r, g, b, hsync, vsync, reds, greens, blues);

parameter hbp = 48;
parameter hfp = 16;
parameter hsp = 96;
parameter visPix = 640;

parameter startVisH = hbp+hfp+hsp;
parameter endHSync = startVisH + visPix;

parameter boxSizeH = visPix/3;
parameter box_y1 = startVisH + boxSizeH;
parameter box_y2 = box_y1 + boxSizeH;
parameter box_y3 = box_y2 + boxSizeH;



parameter vbp = 35;
parameter vfp = 12;
parameter vsp = 2;
parameter visRow = 400;

parameter startVisV = vbp+vfp+vsp;
parameter endVSync = startVisV + visRow;

parameter boxSizeV = visRow/3;
parameter box_1x = startVisV + boxSizeV;
parameter box_2x = box_1x + boxSizeV;
parameter box_3x = box_2x + boxSizeV;


input clk, pixelClk;

input [26:0] reds;
input [26:0] greens;
input [26:0] blues;


output [2:0] r, g, b;
reg [2:0] r, g, b;
output hsync, vsync;
reg hsync, vsync;

reg [9:0] countR;
reg [8:0] countV;



wire visibleR;
wire visibleV;
wire visibleArea;
wire first_row;
wire second_row;
wire third_row;
wire first_column;
wire second_column;
wire third_column;

wire selectedBoxRow;
wire selectedBoxCol;
wire selected;

//800 449
//640 400



 always@(posedge clk)
 begin
 
 
 if (pixelClk == 1'b1)
 begin 
	if (countR == 10'd799)
	begin
		countR <= 10'd0;
		if(countV == 9'd448) countV <= 9'd0;
		else countV <= countV+9'b1;
	end
	else countR <= countR+10'b1;	
	
	
	if (countR >= 16 && countR < 48)	hsync <= 1'b0;
   else hsync <= 1'b1;
 
	if (countV >= 12 && countV < 35)	vsync <= 1'b1;
	else vsync <= 1'b0;
	
	
 end
 
 
 
 end
 
 
 assign visibleR = (countR >= startVisH && countR < endHSync);
 assign visibleV = (countV >= startVisV && countV < endVSync);
 assign visibleArea = visibleV && visibleR;
 
 assign first_row = (countV >= startVisV && countV < box_1x );
 assign second_row = (countV >= box_1x && countV < box_2x );
 assign third_row = (countV >= box_2x && countV < box_3x );
 
 assign first_column = ( countR >= startVisH && countR < box_y1 );
 assign second_column = ( countR >= box_y1 && countR < box_y2 );
 assign third_column = ( countR >= box_y2 && countR < box_y3 );
 
 /*assign selectedBoxRow = ( bin/4 == 4'b0000 ) ? first_row :
								  ( bin/4 == 4'b0001 ) ? second_row :
								  ( bin/4 == 4'b0010 ) ? third_row : 1'b0;
  
 assign selectedBoxCol = ( bin%4 == 4'b0001 ) ? first_column :
								  ( bin%4 == 4'b0010 ) ? second_column :
								  ( bin%4 == 4'b0011 ) ? third_column : 1'b0;
 */
 /*assign selected = ( bin == 4'd1 ) ? first_row && first_column:
								  ( bin == 4'd2) ? first_row && second_column :
								  ( bin == 4'd3 ) ? first_row && third_column : 
								  ( bin == 4'd4 ) ? second_row && first_column :
								  ( bin == 4'd5 ) ? second_row && second_column :
								  ( bin == 4'd6 ) ? second_row && third_column : 
								  ( bin == 4'd7) ? third_row && first_column :
								  ( bin == 4'd8 ) ? third_row && second_column :
								  ( bin == 4'd9 ) ? third_row && third_column : 1'b0;*/
								  
 
 
 always@(posedge clk)
 if (pixelClk == 1'b1)
 begin
	 if( visibleArea == 1'b1)
	 begin
		if ( first_row && first_column ) begin
			//r <= 3'b111;
			//g <= 3'b000;
			//b <= 3'b000;
			
			r <= reds[2:0] ; 
			g <= greens[2:0] ; 
			b <= blues[2:0] ; 
		end
		else if ( first_row && second_column) begin
			//r <= 3'b000;
			//g <= 3'b111;
			//b <= 3'b000;
			
			r <= reds[5:3] ; 
			g <= greens[5:3] ; 
			b <= blues[5:3] ; 
		end
		else if ( first_row && third_column ) begin
			//r <= 3'b000;
			//g <= 3'b000;
			//b <= 3'b111;
			
			r <= reds[8:6] ; 
			g <= greens[8:6] ; 
			b <= blues[8:6] ; 
		end
		else if ( second_row && first_column ) begin
		//if(bin==4'b0100) begin
			//r <= 3'b011;
			//g <= 3'b111;
			//b <= 3'b111;
			
			r <= reds[11:9]  ; 
			g <= greens[11:9] ; 
			b <= blues[11:9] ; 
		//	end
		end
		else if ( second_row && second_column ) begin
			//r <= 3'b111;
			//g <= 3'b011;
			//b <= 3'b111;
			
			r <= reds[14:12]; 
			g <= greens[14:12] ; 
			b <= blues[14:12] ; 
		end
		else if ( second_row && third_column) begin
			//r <= 3'b111;
			//g <= 3'b111;
			//b <= 3'b011;
			
			r <= reds[17:15]; 
			g <= greens[17:15] ; 
			b <= blues[17:15]; 
		end
		else if ( third_row && first_column ) begin
			//r <= 3'b001;
			//g <= 3'b111;
			//b <= 3'b111;
			
			r <= reds[20:18]; 
			g <= greens[20:18] ; 
			b <= blues[20:18] ; 
		end
		else if ( third_row && second_column ) begin
			//r <= 3'b111;
			//g <= 3'b001;
			//b <= 3'b111;
			
			r <= reds[23:21]; 
			g <= greens[23:21]; 
			b <= blues[23:21]; 
		end
		else if ( third_row && third_column ) begin
			//r <= 3'b111;
			//g <= 3'b111;
			//b <= 3'b001;
			
			r <= reds[26:24] ; 
			g <= greens[26:24] ; 
			b <= blues[26:24] ; 
		end
		/*if ( selected ) begin
			r <= 3'b111;
			g <= 3'b111;
			b <= 3'b001;
		end*/
		else
		begin
		r <= 3'b000;
		g <= 3'b000;
		b <= 3'b000;
		end
	 end
	 else 
	 begin 
		r <= 3'b000;
		g <= 3'b000;
		b <= 3'b000;
	 end
 end
 
  
endmodule
/*
module kbd2display (reset, clk, ps2clk, ps2data, left, right, bin);
  input        reset, clk;
  input        ps2clk, ps2data;
  output [7:0] left, right;
  

  //bin2bcd b2b0(bin, bcd);
  //bcd_2_7seg b27s0(bcd, left);
  //scan_2_7seg  lft (scan, left);
  //scan_2_7seg  rft (scanPrev, right);


  
endmodule
*/

module top (reset, clk, r, g, b, hsync, vsync, ps2clk, ps2data, left, right);
input reset, clk;

input ps2clk, ps2data;
output [7:0] left, right;
wire   [3:0] bin;
wire   [11:0] bcd;

wire   [7:0] scan;
wire   [7:0] scanPrev;
wire   [7:0] scanPrev2;

wire [26:0] reds;
wire  [26:0] greens;
wire  [26:0] blues;

output[2:0] r, g, b;
output hsync, vsync;

wire pixelClk;

oneFourthMegaHertz clk0 (reset, clk, 1'b1, pixelClk);

kbd_protocol kbd (reset, clk, ps2clk, ps2data, scan, scanPrev, scanPrev2);
scan_2_bin s2b0 (scan, bin);
bin2bcd b2b0(bin, bcd);
bcd_2_7seg b27s0(bcd, left);
bcd_2_7seg b27s1(4'b1111, right);

numORcolour noc0 (clk, bin, reds, greens, blues);
vga_controller show0 (clk, pixelClk, r, g, b, hsync, vsync,  reds, greens, blues);

//kbd2display k2d0 (reset, clk, ps2clk, ps2data, left, right, bin);

endmodule


















