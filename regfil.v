	module regfil(a_data,b_data,
			a_addr,b_addr,c_data,c_addr,wr,clock);
				
		input [0:31] c_data;
		input [0:4] a_addr,b_addr,c_addr;
		input wr,clock;
		
		output [0:31] a_data,b_data;
				
		wire [0:31] a_data,b_data;
			
		reg [0:31] r[0:31];
	
		initial
		begin
			r[0]=0;
		end		
	
		assign a_data=r[a_addr];
	
		assign b_data=r[b_addr];
		
		always @ (posedge clock)
		begin
			if (wr)
			begin
				if(c_addr!=0)
					r[c_addr]=c_data;
			end
		end
	endmodule
