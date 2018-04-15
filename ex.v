	module ex(alu_out,mem_data,cond,op_out,fc_out,stall_out,dreg_out,
		pc,op_in,fc_in,immed,alu_in_a,alu_in_b,dreg_in,stall_in,clock);
			
		input [0:31] pc,immed,alu_in_a,alu_in_b;
		input [0:5] op_in,fc_in;
		input [0:4] dreg_in;
		input stall_in,clock;
		
		output [0:31] alu_out,mem_data;
		output [0:5] op_out,fc_out;
		output [0:4] dreg_out;
		output cond,stall_out;
		
		reg [0:31] alu_out,mem_data;
		reg [0:5] op_out,fc_out;
		reg [0:4] dreg_out;
		reg cond,stall_out;
		
		reg [0:31] unsigned_mask;
		
		initial
		begin
			unsigned_mask=32'h0000FFFF;
		end
		
		always @ (negedge clock)
		begin
		
			stall_out=stall_in;
			if(!stall_in)
			begin
				op_out=op_in;
				fc_out=fc_in;
				dreg_out=dreg_in;
				
				casex (op_in)
				
				// HALT
				6'b111111:
				begin
					#20 $stop;
				end
				
				//BEQZ
				6'b000100:
				begin
					alu_out=pc+immed;
					if(alu_in_a==0)
						cond=1;
					else
						cond=0;
				end
				
				//BNEZ
				6'b000101:
				begin
					alu_out=pc+immed;
					if(alu_in_a!=0)
						cond=1;
					else
						cond=0;
				end	
				
				//ADDI
				6'b001000:
				begin
					alu_out=alu_in_a+immed;
				end		
				
				//ADDUI
				6'b001001:
				begin
					alu_out=alu_in_a+(immed & unsigned_mask);
				end
				
				//SUBI
				6'b001010:
				begin
					alu_out=alu_in_a-immed;
				end		
				
				//SUBUI
				6'b001011:
				begin
					alu_out=alu_in_a-(immed & unsigned_mask);
				end

				
				//ANDI
				6'b001100:
				begin
					alu_out=alu_in_a & immed;
				end	
				
				//ORI
				6'b001101:
				begin
					alu_out=alu_in_a | immed;
				end	
				
				//XORI
				6'b001110:
				begin
					alu_out=alu_in_a ^ immed;
				end	
				
				//LHI
				6'b001111:
				begin
					alu_out= immed<<16;
				end	
				
				//SEQI
				6'b011000:
				begin
					if(alu_in_a==immed)
						alu_out=1;
					else
						alu_out=0;
				end
				
				//SNEI
				6'b011001:
				begin
					if(alu_in_a!=immed)
						alu_out=1;
					else
						alu_out=0;
				end
				
				//SLTI
				6'b011010:
				begin
					if(alu_in_a<immed)
						alu_out=1;
					else
						alu_out=0;
				end

				
				//SGTI
				6'b011011:
				begin
					if(alu_in_a>immed)
						alu_out=1;
					else
						alu_out=0;
				end
					
				//SLEI
				6'b011100:
				begin
					if(alu_in_a<=immed)
						alu_out=1;
					else
						alu_out=0;
				end
				
				//SGEI
				6'b011101:
				begin
					if(alu_in_a>=immed)
						alu_out=1;
					else
						alu_out=0;
				end
				
				//LB,LH,LW,LBU,LHU,LF,LD
				6'b100xxx:
				begin
					alu_out=alu_in_a+immed;
				end

				//SB,SH,SW,SF,SD
				6'b101xxx:
				begin
					alu_out=alu_in_a+immed;
					mem_data=alu_in_b;
				end
				
				//Special opcode=0, R format, use FC
				6'b000000:
				begin

				casex (fc_in)
				
				//ADD
				6'b100000:
				begin
					alu_out=alu_in_a+alu_in_b;
				end		
				
				//ADDU
				6'b100001:
				begin
					alu_out=alu_in_a+(alu_in_b & unsigned_mask);
				end
				
				//SUB
				6'b100010:
				begin
					alu_out=alu_in_a-alu_in_b;
				end		
				
				//SUBU
				6'b100011:
				begin
					alu_out=alu_in_a-(alu_in_b & unsigned_mask);
				end

				
				//AND
				6'b100100:
				begin
					alu_out=alu_in_a & alu_in_b;
				end	
				
				//OR
				6'b100101:
				begin
					alu_out=alu_in_a | alu_in_b;
				end	
				
				//XOR
				6'b100110:
				begin
					alu_out=alu_in_a ^ alu_in_b;
				end	

				//SEQ
				6'b101000:
				begin
					if(alu_in_a==alu_in_b)
						alu_out=1;
					else
						alu_out=0;
				end
				
				//SNE
				6'b101001:
				begin
					if(alu_in_a!=alu_in_b)
						alu_out=1;
					else
						alu_out=0;
				end
				
				//SLT
				6'b101010:
				begin
					if(alu_in_a<alu_in_b)
						alu_out=1;
					else
						alu_out=0;
				end

				//SGT
				6'b101011:
				begin
					if(alu_in_a>alu_in_b)
						alu_out=1;
					else
						alu_out=0;
				end
					
				//SLE
				6'b101100:
				begin
					if(alu_in_a<=alu_in_b)
						alu_out=1;
					else
						alu_out=0;
				end
				
				//SGE
				6'b101101:
				begin
					if(alu_in_a>=alu_in_b)
						alu_out=1;
					else
						alu_out=0;
				end
			
				endcase			//fc case
				end
				endcase			//op case
				
			end				//if (!stall)
		end					//always
	endmodule
