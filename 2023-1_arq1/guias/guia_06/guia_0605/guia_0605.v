/* 
    
    Guia_0605.v
    Nome: David de Sá Vieira de Faria
    Matricula: 699415

    - Como rodar:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp
*/

/*
    Tabela verdade para seguinte expressao:
    expressao:  ((x'+y')'.(x.y)')+((y.z)+x')'
                (~(~x|~y)&~(x&y))|~((y&z)|~x)
    Tabela verdade: 
    # x y z s                               
    0 0 0 0 0     x\yz 00 01 11 10                          
    1 0 0 1 0        0  0  0  0  0              
    2 0 1 0 0        1  1  1  0  1               
    3 0 1 1 0                               
    4 1 0 0 1     SoP
    5 1 0 1 1     Conjuntos: (4,5),(6,4)                         
    6 1 1 0 1     Exp.Simp.: xy' + xz'                                                   
    7 1 1 1 0                (x&~y)|(x&~z)          
*/

/* expressao nao otimizada - por extenso */
module expresao_aa (
            output s, 
            input x,
            input y,
            input z);
    assign s = (~(~x|~y)&~(x&y))|~((y&z)|~x);
endmodule

/* expressao nao otimizada - por blocos logicos */
module expresao_ab (
            output s, 
            input x,
            input y,
            input z);
    wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11;

    or  (s, w1, w2);
    and (w1, w3, w4);
    not (w3, w5);
    or  (w5, w8, w9);
    not (w8, y);
    not (w9, x);
    not (w4, w6);
    and (w6, x, y);
    not (w2, w7);
    or  (w7, w10, w11);
    and (w10, y, z);
    not (w11, x);
endmodule

/* expressao otimizada - por extenso */
module expresao_ba (
            output s, 
            input x,
            input y,
            input z);
    assign s = (x&~y)|(x&~z);
endmodule

/* expressao otimizada - por blocos logicos */
module expresao_bb (
            output s, 
            input x,
            input y,
            input z);
    wire w1, w2, w3, w4;

    or  (s, w1, w2);
    and (w1, x, w3);
    not (w3, y);
    and (w2, x, w4);
    not (w4, z);
endmodule

module Guia_0605;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0605";

    // define program data 
    reg x, y, z;
    wire aa, ab, ba, bb;
    
    expresao_aa expressao_nao_simplificada_A(aa, x, y, z); // expressao original formula
    expresao_ab expressao_nao_simplificada_B(ab, x, y, z); // expressao original gates
    expresao_ba expressao_simplificada_A(ba, x, y, z);     // expressao simplificada formula
    expresao_bb expressao_simplificada_B(bb, x, y, z);     // expressao simplificada gates

    initial begin
        
        $display("%s - test", nameProgram);

        $display("x\ty\tz\taa\tab\tba\tbb\t");
        $monitor("%1b\t%1b\t%1b\t%1b\t%1b\t%1b\t%1b\t", x, y, z, aa, ab, ba, bb);

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