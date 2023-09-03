module top_module (input x, input y, output z);
wire a1z,a2z,b1z,b2z;
    a1 u_a1(.x(x),.y(y),.z(a1z));
    a1 u_a2(.x(x),.y(y),.z(a2z));
    b1 u_b1(.x(x),.y(y),.z(b1z));
    b1 u_b2(.x(x),.y(y),.z(b2z));
    assign z = (a1z|b1z)^(a2z&b2z);
endmodule

module a1 (input x, input y, output z);
    assign z = (x^y) & x;
endmodule

module b1 ( input x, input y, output z );
assign z = x^~y;
endmodule