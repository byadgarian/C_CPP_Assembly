;********** PROGRAM INFORMATION **********************************************************************
;  Program Name: Harmonic Mean
;  Student Name: Brian Y
;  Student Email: ***

;********** MAIN CODE AREA **********************************************************************
;---------- DECLARATIONS ----------------------------------------------------------------------
;---EXTERNAL AND GLOBAL FUNCTIONS
extern printf
extern scanf
extern isfloat
extern atof
global fill

;---OTHER DECLARATIONS---
segment .data
inputMsg db "Please enter floating point numbers separated by white space.",10, "When finished press enter followed by ctrl+d.",10,0
inputFloat db "%s",0

segment .bss

segment .text
fill:
push qword 0
push rbp
mov rbp, rsp
;---------- FILL THE ARRAY ----------------------------------------------------------------------
mov r15, rdi                ;top-of-the-stack pointer (array pointer) from the caller
mov r14, rsi                ;max array size from the caller function
mov r13, 0                  ;loop counter

push qword 0
mov rax, 0
mov rdi, inputMsg           ;input message
call printf
pop rax

;---BEGIN LOOP---
next:
push qword 0
mov rax, 0
mov rdi, inputFloat
mov rsi, rsp
call scanf

cdqe
cmp rax, -1
je leave1                   ;leave if ctrl+d is pressed

mov rax, 0
mov rdi, rsp
call isfloat                ;check if input is float
mov r11, rax

cmp r11, 0
je skip                     ;disregard if input is invalid
jmp convert

skip:                       ;disregard if input is invalid
pop rax
jmp next

convert:
mov rax, 0
mov rdi, rsp
call atof                   ;convert valid input into actual float

pop rax

movsd [r15+(8*r13)], xmm0   ;load the next input in the next array index (xmm0 holds the output of atof)
inc r13

cmp r13, r14
je leave2                   ;leave if max number of inputs is reached
jmp next

leave1:
pop r12

leave2:                     ;alternatively use an x86 Assembly "if" statement instead of 2 leave lables

;---------- RETURN ----------------------------------------------------------------------
pop rbp
pop rax
mov rax, r13                ;return the current size of the array to the caller
ret

;********** END **********************************************************************