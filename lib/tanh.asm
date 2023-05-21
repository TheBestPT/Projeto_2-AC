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

/* TANH - calcula o tanh a partir de um dado número
    Parametros:
    S0 - numero
    Return:
    S0 - tanh
 */
/*  Formula usada para calcular
    (1 - E^-2X ) / (1 + E^-2X )
    ou seja
    sinh x / cosh x = tanh
 */
_tanh:
    PUSH {LR}
    VPUSH.F32 {S1-S8}

    //PERSERVE S0
    VMOV.F32 S4, S0

    BL _sinh

    VMOV.F32 S5, S0

    VMOV.F32 S0, S4

    BL _cosh

    VDIV.F32 S0, S5, S0

    VPOP.F32 {S1-S8}
    POP {LR}
BX LR
