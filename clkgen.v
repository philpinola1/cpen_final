	module clkgen(clock);
	
		output clock;
		
		reg clock;
		
		initial
		begin
			clock=0;
			forever
				#25 clock=~clock;
		end
	endmodule
