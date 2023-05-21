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
    zero_fatorial: .single 0.0
.align 4
    one_fatorial: .single 1.0

@Code Section
.Section .text
.arch armv8-a
.arm

/* Fatorial - calcula o fatorial de um numero
    Parametros:
    S0 - numero
    Return:
    S0 - fatorial
 */
_fatorial:
    PUSH {LR}
    VPUSH.F32 {S1-S5}
    LDR  R0, =zero_fatorial
    VLDR S1, [R0]                  
    VLDR S4, [R0]                  
    LDR  R0, =one_fatorial
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
