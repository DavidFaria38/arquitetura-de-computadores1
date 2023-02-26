/* 
    Guia_0204.v
    
    699415 - David de Sá Vieira de Faria

    - Converter valor base binaria para base 4, base 8 e base 16, 
        considerarando partes fracionarias.
    - Como rodar passando valores por parametro:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp +arg0=VALOR_DO_ARG 
*/

module Guia_0204;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0204";
    integer arg0;
    reg[7:0] arg1;
    reg[7:0] arg2;

    // define program data 
    integer i;
    integer base;
    reg [7:0] bin_num;
    reg [7:0] bin_num_frac;


    initial begin
        
        // Buscar valor do parametro se possuir um.
        if ($value$plusargs("arg0=%d", arg0)) begin
            base = arg0;
        end
        // se base for binaria, pegar valores dos parametros como binario
        if (base == 2) begin
            if ($value$plusargs("arg1=%b", arg1)) begin
                bin_num = arg1;
            end
            if ($value$plusargs("arg2=%b", arg2)) begin
                bin_num_frac = arg2;
            end
        end
        // se base for quaternario ou octal, pegar valores dos parametros como octal
        if (base == 4 || base == 8) begin
            if ($value$plusargs("arg1=%o", arg1)) begin
                bin_num = arg1;
            end
            if ($value$plusargs("arg2=%o", arg2)) begin
                bin_num_frac = arg2;
            end
        end
        // se base for hexadecimal, pegar valores dos parametros como hexadecimal
        if (base == 16) begin
            if ($value$plusargs("arg1=%x", arg1)) begin
                bin_num = arg1;
            end
            if ($value$plusargs("arg2=%x", arg2)) begin
                bin_num_frac = arg2;
            end
        end


        $display("%s - test", nameProgram);

        if (base == 2) begin
            $display ( "a = %b.%b -> (2) => %0o%0o%0o.%0o%0o%0o (4)",   bin_num, bin_num_frac,
                                                                        bin_num[7:6], bin_num[5:3], bin_num[2:0],
                                                                        bin_num_frac[7:6], bin_num_frac[5:3], bin_num_frac[2:0]);
        end
        if (base == 4) begin
            $display("a = %0o%0o%0o.%0o%0o%0o (4) => %b.%b (2)",    bin_num[7:6], bin_num[5:3], bin_num[2:0],
                                                                    bin_num_frac[7:6], bin_num_frac[5:3], bin_num_frac[2:0],
                                                                    bin_num, bin_num_frac);
        end
        if (base == 8) begin
            $display("a = %0o.%0o (8) => %b.%b (2) => %0o%0o%0o.%0o%0o%0o (4)", bin_num, bin_num_frac,
                                                                                bin_num, bin_num_frac,
                                                                                bin_num[7:6], bin_num[5:3], bin_num[2:0],
                                                                                bin_num_frac[7:6], bin_num_frac[5:3], bin_num_frac[2:0]);
        end
        if (base == 16) begin
            $display("a = %0x.%0x (16) => %b.%b (2) => %0o%0o%0o.%0o%0o%0o (4)",    bin_num, bin_num_frac,
                                                                                    bin_num, bin_num_frac,
                                                                                    bin_num[7:6], bin_num[5:3], bin_num[2:0],
                                                                                    bin_num_frac[7:6], bin_num_frac[5:3], bin_num_frac[2:0]);
        end

    end
endmodule