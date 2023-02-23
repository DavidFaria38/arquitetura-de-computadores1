/* 
    Guia_0204.v

    - Converter valor base binaria para base 4, base 8 e base 16, 
        considerarando partes fracionarias.
    - Como rodar passando valores por parametro:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp +arg0=VALOR_DO_ARG 
*/

module Guia_0204;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0204";
    reg[7:0] arg0;
    reg[7:0] arg1;
    integer arg2;

    // define program data 
    integer i = 7;
    real num = 0;
    real power2 = 1.0;
    reg[7:0] bi_num = 8'b0000_0000; // parte inteira do numero
    reg[7:0] bi_num_frac = 8'b0000_0000; // parte fracionaria do numero

    real x = 0.625;
    // decimal
    reg [7:0] b = 8'b1010_0000 ; // binary
    integer q [3:0];

    initial begin
        
        // Buscar valor do parametro se possuir um.
        if ($value$plusargs("arg0=%b", arg0)) begin
            bi_num = arg0; 
        end 
        if ($value$plusargs("arg1=%b", arg1)) begin
            bi_num_frac = arg1; 
        end 

        $display("%s - test", nameProgram);

        $display ( "x = %f" , x );
        $display ( "b = 0.%8b", b );
        $display ( "b = 0.%x%x (16)", b[7:4],b[3:0] );
        q[3] = b[7:6];
        q[2] = b[5:4];
        q[1] = b[3:2];
        q[0] = b[1:0];
        $display ( "b = 0.%2b %2b %2b %2b (2)", b[7:6],b[5:4],b[3:2],b[1:0] );
        $display ( "q = 0.%2d %2d %2d %2d (4)", q[3] ,q[2] ,q[1] ,q[0] );
    end
endmodule