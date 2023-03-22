Verilog HDL code:
- MINIMUM number of the follwing components: Full-adders, 4x1 Multiplexers, 2x1 Multiplexers, or, and, not, xor gates.
- A full-adder counts only as 1 component, not counting the small components inside. Also, a multiplexer counts as 1 component.
- The input is two selection inputs, and two signed integers in 2's complement form: A and B, each integer is 3-bits.
- The output is a signed integer in 2's complement from: G, its size is 3-bits.
1) When the selection inputs are 00, G = A-1
2) When the selection inputs are 01, G = A+B
3) When the selection inputs are 10, G = A-B
4) When the selection inputs are 11, G = -B
- test bench that tests all aspects of the implemented circuit with at least 40 test cases on various input values.
- not allowed to use behavioral Verilog descriptions (if, switch, ..etc) for multiplexers or any other aspects except for test bench.
- Use structured Verilog descriptions for all aspects, except for the test bench, so you can use behavioral Verilog descriptions for the test bench only.