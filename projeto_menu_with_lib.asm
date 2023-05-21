/**
 * INSTITUTO POLITÉCNICO DE BEJA
 * ESCOLA SUPERIOR DE TECNOLOGIA E GESTÃO
 * ENGENHARIA INFORMÁTICA
 * JOSÉ FRANCISCO - 22896
 * PATRÍCIA BERENGUER - 22893
 */

.include "./lib/acosh.asm"
.include "./lib/asinh.asm"
.include "./lib/atanh.asm"
.include "./lib/cosh.asm"
.include "./lib/exp.asm"
.include "./lib/fabs.asm"
.include "./lib/hypot.asm"
.include "./lib/ln.asm"
.include "./lib/log10.asm"
.include "./lib/pow.asm"
.include "./lib/sinh.asm"
.include "./lib/sqrt.asm"
.include "./lib/tanh.asm"
.include "./lib/ldexp.asm"
.include "./lib/fatorial.asm"
.include "./lib/logX.asm"
.include "./lib/powInt.asm"

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
