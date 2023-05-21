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
    numeroExp: .fill 3, 4, 0
.align 4
    exp_print: .asciz "Insert (x) value for exp(x): "
.balign 4 
    scanfp: .asciz "%f"
.align 4
    resultado: .asciz "O resultado é: %f\n"
.align 4
    zero: .single 0.0
.align 4
    one: .single 1.0
.align 4
    two: .single 2.0
.align 4
    limit: .single 1e-5

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

    @Print message to user
    LDR R0, =exp_print
    BL printf

    @Read values of x
    LDR R1, =numeroExp
    LDR R0, =scanfp
    BL scanf

    @Load float to 50
    LDR R1, =numeroExp
    VLDR S0, [R1]
    

    BL _exp

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {LR}
BX LR

/* EXP - calcula o exponencial do numero dado
    Parametros:
    S0 - numero (expoente para o e)
    Retrun:
    S0 - exponencial 
 */
/* Fórmula usada para caculas
    Somatorio( x^2 / 2! + x^3 / 3! ....... )
 */
_exp:
    PUSH {LR}
    VPUSH.F32 {S1-S13}
    LDR R1, =one
    VLDR S1, [R1]

    LDR R1, =zero
    VLDR S11, [R1]

    LDR R1, =two
    VLDR S12, [R1]

    LDR R1, =limit
    VLDR S8, [R1]
    
    VMOV.F32 S4, S0
  
    LDR R1, =zero
    VLDR S9, [R1]
    
    exp_loop:
        VCMP.F32 S9, S11
        VMRS APSR_nzcv, FPSCR
        VADDEQ.F32 S3, S1
        VADDEQ.F32 S9, S1
        BEQ exp_loop

        VCMP.F32 S9, S1
        VMRS APSR_nzcv, FPSCR
        VADDEQ.F32 S3, S4
        VADDEQ.F32 S9, S1
        BEQ exp_loop

        
        VMOV.F32 S10, S11
        VMOV.F32 S5, S1
        exp_pow_loop:
            VMUL.F32 S5, S4

            VSUB.F32 S13, S9, S1
            
            VCMP.F32 S10, S13
            VMRS APSR_nzcv, FPSCR
            VADD.F32 S10, S1
        BLT exp_pow_loop

        LDR R1, =one
        VLDR S1, [R1]

        VMOV.F32 S0, S9  @ S0 = i, i!
        BL _fatorial

        VMOV.F32 S6, S0@FATORIAL
        VDIV.F32 S7, S5, S6

        VADD.F32 S3, S7 @ out
    
        VADD.F32 S9, S1
        VCMP.F32 S7, S8
        VMRS APSR_nzcv, FPSCR


    BGE exp_loop

    VMOV.F32 S0, S3
    VPOP.F32 {S1-S13}
    POP {LR}
BX LR

/* Fatorial - calcula o fatorial de um numero
    Parametros:
    S0 - numero
    Return:
    S0 - fatorial
 */
_fatorial:
    PUSH {LR}
    VPUSH.F32 {S1-S5}
    LDR  R0, =zero
    VLDR S1, [R0]                  
    VLDR S4, [R0]                  
    LDR  R0, =one
    VLDR S2, [R0]                  

    VCMP.F32 S0, S1
    VMRS APSR_nzcv, FPSCR
    VMOVEQ.F32 S0, S2
    @Compare with 1
    VCMP.F32 S0, S2
    VMRS APSR_nzcv, FPSCR
    VMOVEQ.F32 S0, S2

    factorial_loop:
        @S3 = I
        VMOV.F32 S3, S1          
        @ Create copy from S3 to S5. S5 - out.
        VMOV.F32 S5, S3              
        @ S3 -= 1.0
        VSUB.F32 S3, S2              
        factorial_loop_2:
            @ S5 *= S3
            VMUL.F32 S5, S3            
            @ S3 -= 1.0  / i--
            VSUB.F32 S3, S2            
            @ S3 > 0
            VCMP.F32 S3, S4            
            VMRS APSR_nzcv, FPSCR
        BGT factorial_loop_2
        VCMP.F32 S1, S0              
        VADD.F32 S1, S2              
        VMRS APSR_nzcv, FPSCR
    BLT factorial_loop
        VCMP.F32 S0, S2
        VMRS APSR_nzcv, FPSCR
        VMOVNE.F32 S0, S5
        VPOP.F32 {S1-S5}
        POP {LR}
BX LR
