/**
 * INSTITUTO POLITÉCNICO DE BEJA
 * ESCOLA SUPERIOR DE TECNOLOGIA E GESTÃO
 * ENGENHARIA INFORMÁTICA
 * JOSÉ FRANCISCO - 22896
 * PATRÍCIA BERENGUER - 22893
 */

@Data Section
.data
.balign 4
    ten_log10: .single 10.0

@Code Section
.Section .text
.arch armv8-a
.arm

/* LOG10 - usado para calcular o log de base 10
    Parametros:
    S0 - numero
    Return:
    S0 - log10
 */
/*  Algoritmo encontrado para calcular log10
    ln(x)/ln(10) = log10(x)
 */
_log10:
    PUSH {LR}
    VPUSH.F32 {S1-S6}
    LDR R1, =ten_log10
    VLDR S6, [R1]
    @Perserve S0
    VMOV.F32 S4, S0

    BL _ln

    VMOV.F32 S5, S0

    VMOV.F32 S0, S6

    BL _ln
    
    VDIV.F32 S0, S5, S0


    VPOP.F32 {S1-S6}
    POP {LR}
BX LR
