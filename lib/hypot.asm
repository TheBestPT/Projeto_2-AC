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
    zero_hypot: .single 0.0
.align 4
    one_hypot: .single 1.0
.align 4
    two_hypot: .single 2.0

@Code Section
.Section .text
.arch armv8-a
.arm

/* HYPOT - calcular a hipotenusa de um triângulo fornecendos os seus catetos
    Parametros:
    S0 - cateto 1
    S1 - cateto 2
    Retrun
    S0 - hipotenusa

 */
/*
    H^2 = C1^2 + C2^2
 */
_hypot:
    PUSH {LR}
    VPUSH.F32 {S1-S7}
    LDR R1, =one_hypot
    VLDR S2, [R1]

    LDR R1, =zero_hypot
    VLDR S3, [R1]

    LDR R1, =two_hypot
    VLDR S7, [R1]

    VMUL.F32 S4, S0, S0
    VMUL.F32 S5, S1, S1

    VADD.F32 S6, S5, S4

    VMOV.F32 S0, S6

    BL _sqrt

    //VMOV.F32 S0, S4
    VPOP.F32 {S1-S7}
    POP {LR}
BX LR
