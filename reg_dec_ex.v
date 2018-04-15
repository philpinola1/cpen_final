	module reg_dec_ex(reg_out1,reg_out2,reg_out3,reg_out4,
			reg_out5,reg_out6,reg_out7,reg_out8,reg_out9,
		reg_in1,reg_in2,reg_in3,reg_in4,
		reg_in5,reg_in6,reg_in7,reg_in8,reg_in9,clock);
		
		input [0:31] reg_in1;
		input [0:5] reg_in2;
		input [0:5] reg_in3;
		input [0:31] reg_in4;
		input [0:4] reg_in5;
		input reg_in6,reg_in7;
		input [0:31] reg_in8;
		input [0:31] reg_in9;
		input clock;
		
		output [0:31] reg_out1;
		output [0:5] reg_out2;
		output [0:5] reg_out3;
		output [0:31] reg_out4;
		output [0:4] reg_out5;
		output reg_out6,reg_out7;
		output [0:31] reg_out8;
		output [0:31] reg_out9;
		 
		reg [0:31] reg_out1;
		reg [0:5] reg_out2;
		reg [0:5] reg_out3;
		reg [0:31] reg_out4;
		reg [0:4] reg_out5;
		reg reg_out6,reg_out7;
		reg [0:31] reg_out8;
		reg [0:31] reg_out9;

		
		always @ (posedge clock)
		begin 
			reg_out1=reg_in1;
			reg_out2=reg_in2;
			reg_out3=reg_in3;
			reg_out4=reg_in4;
			reg_out5=reg_in5;
			reg_out6=reg_in6;			
			reg_out7=reg_in7;
			reg_out8=reg_in8;
			reg_out9=reg_in9;
		end
	endmodule
