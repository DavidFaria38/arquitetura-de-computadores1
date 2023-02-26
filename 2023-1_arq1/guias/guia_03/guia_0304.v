/* 
    Guia_0304.v
    
    699415 - David de Sá Vieira de Faria

    - Realizar as opecoes indicadas mediante uso de complemento de dois.
    - Como rodar passando valores por parametro:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp +arg0=VALOR_DO_ARG 

    obs: caso o subtraendo seja maior que o minuendo, acontecera overflow.
*/


module Guia_0304;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0304";
    integer arg0;
    reg[15:0] arg1;
    reg[15:0] arg2;


    // define program data 
    integer i;
    integer base;
    reg [15:0] x_bin_num;
    reg [15:0] y_bin_num;
    reg [15:0] y_bin_num_show;
    reg[15:0] result;


    initial begin
        
        // Buscar valor do parametro se possuir um.
        if ($value$plusargs("arg0=%d", arg0)) begin
            base = arg0;
        end
        // se base for binaria, pegar valores dos parametros como binario
        if (base == 2) begin
            if ($value$plusargs("arg1=%b", arg1)) begin
                x_bin_num = arg1;
            end
            if ($value$plusargs("arg2=%b", arg2)) begin
                y_bin_num = arg2;
            end
        end
        // se base for quaternario ou octal, pegar valores dos parametros como octal
        if (base == 4 || base == 8) begin
            if ($value$plusargs("arg1=%o", arg1)) begin
                x_bin_num = arg1;
            end
            if ($value$plusargs("arg2=%o", arg2)) begin
                y_bin_num = arg2;
            end
        end
        // se base for hexadecimal, pegar valores dos parametros como hexadecimal
        if (base == 16) begin
            if ($value$plusargs("arg1=%x", arg1)) begin
                x_bin_num = arg1;
            end
            if ($value$plusargs("arg2=%x", arg2)) begin
                y_bin_num = arg2;
            end
        end



        $display("%s - test", nameProgram);

        y_bin_num_show = y_bin_num;

        y_bin_num = ~y_bin_num;
        y_bin_num = y_bin_num + 1;

        result = x_bin_num + y_bin_num;
        
        $display("%b( 2) - %b ( 2) = %b ( 2)", x_bin_num, y_bin_num_show, result);
        $display("%0o%0o%0o%0o( 4) - %0o%0o%0o%0o ( 4) = %0o%0o%0o%0o ( 4)", 
                                                x_bin_num[7:6], x_bin_num[5:4], x_bin_num[3:2], x_bin_num[1:0], 
                                                y_bin_num_show[7:6], y_bin_num_show[5:4], y_bin_num_show[3:2], y_bin_num_show[1:0], 
                                                result[7:6], result[5:4], result[3:2], result[1:0]);
        $display("%4o( 8) - %4o ( 8) = %4o ( 8)", x_bin_num, y_bin_num_show, result);
        $display("%4x(16) - %4x (16) = %4x (16)", x_bin_num, y_bin_num_show, result);
        $display("%4d(10) - %4d (10) = %4d (10)", x_bin_num, y_bin_num_show, result);
        // $display("%b.%b (%0d)- %b.%b (%0d)", x_bin_num, x_bin_num_frac, base, y_bin_num, y_bin_num_frac, base);
        // $display( "a = %b (2) -> C1(a) = %b (2) -> result = %b (2) = %0d (10)", bin_num_C2_show, bin_num_C1, bin_num, dec_num);
    end
endmodule