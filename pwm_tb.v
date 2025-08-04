module pwm_tb ();
parameter WIDTH = 8;
parameter TIMER_WIDTH = 15;
reg clk, rst_n;
reg [WIDTH:0] duty;
reg [TIMER_WIDTH-1:0] timer_final_value;
wire pwm_out;

pwm #(.WIDTH(WIDTH), .TIMER_WIDTH(TIMER_WIDTH)) DUT (clk, rst_n, duty, timer_final_value, pwm_out);

initial begin
	clk = 0;
	forever 
		#1 clk = ~clk; 
end

initial begin
	rst_n = 1;
	@(negedge clk);
	rst_n = 0;
	repeat (2 * 255 * 2) @(negedge clk);
	rst_n = 1;

	// Counter frequency = clk frequency
	timer_final_value = 1;

	duty = 128;
	repeat (2 * 255 * 2) @(negedge clk);

	duty = 64;
	repeat (2 * 255 * 2) @(negedge clk);

	duty = 192;
	repeat (2 * 255 * 2) @(negedge clk);

	duty = 0;
	repeat (2 * 255 * 2) @(negedge clk);

	duty = 256;
	repeat (2 * 255 * 2) @(negedge clk);

	// counter frequency = clk frequency / 10
	timer_final_value = 10;

	duty = 128;
	repeat (2 * 255 * 20) @(negedge clk);

	duty = 64;
	repeat (2 * 255 * 20) @(negedge clk);

	duty = 192;
	repeat (2 * 255 * 20) @(negedge clk);

	duty = 0;
	repeat (2 * 255 * 20) @(negedge clk);

	duty = 256;
	repeat (2 * 255 * 20) @(negedge clk);

	$stop;
end
endmodule 