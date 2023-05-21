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
    zero_exp: .single 0.0
.align 4
    one_exp: .single 1.0
.align 4
    two_exp: .single 2.0
.align 4
    limit_exp: .single 1e-5
    
@Code Section
.Section .text
.arch armv8-a
.arm

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
    LDR R1, =one_exp
    VLDR S1, [R1]

    LDR R1, =zero_exp
    VLDR S11, [R1]

    LDR R1, =two_exp
    VLDR S12, [R1]

    LDR R1, =limit_exp
    VLDR S8, [R1]
    
    VMOV.F32 S4, S0
  
    LDR R1, =zero_exp
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

        LDR R1, =one_exp
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
