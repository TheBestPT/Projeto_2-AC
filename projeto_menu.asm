/**
 * INSTITUTO POLITÉCNICO DE BEJA
 * ESCOLA SUPERIOR DE TECNOLOGIA E GESTÃO
 * ENGENHARIA INFORMÁTICA
 * JOSÉ FRANCISCO - 22896
 * PATRÍCIA BERENGUER - 22893
 */

@Data Section
.data
/*
"Global" Variables
 */
.balign 4
    testNumber: .single 5.0
.balign 4
    scanInputInt: .asciz "%d"
.balign 4
    inputOption: .fill 50, 1, 0
.balign 4
    scanInputString: .asciz "%f\n"
.balign 4
    insertInt: .asciz "Insira um inteiro: "
.balign 4
    testInt: .asciz "%d"
.balign
    mainMenu: .asciz "Menu\n1 - acosh\n2 - asinh\n3 - atanh\n4 - cosh\n5 - exp\n6 - fabs\n7 - hypot\n8 - ln\n9 - log10\n10 - pow\n11 - sinh\n12 - sqrt\n13 - tanh\n14 - ldexp\n15 - fatorial\n16 - logX\n17 - powInt\n\nEscolha uma opção: "
.align 4
    zero: .single 0.0
.align 4
    one: .single 1.0
.align 4
    two: .single 2.0
.balign 4
    ten: .single 10.0
.balign 4
    half: .single 0.5

/*
ACOSH VARIABLES
 */
.align 4
    acosh_print: .asciz "Insert (x) value for acosh(x): "

/*
ASINH VARIABLES
 */
.align 4
    asinh_print: .asciz "Insert (x) value for asinh(x): "

/*
ATANH VARIABLES
 */
.align 4
    atanh_print: .asciz "Insert (x) value for atanh(x): "

/*
COSH VARIABLES
 */

.align 4
    cosh_print: .asciz "Insert (x) value for cosh(x): "

/*
EXP VARIABLES
 */
.align 4
    numeroExp: .fill 3, 4, 0
.align 4
    exp_print: .asciz "Insert (x) value for exp(x): "

/*
FABS VARIABLES
 */
.align 4
    numeroFabs: .fill 3, 4, 0
.align 4
    fabs_print: .asciz "Insert (x) value for fabs(x): "

/*
HYPOT VARIABLES
 */
.align 4
    hypotc1_print: .asciz "Insert (c1) value for hypot: "
.align 4
    hypotc2_print: .asciz "Insert (c2) value for hypot: "
.align 4
    c1_nr: .single 0.0
.align 4
    c2_nr: .single 0.0

/*
LN VARIABLES
 */

.align 4
    ln_print: .asciz "Insert (x) value for ln(x): "
.align 4
    lnlimit: .single 1000.0

/*
LOG10 VARIABLES
 */
.align 4
    log10_print: .asciz "Insert (x) value for log10(x): "
.align 4
    numberLog10: .fill 3, 4, 0

/*
POW VARIABLES
 */
.align 4
    pow_base_print: .asciz "Insert (x) value for base of pow(x): "
.align 4
    pow_expon_print: .asciz "Insert (x) value for exponent of pow(y): "
.align 4
    pow_base: .fill 3, 4, 0
.align 4
    pow_exponent: .fill 3, 4, 0

/*
SINH VARIABLES
 */

.align 4
    sinh_print: .asciz "Insert (x) value for sinh(x): "

/*
SQRT VARIABLES
 */
.align 4
    val1: .single 1.0 @y0
.align 4
    val2: .single 0.5 @1/2
.align 4
    limit: .single 1e-5
.balign 4 
    sqrt_print: .asciz "Insert (x) value for sqrt(x): "
.align 4
    numero: .fill 3, 4, 0
.align 4
    numero1: .fill 3, 4, 0
.balign 4 
    scanfp: .asciz "%f"
.align 4
    resultado: .asciz "O resultado é: %f\n"

/*
TANH VARIABLES
 */
.align 4
    tanh_print: .asciz "Insert (x) value for cosh(x): "

