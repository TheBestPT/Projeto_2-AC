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
    zero_ldexp: .single 0.0
.align 4
    one_ldexp: .single 1.0
.align 4
    two_ldexp: .single 2.0

@Code Section
.Section .text
.arch armv8-a
.arm

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
    LDR R1, =two_ldexp
    VLDR S2, [R1]
    
    LDR R1, =one_ldexp
    VLDR S3, [R1]

    LDR R1, =zero_ldexp
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
