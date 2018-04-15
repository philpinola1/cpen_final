	module wb(reg_add,reg_data,reg_wr,
		data_in,dreg_in,stall_in,clock);
		
		input [0:31] data_in;
		input [0:4] dreg_in;
		input stall_in,clock;
		
		output [0:31] reg_data;
		output [0:4] reg_add;
		output reg_wr;
		 
		reg [0:31] reg_data;
		reg [0:4] reg_add;
		reg reg_wr; 

		always @ (negedge clock)
		begin 	
			reg_add=dreg_in;
			reg_data=data_in;
				
			if(!stall_in)
			begin	
				reg_wr=1;
			end
			else
				reg_wr=0;
		end
	endmodule
