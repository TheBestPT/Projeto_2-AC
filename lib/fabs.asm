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
    zero_fabs: .single 0.0

@Code Section
.Section .text
.arch armv8-a
.arm

/* FABS - retorna o valor absoluto
    Parametros:
    S0 - numero
    Return
    S0 - numero em valor absoluto
 */
_fabs:
    PUSH {LR}
    VPUSH {S1-S5}
    LDR R0, =zero_fabs
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
