/* 
    Guia_0302.v
    
    699415 - David de Sá Vieira de Faria

    - Determinar o complemento para os valores e as quantidades de bits indicada
    - Como rodar passando valores por parametro:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp +arg0=VALOR_DO_ARG 
*/

module Guia_0302;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0302";
    reg[7:0] arg0;
    reg[7:0] arg1;
    reg[7:0] arg2;
    reg[7:0] arg3;

    // define program data 
    reg[7:0] qua_num;
    reg[7:0] oct_num;
    reg[7:0] hex_num;
    reg[7:0] bin_num = 8'b0000_0000;
    reg[7:0] bin_num_C1;
    reg[7:0] bin_num_C2;

    initial begin
        
        // Buscar valor do parametro se possuir um.
        if ($value$plusargs("arg0=%o", arg0)) begin
            qua_num = arg0; 
        end
        if ($value$plusargs("arg1=%o", arg1)) begin
            oct_num = arg1; 
        end
        if ($value$plusargs("arg2=%x", arg2)) begin
            hex_num = arg2; 
        end
        if ($value$plusargs("arg3=%b", arg3)) begin
            bin_num = arg3; 
        end

        $display("%s - test", nameProgram);
        
        // selecioanar o valor dos parametros que nao for ZERO.
        if (qua_num != 0) begin
            // conversao val quaternario (base 8 na realidade) para binario
            bin_num[5:4] = qua_num[7:6];
            bin_num[3:2] = qua_num[5:3];
            bin_num[1:0] = qua_num[2:0];
            // $display("bin_num = %b | %8o | %b - %o", bin_num, qua_num, qua_num[7:6], qua_num[7:6]);
            // $display("bin_num = %b | %8o | %b - %o", bin_num, qua_num, qua_num[5:3], qua_num[5:3]);
            // $display("bin_num = %b | %8o | %b - %o", bin_num, qua_num, qua_num[2:0], qua_num[2:0]);
        end
        if (oct_num != 0) begin
            bin_num = oct_num;
        end
        if (hex_num != 0) begin
            bin_num = hex_num;
        end
        if (bin_num != 0) begin
            bin_num = bin_num;
        end

        bin_num_C1 = ~bin_num;
        bin_num_C2 = bin_num_C1 + 1;
        $display( "a = %b (2) -> C1(a) = %b (2) -> C2(a) %b (2)", bin_num, bin_num_C1, bin_num_C2);
    end
endmodule