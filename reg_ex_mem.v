	module reg_ex_mem(reg_out1,reg_out2,reg_out3,reg_out4,
			reg_out5,reg_out6,reg_out7,
		reg_in1,reg_in2,reg_in3,reg_in4,reg_in5,reg_in6,reg_in7,clock);
		
		input [0:31] reg_in1;
		input [0:31] reg_in2;
		input reg_in3;
		input [0:5] reg_in4;
		input [0:5] reg_in5;
		input [0:4] reg_in6;
		input reg_in7;
		input clock;
		
		output [0:31] reg_out1;
		output [0:31] reg_out2;
		output reg_out3;
		output [0:5] reg_out4;
		output [0:5] reg_out5;
		output [0:4] reg_out6;
		output reg_out7;
		 
		reg [0:31] reg_out1;
		reg [0:31] reg_out2;
		reg reg_out3;
		reg [0:5] reg_out4;
		reg [0:5] reg_out5;
		reg [0:4] reg_out6;
		reg reg_out7;

		
		always @ (posedge clock)
		begin 
			reg_out1=reg_in1;
			reg_out2=reg_in2;
			reg_out3=reg_in3;
			reg_out4=reg_in4;
			reg_out5=reg_in5;
			reg_out6=reg_in6;
			reg_out7=reg_in7;
		end
	endmodule
