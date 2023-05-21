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
