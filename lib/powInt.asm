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
    zero_powInt: .single 0.0
.align 4
    one_powInt: .single 1.0

@Code Section
.Section .text
.arch armv8-a
.arm

/* POWINT - função auxiliar para calculer potencias de forma mais precisa (Só funciona com expoentes inteiros)
    Parametros:
    S0 - base do expoente
    S1 - expoente
    Retrun:
    S0 - pow
 */
_powInt2:
    PUSH {LR}
    VPUSH.F32 {S1-S4}
    LDR  R2, =one_powInt
    VLDR S2, [R2]
    LDR R2, =zero_powInt
    VLDR S4, [R2]
    @VERIFY IF ITS 1
    VCMP.F32 S1, S2
    VMRS APSR_nzcv, FPSCR
    BEQ end_powint2
    @VERIFY IF IS 0
    VCMP.F32 S1, S4
    VMRS APSR_nzcv, FPSCR
    //VMOVEQ.F32 S0, S2
    BEQ end_powint2_zero
    VSUB.F32 S1, S2
    VMOV.F32 S3, S0
    powInt2_loop:
        VMUL.F32 S3, S3, S0
        //ADD R1, #1                
        VADD.F32 S4, S2
        //CMP R1, R0 
        VCMP.F32 S4, S1
        VMRS APSR_nzcv, FPSCR
    BNE powInt2_loop
    VMOV.F32 S0, S3
    end_powint2_zero:
        VADD.F32 S1, S2
        VCMP.F32 S1, S4
        VMRS APSR_nzcv, FPSCR
        BNE end_powint2
        VMOVEQ.F32 S0, S1
        VPOP.F32 {S1-S4}
        POP {LR}
        BX LR

    end_powint2:
    VPOP.F32 {S1-S4}
    POP {LR}
BX LR
