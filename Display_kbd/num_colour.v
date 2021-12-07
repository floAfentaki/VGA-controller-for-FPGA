module numORcolour (clk, bin, reds, greens, blues);

input clk;
input [3:0] bin;

output [26:0] reds;
output [26:0] greens;
output [26:0] blues;

reg [3:0] num;

reg [26:0] reds;
reg  [26:0] greens;
reg  [26:0] blues;

reg [2:0] red;
reg [2:0] green;
reg [2:0] blue;

wire number;
wire colour;

assign number = (bin > 4'b0 && bin < 4'b1011) ? 1'b1 : 1'b0;
assign colour = (bin >1001)? 1'b1 : 1'b0;

//assign num = ( bin > 4'b0000 && bin <= 4'b1001 )?  bin : 4'b0000;


//always@(bin)
always@(posedge clk)
begin
	if ( bin > 4'b0000 && bin <= 4'b1001 ) 
	begin
		num <= bin;
		red <= 3'b000;
		green <= 3'b000;
		blue <= 3'b000;
	end
	else if(num != 4'b0000)
   begin
		if ( bin == 4'b1011 ) // green
		begin
			red  <= 3'b000;
			green <= 3'b111;
			blue  <= 3'b000;
		end
		else if ( bin == 4'b1010 ) // red
			begin
				red <= 3'b111;
				green <= 3'b011;
				blue  <= 3'b111;
			end
		else if ( bin == 4'b1100 ) // blue
			begin
				red <= 3'b001;
				green <= 3'b111;
				blue <= 3'b111;
			end		
	end
	
	if( num != 4'b0) 
	
		if(num == 4'b0001)
		begin 
			reds [2:0] <= red;
			greens [2:0] <= green;
			blues [2:0] <= blue;

		end
		else if(num == 4'b0010)
		begin 
			reds [5:3] <= red;
			greens [5:3] <= green;
			blues [5:3] <= blue;

		end
		else if(num == 4'b0011)
		begin 
			reds [8:6] <= red;
			greens [8:6] <= green;
			blues [8:6] <= blue;
		end
		else if(num == 4'b0100)
		begin 
			reds	[11:9] <= red;
			greens[11:9] <= green;
			blues [11:9] <= blue;
		end
		else if(num == 4'b0101)
		begin 
			reds	[14:12] <= red;
			greens[14:12] <= green;
			blues [14:12] <= blue;
		end
		else if(num == 4'b0110)
		begin 
			reds	[17:15] <= red;
			greens[17:15] <= green;
			blues [17:15] <= blue;
		end
		else if(num == 4'b0111)
		begin 
			reds	[20:18] <= red;
			greens[20:18] <= green;
			blues [20:18] <= blue;
		end
		else if(num == 4'b1000)
		begin 
			reds	[23:21] <= red;
			greens[23:21] <= green;
			blues [23:21] <= blue;
		end
		else if(num == 4'b1001)
		begin 
			reds	[26:24] <= red;
			greens[26:24] <= green;
			blues [26:24] <= blue;
		end
		else
		begin 
			reds	[26:0] <= 27'b0;
			greens[26:0] <= 27'b0;
			blues [26:0] <= 27'b0;
		end
	
end


//assign i = num ? 0:


endmodule