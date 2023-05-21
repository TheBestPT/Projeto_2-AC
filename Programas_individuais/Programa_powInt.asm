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
    numeroExp: .fill 3, 4, 0
.align 4
    resultado: .asciz "O resultado é: %f\n"
.align 4
    zero: .single 0.0
.align 4
    one: .single 1.0

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

    LDR R1, =numeroExp
    LDR R0, =scanfp
    BL scanf

    LDR R1, =pow_base
    VLDR S0, [R1]

    LDR R1, =numeroExp
    VLDR S1, [R1]
    

    BL _powInt2

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
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