/*
LDEXP
 */
.align 4
    ldexp_mul_print: .asciz "Insert (x) value for lexp multiplyer number(x): "
.align 4
    ldexp_expon_print: .asciz "Insert (x) value for lexp exponent(x): "
.align 4
    numeroMulLdexp: .fill 3, 4, 0
.align 4
    exponentLdexp: .fill 3, 4, 0

/*
FATORIAL VARIABLES
 */
.align 4
    fatorial_print: .asciz "Insert (x) value for fatorial(x): "
.align 4
    numeroFatorial: .fill 3, 4, 0

/*
LOGX VARIABLES
 */
.align 4
    logx_print: .asciz "Insert (x) value for logx(x): "
.align 4
    logx_base_print: .asciz "Insert (x) value for x (log base): "
.align 4
    numberLogX: .fill 3, 4, 0
.align 4
    numberLogXBase: .fill 3, 4, 0

@External C functions
.global scanf
.global printf

@Code Section
.Section .text
.global main
.arch armv8-a
.arm


main:
    /*
    Esta secacao do main e para seleção das opcões do menu
     */
    PUSH {LR}
    LDR R0, =mainMenu
    BL printf

    LDR R0, =scanInputInt
    LDR R1, =inputOption
    BL scanf

    LDR R0, =inputOption
    LDRB R2, [R0, #0]
    MOV R0, R2 
    
    CMP R0, #1
    BLEQ _callAcosh

    CMP R0, #2
    BLEQ _callAsinh

    CMP R0, #3
    BLEQ _callAtanh

    CMP R0, #4
    BLEQ _callCosh

    CMP R0, #5
    BLEQ _callExp

    CMP R0, #6
    BLEQ _callFabs

    CMP R0, #7
    BLEQ _callHypot

    CMP R0, #8
    BLEQ _callLn

    CMP R0, #9
    BLEQ _callLog10

    CMP R0, #10
    BLEQ _callPow

    CMP R0, #11
    BLEQ _callSinh

    CMP R0, #12
    BLEQ _callSqrt

    CMP R0, #13
    BLEQ _callTanh

    CMP R0, #14
    BLEQ _callLdexp

    CMP R0, #15
    BLEQ _callFatorial

    CMP R0, #16
    BLEQ _callLogX

    CMP R0, #17
    BLEQ _callPowInt

    POP {LR}
BX LR



/*
Todos os calls das funções são parecidos e única diferença é que muda a string o metodo chamado e quantidade de variaveis a inserir
 */

_callAcosh:
    PUSH {R0, LR}
    
    @Print message to user
    LDR R0, =acosh_print
    BL printf

    @Read values of x
    LDR R1, =numero
    LDR R0, =scanfp
    BL scanf

    @Load float to 50
    LDR R1, =numero
    VLDR S0, [R1]

    BL _acosh

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {R0, LR}
BX LR

_callAsinh:
    PUSH {R0, LR}
    
    @Print message to user
    LDR R0, =asinh_print
    BL printf

    @Read values of x
    LDR R1, =numero
    LDR R0, =scanfp
    BL scanf

    @Load float to 50
    LDR R1, =numero
    VLDR S0, [R1]

    BL _asinh

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {R0, LR}
BX LR

_callAtanh:
    PUSH {R0, LR}
    
    @Print message to user
    LDR R0, =atanh_print
    BL printf

    @Read values of x
    LDR R1, =numero
    LDR R0, =scanfp
    BL scanf

    @Load float to 50
    LDR R1, =numero
    VLDR S0, [R1]

    BL _atanh

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {R0, LR}
BX LR

_callCosh:
    PUSH {R0, LR}
    
    @Print message to user
    LDR R0, =cosh_print
    BL printf

    @Read values of x
    LDR R1, =numero
    LDR R0, =scanfp
    BL scanf

    @Load float to 50
    LDR R1, =numero
    VLDR S0, [R1]

    BL _cosh

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {R0, LR}
BX LR

_callExp:
    PUSH {R0, LR}

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
    POP {R0, LR}
BX LR

_callFabs:
    PUSH {R0, LR}
    @Print message to user
    LDR R0, =fabs_print
    BL printf

    @Read values of x
    LDR R1, =numero
    LDR R0, =scanfp
    BL scanf

    @Load float to 50
    LDR R1, =numero
    VLDR S0, [R1]
    BL _fabs

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf

    POP {R0, LR}
BX LR

_callHypot:
    PUSH {R0, LR}

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
    POP {R0, LR}
BX LR

_callLn:
    PUSH {R0, LR}
    
    @Print message to user
    LDR R0, =ln_print
    BL printf

    @Read values of x
    LDR R1, =numero
    LDR R0, =scanfp
    BL scanf

    @Load float to 50
    LDR R1, =numero
    VLDR S0, [R1]

    BL _ln

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {R0, LR}
BX LR

_callLog10:
    PUSH {R0, LR}
    
    @Print message to user
    LDR R0, =log10_print
    BL printf

    @Read values of x
    LDR R1, =numberLog10
    LDR R0, =scanfp
    BL scanf

    @Load float to 50
    LDR R1, =numberLog10
    VLDR S0, [R1]

    BL _log10

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {R0, LR}
BX LR

_callPow:
    PUSH {R0, LR}
    LDR R0, =pow_base_print
    BL printf

    LDR R1, =pow_base
    LDR R0, =scanfp
    BL scanf

    LDR R0, =pow_expon_print
    BL printf

    LDR R1, =pow_exponent
    LDR R0, =scanfp
    BL scanf

    LDR R1, =pow_base
    VLDR S0, [R1]

    LDR R1, =pow_exponent
    VLDR S1, [R1]

    BL _pow

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {R0, LR}
BX LR

_callSinh:
    PUSH {R0, LR}
    
    @Print message to user
    LDR R0, =sinh_print
    BL printf

    @Read values of x
    LDR R1, =numero
    LDR R0, =scanfp
    BL scanf

    @Load float to 50
    LDR R1, =numero
    VLDR S0, [R1]

    BL _sinh

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {R0, LR}
BX LR

_callSqrt:
    PUSH {R0, LR}

    @Print message to user
    LDR R0, =sqrt_print
    BL printf

    @Read values of x
    LDR R1, =numero
    LDR R0, =scanfp
    BL scanf

    @Load float to 50
    LDR R1, =numero
    VLDR S0, [R1]
    BL _sqrt

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf

    POP {R0, LR}
BX LR

_callTanh:
    PUSH {R0, LR}
    
    @Print message to user
    LDR R0, =tanh_print
    BL printf

    @Read values of x
    LDR R1, =numero
    LDR R0, =scanfp
    BL scanf

    @Load float to 50
    LDR R1, =numero
    VLDR S0, [R1]

    BL _tanh

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {R0, LR}
BX LR

_callLdexp:
    PUSH {R0, LR}

    @Print message to user
    LDR R0, =ldexp_mul_print
    BL printf

    @Read values of x
    LDR R1, =numeroMulLdexp
    LDR R0, =scanfp
    BL scanf

    LDR R0, =ldexp_expon_print
    BL printf

    @Read values of x
    LDR R1, =exponentLdexp
    LDR R0, =scanfp
    BL scanf

    LDR R1, =numeroMulLdexp
    VLDR S0, [R1]

    LDR R1, =exponentLdexp
    VLDR S1, [R1]
    

    BL _ldexp

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {R0, LR}
BX LR

_callFatorial:
    PUSH {R0, LR}
    @Print message to user
    LDR R0, =fatorial_print
    BL printf

    @Read values of x
    LDR R1, =numeroFatorial
    LDR R0, =scanfp
    BL scanf

    @Load float to 50
    LDR R1, =numeroFatorial
    VLDR S0, [R1]
    

    BL _fatorial

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {R0, LR}
BX LR

_callLogX:
    PUSH {R0, LR}
    LDR R0, =logx_print
    BL printf

    LDR R1, =numberLogX
    LDR R0, =scanfp
    BL scanf

    LDR R0, =logx_base_print
    BL printf

    LDR R1, =numberLogXBase
    LDR R0, =scanfp
    BL scanf

    LDR R1, =numberLogX
    VLDR S0, [R1]

    LDR R1, =numberLogXBase
    VLDR S1, [R1]

    BL _logx

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {R0, LR}
BX LR

_callPowInt:
    PUSH {R0, LR}

    LDR R0, =pow_base_print
    BL printf

    LDR R1, =pow_base
    LDR R0, =scanfp
    BL scanf

    LDR R0, =pow_expon_print
    BL printf

    LDR R1, =numeroExp
    LDR R0, =scanfp
    BL scanf

    LDR R1, =pow_base
    VLDR S0, [R1]

    LDR R1, =numeroExp
    VLDR S1, [R1]
    

    BL _powInt2

    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =resultado
    BL printf
    POP {R0, LR}
BX LR

//---------------------------------------------------------------------------------------------

//METHODS

//---------------------------------------------------------------------------------------------

/* ACOSH - usado para calcular a inversa de acosh
    Parametros
    S0 - numero
    Return
    S0 - acosh
 */
/*  Formula usada para calcular 
    ln (x + sqrt( x^2 - 1 )) 
*/
_acosh:
    PUSH {LR}
    VPUSH.F32 {S1-S5}
    LDR R1, =one
    VLDR S4, [R1]

    LDR R1, =two
    VLDR S5, [R1]

    @Perserve S0
    VMOV.F32 S2, S0
    @S1 expoente
    VMUL.F32 S0, S0, S0
    

    VSUB.F32 S0, S4

    BL _sqrt

    VADD.F32 S0, S2

    BL _ln
    VPOP.F32 {S1-S5}
    POP {LR}
BX LR

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
    LDR R1, =one
    VLDR S4, [R1]

    LDR R1, =two
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
    LDR R1, =half
    VLDR S3, [R1]

    LDR R1, =one
    VLDR S4, [R1]

    VMOV.F32 S5, S0 

    VADD.F32 S6, S4, S5
    VSUB.F32 S7, S4, S5

    VDIV.F32 S0, S6, S7
    BL _ln

    VMUL.F32 S0, S0, S3

    POP {LR}    
BX LR

/* COSH - calcula o cosh a partir de um dado número
    Parametros:
    S0 - numero
    Return:
    S0 - cosh
 */
/*  Formula usada para calcular
    (1 - E^-2X ) / 2E^-X
 */
_cosh:
    PUSH {LR}
    VPUSH.F32 {S1-S8}
    LDR R1, =one
    VLDR S1, [R1]

    LDR R1, =zero
    VLDR S2, [R1]

    VMOV.F32 S5, S0@x

    @E^-2X
    /////////////////////////////////////////
    LDR R1, =two
    VLDR S4, [R1]
    VMUL.F32 S0, S5, S4
    //VNEG.F32 S0, S0
    BL _exp
    VDIV.F32 S6, S1, S0
    /////////////////////////////////////////

    VADD.F32 S7, S1, S6


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

/* FABS - retorna o valor absoluto
    Parametros:
    S0 - numero
    Return
    S0 - numero em valor absoluto
 */
_fabs:
    PUSH {LR}
    VPUSH {S1-S5}
    LDR R0, =zero
    VLDR S1, [R0] @ K value

    VCMP.F32 S0, S1
    VMRS APSR_nzcv, FPSCR
    VPOP {S1-S5}
    POP {LR}
    BXGE LR
    PUSH {LR}
    VPUSH {S1-S5}
    VNEG.F32 S0, S0
    VPOP {S1-S5}
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
    LDR R1, =one
    VLDR S4, [R1]

    @num
    LDR R1, =zero
    VLDR S5, [R1]

    @mul
    LDR R1, =zero
    VLDR S6, [R1]

    @cal
    LDR R1, =zero
    VLDR S7, [R1]

    @sum
    LDR R1, =zero
    VLDR S8, [R1]

    @limit
    LDR R1, =lnlimit
    VLDR S9, [R1]


    @two
    LDR R1, =two
    VLDR S10, [R1]

    @one
    LDR R1, =one
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

/* LOG10 - usado para calcular o log de base 10
    Parametros:
    S0 - numero
    Return:
    S0 - log10
 */
/*  Algoritmo encontrado para calcular log10
    ln(x)/ln(10) = log10(x)
 */
_log10:
    PUSH {LR}
    VPUSH.F32 {S1-S6}
    LDR R1, =ten
    VLDR S6, [R1]
    @Perserve S0
    VMOV.F32 S4, S0

    BL _ln

    VMOV.F32 S5, S0

    VMOV.F32 S0, S6

    BL _ln
    
    VDIV.F32 S0, S5, S0


    VPOP.F32 {S1-S6}
    POP {LR}
BX LR

/* POW - e o mesmo que o powint mas com a diferença que esta preparado para expoentes decimais
    Parametros:
    S0 - base 
    S1 - expoente
    Return:
    S0 - pow
 */
/* Algoritmo encontrado para calcular o expoente
    Math.Exp(expoente * Math.Log(base))
 */
_pow:
    PUSH {LR}
    VPUSH.F32 {S1-S4}
    BL   _ln
    VPOP.F32 {S1-S4}
  

    VMUL.F32 S4, S0, S1
    VMOV.F32 S0, S4

    VPUSH.F32 {S1-S4}
    BL   _exp
    VPOP.F32 {S1-S4}
    POP  {LR}
BX LR

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
    LDR R1, =one
    VLDR S1, [R1]

    LDR R1, =zero
    VLDR S2, [R1]

    VMOV.F32 S5, S0@x

    @E^-2X
    /////////////////////////////////////////
    LDR R1, =two
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

/* TANH - calcula o tanh a partir de um dado número
    Parametros:
    S0 - numero
    Return:
    S0 - tanh
 */
/*  Formula usada para calcular
    (1 - E^-2X ) / (1 + E^-2X )
    ou seja
    sinh x / cosh x = tanh
 */
_tanh:
    PUSH {LR}
    VPUSH.F32 {S1-S8}

    //PERSERVE S0
    VMOV.F32 S4, S0

    BL _sinh

    VMOV.F32 S5, S0

    VMOV.F32 S0, S4

    BL _cosh

    VDIV.F32 S0, S5, S0

    VPOP.F32 {S1-S8}
    POP {LR}
BX LR

/*  LDEXP - Usado para returnar um numero multiplicado por 2 com espoente dado
    Parametors:
    S0 - numero a ser multiplicado
    S1 - expoente 
    Return:
    S0 - lexp
 */
_ldexp:
    PUSH {LR}
    VPUSH.F32 {S1-S6}
    LDR R1, =two
    VLDR S2, [R1]
    
    LDR R1, =one
    VLDR S3, [R1]

    LDR R1, =zero
    VLDR S4, [R1]

    @S5 - MUL NUMBER
    VMOV.F32 S5, S0
    @S6 - EXPONENT
    VMOV.F32 S6, S1

    @s0 - exponent base
    VMOV.F32 S0, S2
    VMOV.F32 S1, S6
    BL _powInt2

    VMUL.F32 S0, S5, S0

    VPOP.F32 {S1-S6}
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

/* LOGX - o mesmo que log 10 mas para qualquer base
    Parametros:
    S0 - numero
    S1 - base
    Return:
    S0 - logx
 */
/*  Algoritmo encontrado para calcular log10
    ln(x)/ln(b) = log10(x)
 */
_logx:
    PUSH {LR}
    VPUSH.F32 {S1-S5}
    @Perserve S0
    VMOV.F32 S4, S0

    BL _ln

    VMOV.F32 S5, S0

    VMOV.F32 S0, S1

    BL _ln
    
    VDIV.F32 S0, S5, S0


    VPOP.F32 {S1-S5}
    POP {LR}
BX LR

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
    LDR  R2, =one
    VLDR S2, [R2]
    LDR R2, =zero
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
