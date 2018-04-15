	module mem(mdr_out,stall_out,dreg_out,pc,pc_pulse,
		alu_data_in,mdr_in,cond,op,fc,dreg_in,stall_in,clock);
		
		input [0:31] alu_data_in,mdr_in;
		input [0:5] op,fc;
		input [0:4] dreg_in;
		input cond,stall_in,clock;
		
		output [0:31] mdr_out,pc;
		output [0:4] dreg_out;
		output stall_out,pc_pulse;
		 
		reg [0:31] mdr_out,pc;
		reg [0:4] dreg_out;
		reg stall_out,pc_pulse;
		
		reg [0:31] data_mem[0:255];

                reg [0:31]temp;
                reg temp_pc_pulse,temp_stall;
                
                reg [0:31] zero_byte_mask,one_byte_mask,zero_half_mask,one_half_mask;
                
                initial
                begin
                	zero_byte_mask=32'h 000000FF;
                	one_byte_mask=32'hFFFFFF00;
                	zero_half_mask=32'h 0000FFFF;
                	one_half_mask=32'hFFFF0000;
                end
                
                initial
                begin
                	$readmemh ("data.v",data_mem);
                end
                                                              		
		always @ (negedge clock)
		begin
			temp_stall=stall_in;
			temp_pc_pulse=0;
			 		
			if(!stall_in)
			begin
				dreg_out=dreg_in;

				casex (op)
				
				//LB
				6'b100000:
				begin
					temp=data_mem[alu_data_in[0:29]];
					case (alu_data_in[30:31])
                                                2'b00:temp=temp>>24;      
                                                2'b01:temp=temp>>16;
                                                2'b10:temp=temp>>8;
                                                2'b11:temp=temp;
                           		endcase
                           		temp=temp & zero_byte_mask;

                          		if (temp[24]==1)
                           			mdr_out=temp | one_byte_mask;
                           		else
                           			mdr_out=temp;
                           	end
                          	
                          	 //LBU
				6'b100100:
				begin
					temp=data_mem[alu_data_in[0:29]];
					case (alu_data_in[30:31])
                                                2'b00:temp=temp>>24;      
                                                2'b01:temp=temp>>16;
                                                2'b10:temp=temp>>8;
                                                2'b11:temp=temp;
                           		endcase
                           		mdr_out=temp & zero_byte_mask;	
                          	end

                                //LH
				6'b100001:
				begin
					temp=data_mem[alu_data_in[0:29]];
					case (alu_data_in[30])
                                                1'b0:temp=temp>>16;      
                                                1'b1:temp=temp;
                           		endcase
                           		temp=temp & zero_half_mask;

                          		if (temp[16]==1)
                           			mdr_out=temp | one_half_mask;
                           		else
                           			mdr_out=temp;
                           	end
                          	
                          	 //LHU
				6'b100101:
				begin
					temp=data_mem[alu_data_in[0:29]];
					case (alu_data_in[30])
						1'b0:temp=temp>>16;      
                                                1'b1:temp=temp;
                           		endcase
                           		mdr_out=temp & zero_half_mask;	
                          	end

				//LW
				6'b100011:
				begin
					temp=data_mem[alu_data_in[0:29]];
					mdr_out=temp;
				end
                                
                                //SB
				6'b101000:
				begin
					temp=data_mem[alu_data_in[0:29]];
                                                case (alu_data_in[30:31])
                                                2'b00:temp[0:7]=mdr_in[24:31];      
                                                2'b01:temp[8:15]=mdr_in[24:31];
                                                2'b10:temp[16:23]=mdr_in[24:31];
                                                2'b11:temp[24:31]=mdr_in[24:31];
                           			endcase
                                  	data_mem[alu_data_in[0:29]]=temp;
                                  	temp_stall=1;		//don't write reg
                            	end
                            	                          	
                          	 //SH
				6'b101001:
				begin 
					temp=data_mem[alu_data_in[0:29]]; 
						case (alu_data_in[30])
						1'b0:temp[0:15]=mdr_in[16:31];
                                                1'b1:temp[16:31]=mdr_in[16:31];
                                                endcase
                                       	data_mem[alu_data_in[0:29]]=temp;
                                       	temp_stall=1;
                              	end
                              	
				//SW
				6'b101011:
				begin
					data_mem[alu_data_in[0:29]]=mdr_in[0:31];
					temp_stall=1;
				end
                                
                                //BEQZ or BNEZ
				6'b00010x:
				begin
					temp_stall=1;
					if(cond)
					begin
						pc=alu_data_in;
						temp_pc_pulse=1;
					end
				end
				default mdr_out=alu_data_in;
				endcase
			end				//if not stall
			
			stall_out=temp_stall;
			pc_pulse=temp_pc_pulse;
		end					//always
	endmodule
