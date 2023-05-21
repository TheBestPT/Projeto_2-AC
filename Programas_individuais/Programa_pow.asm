/**
 * INSTITUTO POLITÉCNICO DE BEJA
 * ESCOLA SUPERIOR DE TECNOLOGIA E GESTÃO
 * ENGENHARIA INFORMÁTICA
 * JOSÉ FRANCISCO - 22896
 * PATRÍCIA BERENGUER - 22893
 */

@Data Section
.data
.align 4
    pow_base_print: .asciz "Insert (x) value for base of pow(x): "
.align 4
    pow_expon_print: .asciz "Insert (x) value for exponent of pow(y): "
.align 4
    pow_base: .fill 3, 4, 0
.align 4
    pow_exponent: .fill 3, 4, 0
.balign 4 
    scanfp: .asciz "%f"
.align 4
    resultado: .asciz "O resultado é: %f\n"
.align 4
    zero: .single 0.0
.align 4
    one: .single 1.0
.align 4
    two: .single 2.0
.align 4
    lnlimit: .single 1000.0
.align 4
    limit: .single 1e-5

@External C functions
.global scanf
.global printf

@Code Section
.Section .text
.global main
.arch armv8-a
.arm

main:
PUSH {LR}
    LDR R0, =pow_base_print
    BL printf

    LDR R1, =pow_base
    LDR R0, =scanfp
    BL scanf

    LDR R0, =pow_expon_print
    BL printf

    LDR R1, =pow_exponent
    LDR R0, =scanfp
    BL scanf

    LDR R1, =pow_base
    VLDR S0, [R1]

    LDR R1, =pow_exponent
    VLDR S1, [R1]

    BL _pow

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {LR}
BX LR

/* POW - e o mesmo que o powint mas com a diferença que esta preparado para expoentes decimais
    Parametros:
    S0 - base 
    S1 - expoente
    Return:
    S0 - pow
 */
/* Algoritmo encontrado para calcular o expoente
    Math.Exp(expoente * Math.Log(base))
 */
_pow:
    PUSH {LR}
    VPUSH.F32 {S1-S4}
    BL   _ln
    VPOP.F32 {S1-S4}
  

    VMUL.F32 S4, S0, S1
    VMOV.F32 S0, S4

    VPUSH.F32 {S1-S4}
    BL   _exp
    VPOP.F32 {S1-S4}
    POP  {LR}
BX LR

/* LN - usado para calcular a inversa da expoencial
    Parametros:
    S0 - numero
    Return:
    S0 - ln

 */
/* Algoritmo encontrado para calcular o ln
    function calculateLnx(n){
        let num, mul, cal, sum = 0;
        num = (n - 1) / (n + 1);
    
        // Terminating value of the loop
        // can be increased to improve the precision
        for(let i = 1; i <= 1000; i++)
        {
            mul = (2 * i) - 1;
            cal = Math.pow(num, mul);
            cal = cal / mul;
            sum = sum + cal;
        }
        sum = 2 * sum;
        return sum;
    }
 */
_ln:
    PUSH {LR}
    VPUSH.F32 {S1-S13}

    @Incrementador
    LDR R1, =one
    VLDR S4, [R1]

    @num
    LDR R1, =zero
    VLDR S5, [R1]

    @mul
    LDR R1, =zero
    VLDR S6, [R1]

    @cal
    LDR R1, =zero
    VLDR S7, [R1]

    @sum
    LDR R1, =zero
    VLDR S8, [R1]

    @limit
    LDR R1, =lnlimit
    VLDR S9, [R1]


    @two
    LDR R1, =two
    VLDR S10, [R1]

    @one
    LDR R1, =one
    VLDR S11, [R1]

    VSUB.F32 S12, S0, S11
    VADD.F32 S13, S0, S11
    VDIV.F32 S5, S12, S13

    ln_loop:
        @first step mul = (2 * i)
        VMUL.F32 S6, S4, S10
        @ mul = (2 * i) - 1
        VSUB.F32 S6, S11
        @end first setp

        @Second step Math.pow(num, mul)
        @PERSERVE N
        VMOV.F32 S2, S0

        VMOV.F32 S0, S5
        VMOV.F32 S1, S6

        BL _powInt2
        @End first

        @Third step cal = cal / mul
        VMOV.F32 S7, S0
        VDIV.F32 S7, S7, S6
        @End third

        @Fourth step sum = sum + cal
        VADD.F32 S8, S7
        @end fourth step

        VADD.F32 S4, S11
        VCMP.F32 S4, S9
        VMRS APSR_nzcv, FPSCR
    BLE ln_loop
    VMUL.F32 S8, S10
    VMOV.F32 S0, S8
    //VMOV.F32 S0, S6
    VPOP.F32 {S1-S13}
    POP {LR}
BX LR

/* POWINT - função auxiliar para calculer potencias de forma mais precisa (Só funciona com expoentes inteiros)
    Parametros:
    S0 - base do expoente
    S1 - expoente
    Retrun:
    S0 - pow
 */
