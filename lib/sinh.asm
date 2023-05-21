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
    zero_sinh: .single 0.0
.align 4
    one_sinh: .single 1.0
.align 4
    two_sinh: .single 2.0

@Code Section
.Section .text
.arch armv8-a
.arm

/* SINH - calcula o sinh a partir de um dado número
    Parametros:
    S0 - numero
    Return:
    S0 - sinh
 */
/* Formula usada para calcular
    (1 - E^-2X ) / 2E^-X
 */
_sinh:
    PUSH {LR}
    VPUSH.F32 {S1-S8}
    LDR R1, =one_sinh
    VLDR S1, [R1]

    LDR R1, =zero_sinh
    VLDR S2, [R1]

    VMOV.F32 S5, S0@x

    @E^-2X
    /////////////////////////////////////////
    LDR R1, =two_sinh
    VLDR S4, [R1]
    VMUL.F32 S0, S5, S4
    //VNEG.F32 S0, S0
    BL _exp
    VDIV.F32 S6, S1, S0
    /////////////////////////////////////////

    VSUB.F32 S7, S1, S6


    @2E^-X
    /////////////////////////////////////////
    //VMUL.F32 S0, S5, S4
    //VNEG.F32 S0, S0
    VMOV.F32 S0, S5
    BL _exp
    VDIV.F32 S8, S1, S0
    VMUL.F32 S8, S8, S4
    /////////////////////////////////////////


    VDIV.F32 S0, S7, S8

    //VMOV.F32 S0, S7


    //VNEG.F32 S0, S0

    VPOP.F32 {S1-S8}
    POP {LR}
BX LR
