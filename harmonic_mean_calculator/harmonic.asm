;********** PROGRAM INFORMATION **********************************************************************
;  Program Name: Harmonic Mean
;  Student Name: Brian Y
;  Student Email: ***

;********** MAIN CODE AREA **********************************************************************
;---------- DECLARATIONS ----------------------------------------------------------------------
;---EXTERNAL AND GLOBAL FUNCTIONS
extern printf
extern scanf
global harmonic

;---OTHER DECLARATIONS---
segment .data

;--constants for arthmetic operations
const dq 0.0
const2 dq 1.0

segment .bss

segment .text
harmonic:
push qword 0
push rbp
mov rbp, rsp
;---------- CALCULATE THE HARMONIC MEAN ----------------------------------------------------------------------
mov r15, rdi                    ;top-of-the-stack pointer (array pointer) from the caller
mov r14, rsi                    ;current array size from the caller function
mov r13, 0                      ;loop counter
movsd xmm15, [const]            ;initialize xmm15 (alternatively use cvtsi2sd)

;---BEGIN LOOP---
next:
movsd xmm14, [const2]           
divsd xmm14, [r15+(8*r13)]      ;compute the reciprocals
addsd xmm15, xmm14              ;add the reciprocals
inc r13

cmp r13, r14
je leave                        ;leave if all the array indices have been accounted for
jmp next

leave:
cvtsi2sd xmm13, r13             ;convert the current array size to float
divsd xmm13, xmm15

;---------- RETURN ----------------------------------------------------------------------
movsd xmm0, xmm13               ;return the harmonic mean to the caller
pop rbp
pop rax
ret

;********** END **********************************************************************