_powInt2:
    PUSH {LR}
    VPUSH.F32 {S1-S4}
    LDR  R2, =one
    VLDR S2, [R2]
    LDR R2, =zero
    VLDR S4, [R2]
    //MOV R1, #0
    /*CMP R0, #0
    CMP R0, #2
    SUBGE R0, #1*/
    @VERIFY IF ITS 1
    VCMP.F32 S1, S2
    VMRS APSR_nzcv, FPSCR
    BEQ end_powint2
    @VERIFY IF IS 0
    VCMP.F32 S1, S4
    VMRS APSR_nzcv, FPSCR
    //VMOVEQ.F32 S0, S2
    BEQ end_powint2_zero
    VSUB.F32 S1, S2
    VMOV.F32 S3, S0
    powInt2_loop:
        VMUL.F32 S3, S3, S0
        //ADD R1, #1                
        VADD.F32 S4, S2
        //CMP R1, R0 
        VCMP.F32 S4, S1
        VMRS APSR_nzcv, FPSCR
    BNE powInt2_loop
    VMOV.F32 S0, S3
    end_powint2_zero:
        VADD.F32 S1, S2
        VCMP.F32 S1, S4
        VMRS APSR_nzcv, FPSCR
        BNE end_powint2
        VMOVEQ.F32 S0, S1
        VPOP.F32 {S1-S4}
        POP {LR}
        BX LR

    end_powint2:
    VPOP.F32 {S1-S4}
    POP {LR}
BX LR

/* EXP - calcula o exponencial do numero dado
    Parametros:
    S0 - numero (expoente para o e)
    Retrun:
    S0 - exponencial 
 */
/* Fórmula usada para caculas
    Somatorio( x^2 / 2! + x^3 / 3! ....... )
 */
_exp:
    PUSH {LR}
    VPUSH.F32 {S1-S13}
    LDR R1, =one
    VLDR S1, [R1]

    LDR R1, =zero
    VLDR S11, [R1]

    LDR R1, =two
    VLDR S12, [R1]

    LDR R1, =limit
    VLDR S8, [R1]
    
    VMOV.F32 S4, S0
  
    LDR R1, =zero
    VLDR S9, [R1]
    
    exp_loop:
        VCMP.F32 S9, S11
        VMRS APSR_nzcv, FPSCR
        VADDEQ.F32 S3, S1
        VADDEQ.F32 S9, S1
        BEQ exp_loop

        VCMP.F32 S9, S1
        VMRS APSR_nzcv, FPSCR
        VADDEQ.F32 S3, S4
        VADDEQ.F32 S9, S1
        BEQ exp_loop

        
        VMOV.F32 S10, S11
        VMOV.F32 S5, S1
        exp_pow_loop:
            VMUL.F32 S5, S4

            VSUB.F32 S13, S9, S1
            
            VCMP.F32 S10, S13
            VMRS APSR_nzcv, FPSCR
            VADD.F32 S10, S1
        BLT exp_pow_loop

        LDR R1, =one
        VLDR S1, [R1]

        VMOV.F32 S0, S9  @ S0 = i, i!
        BL _fatorial

        VMOV.F32 S6, S0@FATORIAL
        VDIV.F32 S7, S5, S6

        VADD.F32 S3, S7 @ out
    
        VADD.F32 S9, S1
        VCMP.F32 S7, S8
        VMRS APSR_nzcv, FPSCR


    BGE exp_loop

    VMOV.F32 S0, S3
    VPOP.F32 {S1-S13}
    POP {LR}
BX LR

/* Fatorial - calcula o fatorial de um numero
    Parametros:
    S0 - numero
    Return:
    S0 - fatorial
 */
_fatorial:
    PUSH {LR}
    VPUSH.F32 {S1-S5}
    LDR  R0, =zero
    VLDR S1, [R0]                  
    VLDR S4, [R0]                  
    LDR  R0, =one
    VLDR S2, [R0]                  

    VCMP.F32 S0, S1
    VMRS APSR_nzcv, FPSCR
    VMOVEQ.F32 S0, S2
    @Compare with 1
    VCMP.F32 S0, S2
    VMRS APSR_nzcv, FPSCR
    VMOVEQ.F32 S0, S2

    factorial_loop:
        @S3 = I
        VMOV.F32 S3, S1          
        @ Create copy from S3 to S5. S5 - out.
        VMOV.F32 S5, S3              
        @ S3 -= 1.0
        VSUB.F32 S3, S2              
        factorial_loop_2:
            @ S5 *= S3
            VMUL.F32 S5, S3            
            @ S3 -= 1.0  / i--
            VSUB.F32 S3, S2            
            @ S3 > 0
            VCMP.F32 S3, S4            
            VMRS APSR_nzcv, FPSCR
        BGT factorial_loop_2
        VCMP.F32 S1, S0              
        VADD.F32 S1, S2              
        VMRS APSR_nzcv, FPSCR
    BLT factorial_loop
        VCMP.F32 S0, S2
        VMRS APSR_nzcv, FPSCR
        VMOVNE.F32 S0, S5
        VPOP.F32 {S1-S5}
        POP {LR}
BX LR
