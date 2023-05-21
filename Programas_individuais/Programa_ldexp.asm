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
    ldexp_mul_print: .asciz "Insert (x) value for ldexp multiplyer number(x): "
.align 4
    ldexp_expon_print: .asciz "Insert (x) value for ldexp exponent(x): "
.align 4
    numeroMulLdexp: .fill 3, 4, 0
.align 4
    exponentLdexp: .fill 3, 4, 0
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
    LDR R0, =ldexp_mul_print
    BL printf

    @Read values of x
    LDR R1, =numeroMulLdexp
    LDR R0, =scanfp
    BL scanf

    LDR R0, =ldexp_expon_print
    BL printf

    @Read values of x
    LDR R1, =exponentLdexp
    LDR R0, =scanfp
    BL scanf

    LDR R1, =numeroMulLdexp
    VLDR S0, [R1]

    LDR R1, =exponentLdexp
    VLDR S1, [R1]
    

    BL _ldexp

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {LR}
BX LR

/*  LDEXP - Usado para returnar um numero multiplicado por 2 com espoente dado
    Parametors:
    S0 - numero a ser multiplicado
    S1 - expoente 
    Return:
    S0 - lexp
 */
 /*
    numeroAserMultiplicado * 2 ^ expoente
 */
_ldexp:
    PUSH {LR}
    VPUSH.F32 {S1-S6}
    LDR R1, =two
    VLDR S2, [R1]
    
    LDR R1, =one
    VLDR S3, [R1]

    LDR R1, =zero
    VLDR S4, [R1]

    @S5 - MUL NUMBER
    VMOV.F32 S5, S0
    @S6 - EXPONENT
    VMOV.F32 S6, S1

    @s0 - exponent base
    VMOV.F32 S0, S2
    VMOV.F32 S1, S6
    BL _powInt2

    VMUL.F32 S0, S5, S0

    VPOP.F32 {S1-S6}
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
