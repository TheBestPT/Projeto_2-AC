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
    zero: .single 0.0
.align 4
    numero: .fill 3, 4, 0
.align 4
    numeroFabs: .fill 3, 4, 0
.balign 4 
    scanfp: .asciz "%f"
.align 4
    fabs_print: .asciz "Insert (x) value for fabs(x): "
.align 4
    resultado: .asciz "O resultado é: %f\n"

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
    LDR R0, =fabs_print
    BL printf

    @Read values of x
    LDR R1, =numero
    LDR R0, =scanfp
    BL scanf

    @Load float to 50
    LDR R1, =numero
    VLDR S0, [R1]
    BL _fabs

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf

    POP {LR}
BX LR

/* FABS - retorna o valor absoluto
    Parametros:
    S0 - numero
    Return
    S0 - numero em valor absoluto
 */
_fabs:
    PUSH {LR}
    VPUSH {S1-S5}
    LDR R0, =zero
    VLDR S1, [R0] @ K value

    VCMP.F32 S0, S1
    VMRS APSR_nzcv, FPSCR
    VPOP {S1-S5}
    POP {LR}
    BXGE LR
    PUSH {LR}
    VPUSH {S1-S5}
    VNEG.F32 S0, S0
    VPOP {S1-S5}
    POP {LR}
BX LR
