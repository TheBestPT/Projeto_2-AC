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
    zero_ln: .single 0.0
.align 4
    one_ln: .single 1.0
.align 4
    two_ln: .single 2.0
.align 4
    lnlimit_ln: .single 1000.0

@Code Section
.Section .text
.arch armv8-a
.arm

/* LN - usado para calcular a inversa da expoencial
    Parametros:
    S0 - numero
    Return:
    S0 - ln

 */
/* Algoritmo encontrado para calcular o ln
    function calculateLnx(n){
        let num, mul, cal, sum = 0;
        num = (n - 1) / (n + 1);
    
        // Terminating value of the loop
        // can be increased to improve the precision
        for(let i = 1; i <= 1000; i++)
        {
            mul = (2 * i) - 1;
            cal = Math.pow(num, mul);
            cal = cal / mul;
            sum = sum + cal;
        }
        sum = 2 * sum;
        return sum;
    }
 */
_ln:
    PUSH {LR}
    VPUSH.F32 {S1-S13}

    @Incrementador
    LDR R1, =one_ln
    VLDR S4, [R1]

    @num
    LDR R1, =zero_ln
    VLDR S5, [R1]

    @mul
    LDR R1, =zero_ln
    VLDR S6, [R1]

    @cal
    LDR R1, =zero_ln
    VLDR S7, [R1]

    @sum
    LDR R1, =zero_ln
    VLDR S8, [R1]

    @limit
    LDR R1, =lnlimit_ln
    VLDR S9, [R1]


    @two
    LDR R1, =two_ln
    VLDR S10, [R1]

    @one
    LDR R1, =one_ln
    VLDR S11, [R1]

    VSUB.F32 S12, S0, S11
    VADD.F32 S13, S0, S11
    VDIV.F32 S5, S12, S13

    ln_loop:
        @first step mul = (2 * i)
        VMUL.F32 S6, S4, S10
        @ mul = (2 * i) - 1
        VSUB.F32 S6, S11
        @end first setp

        @Second step Math.pow(num, mul)
        @PERSERVE N
        VMOV.F32 S2, S0

        VMOV.F32 S0, S5
        VMOV.F32 S1, S6

        BL _powInt2
        @End first

        @Third step cal = cal / mul
        VMOV.F32 S7, S0
        VDIV.F32 S7, S7, S6
        @End third

        @Fourth step sum = sum + cal
        VADD.F32 S8, S7
        @end fourth step

        VADD.F32 S4, S11
        VCMP.F32 S4, S9
        VMRS APSR_nzcv, FPSCR
    BLE ln_loop
    VMUL.F32 S8, S10
    VMOV.F32 S0, S8
    //VMOV.F32 S0, S6
    VPOP.F32 {S1-S13}
    POP {LR}
BX LR
