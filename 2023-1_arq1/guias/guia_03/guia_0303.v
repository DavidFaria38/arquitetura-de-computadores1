/* 
    Guia_0303.v

    - Determinar o valor positivo equivalente aos complementos de 2 indicados.
    - Como rodar passando valores por parametro:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp +arg0=VALOR_DO_ARG 
*/

module Guia_0303;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0303";
    reg[7:0] arg0;

    // define program data 
    integer  dec_num = 'd0;
    reg[7:0] bin_num;
    reg[7:0] bin_num_C1;
    reg[7:0] bin_num_C2;
    reg[7:0] bin_num_C2_show;

    initial begin
        
        // Buscar valor do parametro se possuir um.
        if ($value$plusargs("arg0=%b", arg0)) begin
            bin_num_C2 = arg0; 
            bin_num_C2_show = arg0;
        end

        $display("%s - test", nameProgram);
        
        //                                                                      Bit representando o sinal
        //                                                                      |
        // inverter todos os ZEROS depois do bit representante do sinal; ex: 0001_0100 -> 1111_0100
        for (integer i = 7; i>=0; i=i-1) begin
            if (bin_num_C2[i] == 1) begin
                i = 0; // parar loop
            end else begin
                bin_num_C2[i] = 1;
            end
        end

        bin_num_C1 = bin_num_C2 - 1;
        bin_num = ~bin_num_C1;
        dec_num = bin_num;
        $display( "a = %b (2) -> C1(a) = %b (2) -> result = %b (2) = %0d (10)", bin_num_C2_show, bin_num_C1, bin_num, dec_num);
    end
endmodule