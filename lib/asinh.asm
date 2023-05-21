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
    one_asinh: .single 1.0
.align 4
    two_asinh: .single 2.0

@Code Section
.Section .text
.arch armv8-a
.arm

/* ASINH - usado para calcular a inversa de asin
    Parametros
    S0 - numero
    Return
    S0 - asinh
 */
/* Formula usada para calcular 
    ln (x + sqrt( x^2 - 1 )) 
*/
_asinh:
    PUSH {LR}
    VPUSH.F32 {S1-S5}
    LDR R1, =one_asinh
    VLDR S4, [R1]

    LDR R1, =two_asinh
    VLDR S5, [R1]

    @Perserve S0
    VMOV.F32 S2, S0
    @S1 expoente
    VMUL.F32 S0, S0, S0
    

    VADD.F32 S0, S4

    BL _sqrt

    VADD.F32 S0, S2

    BL _ln
    VPOP.F32 {S1-S5}
    POP {LR}
BX LR
