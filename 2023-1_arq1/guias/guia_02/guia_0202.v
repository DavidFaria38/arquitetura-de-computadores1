/* 
    Guia_0202.v
    
    699415 - David de Sá Vieira de Faria

    - Converter valor base decimal para base bianrio, 
        considerarando partes fracionarias.
    - Como rodar passando valores por parametro:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp +arg0=VALOR_DO_ARG 
*/

module Guia_0202;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0202";
    real arg0;

    // define program data 
    integer i               = 7; // iterador
    real    dec_num         = 0; // parte inteira do numero
    real    dec_num_frac    = 0.0; // parte fracionaria do numero

    reg[7:0] bi_num         = 8'b0000_0000; // parte binaria inteira do numero
    reg[7:0] bi_num_frac    = 8'b0000_0000; // parte binaria fracionaria do numero

    initial begin
        
        // Buscar valor do parametro se possuir um.
        if ($value$plusargs("arg0=%f", arg0)) begin
            dec_num = arg0; 
        end 

        $display("%s - test", nameProgram);
        $display("num = %f (10)", dec_num);


        if (dec_num > 0) begin
            // convercao parte inteira
            bi_num = $rtoi(dec_num);
            // armazenamento parte fracionaria
            dec_num_frac = dec_num - $rtoi(dec_num);
        end else begin
            // convercao parte inteira
            bi_num = 0;
            // armazenamento parte fracionaria
            dec_num_frac = dec_num;
        end
        
        // convercao parte fracionaria
        while ( dec_num_frac > 0 && i >= 0) begin

            if ( dec_num_frac * 2 >= 1 ) begin
                bi_num_frac[i] = 1;
                dec_num_frac = (dec_num_frac * 2.0) - 1.0;
            end else begin
                bi_num_frac[i] = 0;
                dec_num_frac = (dec_num_frac * 2.0);
            end

            i = i - 1; // iterador
        end

        $display("bin = %b.%b (2)", bi_num, bi_num_frac);
    end
endmodule