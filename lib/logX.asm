/**
 * INSTITUTO POLITÉCNICO DE BEJA
 * ESCOLA SUPERIOR DE TECNOLOGIA E GESTÃO
 * ENGENHARIA INFORMÁTICA
 * JOSÉ FRANCISCO - 22896
 * PATRÍCIA BERENGUER - 22893
 */

@Code Section
.Section .text
.arch armv8-a
.arm

/* LOGX - o mesmo que log 10 mas para qualquer base
    Parametros:
    S0 - numero
    S1 - base
    Return:
    S0 - logx
 */
/*  Algoritmo encontrado para calcular log10
    ln(x)/ln(b) = log10(x)
 */
_logx:
    PUSH {LR}
    VPUSH.F32 {S1-S5}
    @Perserve S0
    VMOV.F32 S4, S0

    BL _ln

    VMOV.F32 S5, S0

    VMOV.F32 S0, S1

    BL _ln
    
    VDIV.F32 S0, S5, S0


    VPOP.F32 {S1-S5}
    POP {LR}
BX LR
