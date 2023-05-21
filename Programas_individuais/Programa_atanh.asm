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
    atanh_print: .asciz "Insert (x) value for atanh(x): "
.balign 4 
    scanfp: .asciz "%f"
.align 4
    resultado: .asciz "O resultado é: %f\n"
.align 4
    numero: .fill 3, 4, 0
.balign 4
    half: .single 0.5
.align 4
    one: .single 1.0
.align 4
    val1: .single 1.0 @y0
.align 4
    val2: .single 0.5 @1/2
.align 4
    limit: .single 1e-5
.align 4
    zero: .single 0.0
.align 4
    two: .single 2.0
.align 4
    lnlimit: .single 1000.0

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
    
    @Print message to user
    LDR R0, =atanh_print
    BL printf

    @Read values of x
    LDR R1, =numero
    LDR R0, =scanfp
    BL scanf

    @Load float to 50
    LDR R1, =numero
    VLDR S0, [R1]

    BL _atanh

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {LR}
BX LR


/* ATANH - usado para calcular a inversa de atanh
    Parametros
    S0 - numero
    Return
    S0 - atanh
 */
/*  Formula usada para calcular
    1/2 * ln (1+x/1-x) 
*/
_atanh:
    PUSH {LR}
    LDR R1, =half
    VLDR S3, [R1]

    LDR R1, =one
    VLDR S4, [R1]

    VMOV.F32 S5, S0 

    VADD.F32 S6, S4, S5
    VSUB.F32 S7, S4, S5

    VDIV.F32 S0, S6, S7
    BL _ln

    VMUL.F32 S0, S0, S3

    POP {LR}    
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
