module pwm #(parameter WIDTH = 8, parameter TIMER_WIDTH = 15) (
	input clk,
	input rst_n,
	input [WIDTH:0] duty,
	input [TIMER_WIDTH-1:0] timer_final_value,
	output pwm_out
	);

reg [WIDTH-1:0] counter;
wire timer_done;
reg pwm_out_reg;

timer #(TIMER_WIDTH) timer1 (clk, rst_n, timer_final_value, timer_done);

assign pwm_out = pwm_out_reg;

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		// reset
		counter <= 0;
		pwm_out_reg <= 0;
	end
	else if (timer_done) begin
		counter <= counter + 1;
		pwm_out_reg <= (counter < duty);
	end
end
endmodule