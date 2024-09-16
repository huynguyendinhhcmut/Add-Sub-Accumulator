module fullAdderNb #(parameter Width = 8) 
(
	input wire [Width-1:0] a,
	input wire [Width-1:0] b,
	input wire cin,
	output wire [Width-1:0] sum,
	output wire cout, V 
);

wire [Width-1:0] carry;

genvar i;
generate
	for (i = 0; i < Width; i = i + 1) begin
		if (i == 0) begin
			fullAdder fa0 (.sum(sum[i]), .a(a[i]), .b(b[i] ^ cin), .cin(cin), .cout(carry[i]));
		end else if (i == Width-1) begin
			fullAdder fa1 (.sum(sum[i]), .a(a[i]), .b(b[i] ^ cin), .cin(carry[i-1]), .cout(cout));
		end else begin
			fullAdder fa2 (.sum(sum[i]), .a(a[i]), .b(b[i] ^ cin), .cin(carry[i-1]), .cout(carry[i]));
		end
	end
endgenerate

xor (V, cout, carry[Width-2]);

endmodule
