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
    val1_sqrt: .single 1.0 @y0
.align 4
    val2_sqrt: .single 0.5 @1/2
.align 4
    limit_sqrt: .single 1e-5

@Code Section
.Section .text
.arch armv8-a
.arm
    
/*  Sqrt - Fazer raiz quadrada
    Parametros:
    S0 - numero
    Return 
    S0 - raiz quadrada
*/
_sqrt:
    PUSH {LR}
    VPUSH.F32 {S1-S5}
    LDR R0, =val1_sqrt
    VLDR S1, [R0] @ K value

    LDR R0, =val2_sqrt
    VLDR S3, [R0] @ 1/2

    LDR R0, =limit_sqrt
    VLDR S5, [R0] @ limit

    _sqrt_loop:
        VDIV.F32 S2, S0, S1 @ x/y_k
        VADD.F32 S2, S2, S1 @ y_k + x/y_k
        VMUL.F32 S2, S2, S3 @ 1/2 * y_k + x/y_k

        VSUB.F32 S4, S2, S1 @ y_k - y_k+1
        VABS.F32 S4, S4
        VMOV.F32 S1, S2

        VCMP.F32 S4, S5 
        VMRS APSR_nzcv, FPSCR
    BGT _sqrt_loop

    VMOV.F32 S0, S2
    VPOP.F32 {S1-S5}
    POP {LR}
BX LR
