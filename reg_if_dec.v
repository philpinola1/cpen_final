	module reg_if_dec(reg_out1,reg_out2,
		reg_in1,reg_in2,clock);
		
		input [0:31] reg_in1;
		input [0:31] reg_in2;
		input clock;
		
		output [0:31] reg_out1;
		output [0:31] reg_out2;
			 
		reg [0:31] reg_out1;
		reg [0:31] reg_out2;
			
		always @ (posedge clock)
		begin 
			reg_out1=reg_in1;
			reg_out2=reg_in2;
		end
	endmodule
