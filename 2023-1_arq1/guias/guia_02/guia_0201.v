/* 
    Guia_0201.v

    - Converter valor base binaria para base decimal, 
        considerarando partes fracionarias.
    - Como rodar passando valores por parametro:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp +arg0=VALOR_DO_ARG 
*/

module Guia_0201;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0201";
    reg[7:0] arg0;
    reg[7:0] arg1;

    // define program data 
    integer i = 7;
    real num = 0;
    real power2 = 1.0;
    reg[7:0] bi_num = 8'b0000_0000; // parte inteira do numero
    reg[7:0] bi_num_frac = 8'b0000_0000; // parte fracionaria do numero

    initial begin
        
        // Buscar valor do parametro se possuir um.
        if ($value$plusargs("arg0=%b", arg0)) begin
            bi_num = arg0; 
        end 
        if ($value$plusargs("arg1=%b", arg1)) begin
            bi_num_frac = arg1; 
        end 

        $display("%s - test", nameProgram);

        // convercao parte inteira
        num = bi_num;

        // convercao parte fracionaria
        while ( i >= 0) begin
            power2 = power2 / 2.0;
            if ( bi_num_frac[i] == 1 ) begin
                num = num + power2;
            end
            i = i - 1;
        end
        $display("bin = %b.%b (2)", bi_num, bi_num_frac);
        $display("num = %f (10)", num);
    end
endmodule