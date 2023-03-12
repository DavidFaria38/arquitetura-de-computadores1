/* 
    
    Guia_0607.v
    Nome: David de Sá Vieira de Faria
    Matricula: 699415

    - Dada a expressão em Verilog abaixo, verificar se há simplificação e montar o circuito equivalente:
        module FXYZ (output S1, input X, input Y, input Z);
            assign s1 = ( X | ~Y | ~Z ) & (~X | Y | ~Z) & ( ~X | ~Y | Z );
        endmodule // FXYZ

    - OBS.
            Dado o mapa de VK, uma outra formula foi encontrada para a expressao acima,
        porem a nova expressao possui mais manipulacoes de bits.
        Ela pode ser considerada que foi simplificada?
*/

/*
    Tabela verdade para seguinte expressao:
    expressao:  (x|~y|~z) & (~x|y|~z) & (~x|~y|z)
    Tabela verdade: 
    # x y z s                               
    0 0 0 0 1     x\yz 00 01 11 10                          
    1 0 0 1 1        0  1  1  0  1       
    2 0 1 0 1        1  1  0  1  0         
    3 0 1 1 0                               
    4 1 0 0 1     SoP MINTERMOS(0,1,2,4,7)
    5 1 0 1 0     Conjuntos: (0,1),(0,2),(0,4),(7)                         
    6 1 1 0 0     Exp.Simp.: x'y' + x'z' + y'z' + xyz                                                   
    7 1 1 1 1                (~x&~y)|(~x&~z)|(~y&~z)|(x&y&z)
*/

/* expressao nao simplificada - por extenso */
module FXYZ (
        output s1, 
        input x, 
        input y, 
        input z);
    assign s1 = (x|~y|~z)&(~x|y|~z)&(~x|~y|z);
endmodule // FXYZ

/* expressao simplificada - por extenso */
module FXYZ_simplificada (
        output s1, 
        input x, 
        input y, 
        input z);
    assign s1 = (~x&~y)|(~x&~z)|(~y&~z)|(x&y&z);
endmodule // FXYZ_simplificada

module Guia_0607;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0607";

    // define program data 
    reg x, y, z;
    wire a, b;
    
    FXYZ expressao_nao_simplificada_A(a, x, y, z); // expressao original formula
    FXYZ_simplificada expressao_simplificada_B(b, x, y, z); // expressao simplificada formula

    initial begin
        
        $display("%s - test", nameProgram);

        $display("x\ty\tz\ta\tb\t");
        $monitor("%1b\t%1b\t%1b\t%1b\t%1b\t", x, y, z, a, b);

        x=1'b0; y=1'b0; z=1'b0; #1
        x=1'b0; y=1'b0; z=1'b1; #1
        x=1'b0; y=1'b1; z=1'b0; #1
        x=1'b0; y=1'b1; z=1'b1; #1
        x=1'b1; y=1'b0; z=1'b0; #1
        x=1'b1; y=1'b0; z=1'b1; #1
        x=1'b1; y=1'b1; z=1'b0; #1
        x=1'b1; y=1'b1; z=1'b1;
    end
endmodule