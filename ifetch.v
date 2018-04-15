	module ifetch(ir_out,pc_out,pc_in,pc_pulse,stall,clock);
		input [0:31] pc_in;
		input pc_pulse,stall,clock;
		output [0:31] ir_out,pc_out; 
		reg [0:31] ir_out,pc_out;
		reg [0:31] pc;
		reg [0:31] prog_mem[0:255];
		reg [0:31] temp;
		
		initial
		begin
			pc=0;
		end
		
		initial
		begin
			$readmemh ("code.v",prog_mem);
		end
		
		always @ (negedge clock) 
		begin
		
			if(!stall)
			begin
				if(pc_pulse)
				begin
					pc=pc_in;
				end
				
				temp=pc>>2;
				ir_out=prog_mem[temp];
				pc_out=pc;
				pc=pc+4;
			end
		end
	endmodule
