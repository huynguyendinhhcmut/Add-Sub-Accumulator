module accumulator #(parameter Width = 8)
(
	input clk, rst, 
	input wire cin,
	input wire [Width-1:0] A,
	output reg overflow, carry,
	output reg [Width-1:0] sum
);

reg [Width-1:0] post_A;
wire [Width-1:0] pre_sum;
wire V, cout;

always @(posedge clk or negedge rst) begin
	if (rst == 0)
		post_A <= 0;
	else
		post_A <= A;
end

always @(posedge clk or negedge rst) begin
	if (rst == 0) 
		sum <= 0;
	else
		sum <= pre_sum;
end

fullAdderNb #(.Width(Width)) FANb (.sum(pre_sum), .a(sum), .b(post_A), .cin(cin), .cout(cout), .V(V));

always @(posedge clk or negedge rst) begin
	if (rst == 0) 
		overflow <= 0;
	else
		overflow <= V;
end

always @(posedge clk or negedge rst) begin
	if (rst == 0)
		carry <= 0;
	else 
		carry <= cout;
end

endmodule
