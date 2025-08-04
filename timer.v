module timer #(parameter WIDTH = 8) (
	input clk,
	input rst_n,
	input [WIDTH-1:0] final_value,
	output reg done);

reg [WIDTH-1:0] count;

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		// reset
		count <= 0;
		done <= 0;
	end
	else begin
		if (count < final_value) begin
			count <= count + 1;
			done <= 0;
		end
		else begin
			done <= 1;
			count <= 0;
		end
	end
end
endmodule