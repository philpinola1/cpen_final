	module reg_mem_wb(reg_out1,reg_out2,reg_out3,reg_out4,reg_out5,
		reg_in1,reg_in2,reg_in3,reg_in4,reg_in5,clock);
		
		input [0:31] reg_in1;
		input [0:4] reg_in2;
		input reg_in3;
		input [0:31] reg_in4;
		input reg_in5;
		input clock;
		
		output [0:31] reg_out1;
		output [0:4] reg_out2;
		output reg_out3;
		output [0:31] reg_out4;
		output reg_out5;
		 
		reg [0:31] reg_out1;
		reg [0:4] reg_out2;
		reg reg_out3;
		reg [0:31] reg_out4;
		reg reg_out5;
		
		always @ (posedge clock)
		begin 
			reg_out1=reg_in1;
			reg_out2=reg_in2;
			reg_out3=reg_in3;
			reg_out4=reg_in4;
			reg_out5=reg_in5;
		end
	endmodule
