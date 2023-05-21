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
    hypotc1_print: .asciz "Insert (c1) value for hypot: "
.align 4
    hypotc2_print: .asciz "Insert (c2) value for hypot: "
.align 4
    c1_nr: .single 0.0
.align 4
    c2_nr: .single 0.0
.balign 4 
    scanfp: .asciz "%f"
.align 4
    limit: .single 1e-5
.align 4
    zero: .single 0.0
.align 4
    one: .single 1.0
.align 4
    two: .single 2.0
.align 4
    val1: .single 1.0 @y0
.align 4
    val2: .single 0.5 @1/2
.align 4
    resultado: .asciz "O resultado é: %f\n"

@External C functions
.global scanf
.global printf

@Code Section
.Section .text
.global main
.arch armv8-a
.arm

main:
    PUSH {LR}

    LDR R0, =hypotc1_print
    BL printf

    LDR R1, =c1_nr
    LDR R0, =scanfp
    BL scanf

    LDR R0, =hypotc2_print
    BL printf

    LDR R1, =c2_nr
    LDR R0, =scanfp
    BL scanf

    LDR R1, =c1_nr
    VLDR S0, [R1]

    LDR R1, =c2_nr
    VLDR S1, [R1]

    BL _hypot

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {LR}
BX LR

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
    LDR R1, =one
    VLDR S2, [R1]

    LDR R1, =zero
    VLDR S3, [R1]

    LDR R1, =two
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

/*  Sqrt - Fazer raiz quadrada
    Parametros:
    S0 - numero
    Return 
    S0 - raiz quadrada
*/
_sqrt:
    PUSH {LR}
    VPUSH.F32 {S1-S5}
    LDR R0, =val1
    VLDR S1, [R0] @ K value

    LDR R0, =val2
    VLDR S3, [R0] @ 1/2

    LDR R0, =limit
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
