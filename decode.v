	module decode(pc_out,op,fc,immed,a_reg_add,b_reg_add,d_reg_add,
			stall_if,stall_pipe,
			ir,pc_in,clock);
			
		input [0:31] ir,pc_in;
		input clock;
		

		//make some buffers to store the last a_reg_addr and b_reg_addr
		//then, compare to the next ir [6:10] and ir[11:15]
		//if there is a match, we are going to have some sort of hazard
		//need to find a way to determine how long we should stall for......
		output [0:31] pc_out,immed;
		output [0:5] op,fc;
		output [0:4] a_reg_add,b_reg_add,d_reg_add;
		output stall_if,stall_pipe;
		
		reg [0:31] pc_out,immed;
		reg [0:5] op,fc;
		reg [0:4] a_reg_add,b_reg_add,d_reg_add;
		reg stall_if,stall_pipe;

		reg[0:5] prevRegA, prevRegB;
		
		reg [0:31] temp;
		
		initial
		begin
			stall_if=0;
			stall_pipe=0;
		end

		always @ (negedge clock)
		begin
			pc_out=pc_in;
			op=ir[0:5];
			fc=ir[26:31];


			if ( prevRegA == ir[6:10] || prevRegA == ir[11:15] || prevRegB == ir[6:10] || prevRegB == ir[11:15] )	//stall 3 times
				begin
				stall_if = 1'b1;     // or 3?
				stall_pipe = 1'b1;
				end
				 
			else 
				begin
					casex (op)
			
					//opcode=0 --> R type instruction format
					6'b000000:
					begin
						a_reg_add=ir[6:10];
						b_reg_add=ir[11:15];
						d_reg_add=ir[16:20];
					end
					
					// if here then its an I type instruction with 16 bit imm
					default
					begin
						a_reg_add=ir[6:10];
						b_reg_add=ir[11:15];
						d_reg_add=ir[11:15];  //<---- OG
						//d_reg_add=ir[16:20];
						if(ir[16]==0)
							immed={16'b0000000000000000,ir[16:31]};
						else
							immed={16'b1111111111111111,ir[16:31]};
					end
					endcase
				end

		prevRegA = ir[6:10];
		prevRegB = ir[11:15];
		end
	endmodule
