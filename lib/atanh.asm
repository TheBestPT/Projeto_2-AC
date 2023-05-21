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
    half_atanh: .single 0.5
.align 4
    one_atanh: .single 1.0

@Code Section
.Section .text
.arch armv8-a
.arm

/* ATANH - usado para calcular a inversa de atanh
    Parametros
    S0 - numero
    Return
    S0 - atanh
 */
/*  Formula usada para calcular
    1/2 * ln (1+x/1-x) 
*/
_atanh:
    PUSH {LR}
    LDR R1, =half_atanh
    VLDR S3, [R1]

    LDR R1, =one_atanh
    VLDR S4, [R1]

    VMOV.F32 S5, S0 

    VADD.F32 S6, S4, S5
    VSUB.F32 S7, S4, S5

    VDIV.F32 S0, S6, S7
    BL _ln

    VMUL.F32 S0, S0, S3

    POP {LR}    
BX LR
