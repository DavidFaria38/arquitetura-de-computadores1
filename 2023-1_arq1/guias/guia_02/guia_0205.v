/* 
    Guia_0205.v

    - Realize as operacoes aritméticas em bianrio 
        considerarando partes fracionarias.
    - Como rodar passando valores por parametro:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp +arg0=VALOR_DO_ARG 
*/

module Guia_0205;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0205";
    reg[7:0] arg0;
    reg[7:0] arg1;
    reg[7:0] arg2;
    reg[7:0] arg3;

    // define program data 
    reg[7:0] x_bin = 8'b0000_0000; // parte inteira do numero
    reg[7:0] x_bin_frac = 8'b0000_0000; // parte fracionaria do numero
    reg[7:0] y_bin = 8'b0000_0000; // parte inteira do numero
    reg[7:0] y_bin_frac = 8'b0000_0000; // parte fracionaria do numero

    reg[15:0] x;
    reg[15:0] y;
    reg[15:0] result_bin;

    initial begin
        
        // Buscar valor do parametro se possuir um.
        if ($value$plusargs("arg0=%b", arg0)) begin
            x_bin = arg0; 
        end 
        if ($value$plusargs("arg1=%b", arg1)) begin
            x_bin_frac = arg1; 
        end 
        if ($value$plusargs("arg2=%b", arg2)) begin
            y_bin = arg2; 
        end 
        if ($value$plusargs("arg3=%b", arg3)) begin
            y_bin_frac = arg3; 
        end 

        $display("%s - test", nameProgram);

        x = {x_bin, x_bin_frac}; // concatenar duas varaiveis em uma
        y = {y_bin, y_bin_frac}; 

        result_bin = x + y;
        $display( "%b.%b (2) + %b.%b (2) = %b.%b (2)", x_bin, x_bin_frac, y_bin, y_bin_frac, result_bin[15:8], result_bin[7:0] );

        result_bin = x - y;
        $display( "%b.%b (2) - %b.%b (2) = %b.%b (2)", x_bin, x_bin_frac, y_bin, y_bin_frac, result_bin[15:8], result_bin[7:0] );

        result_bin = x * y;
        $display( "%b.%b (2) * %b.%b (2) = %b.%b (2)", x_bin, x_bin_frac, y_bin, y_bin_frac, result_bin[15:8], result_bin[7:0] );

        result_bin = x / y;
        $display( "%b.%b (2) / %b.%b (2) = %b.%b (2)", x_bin, x_bin_frac, y_bin, y_bin_frac, result_bin[15:8], result_bin[7:0] );

        result_bin = x % y;
        $display( "%b.%b (2) mod %b.%b (2) = %b.%b (2)", x_bin, x_bin_frac, y_bin, y_bin_frac, result_bin[15:8], result_bin[7:0] );

    end
endmodule