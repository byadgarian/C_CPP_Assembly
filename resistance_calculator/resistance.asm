;********** AUTHOR INFORMATION **********************************************************************
;  Author Name: Brian Y
;  Author E-mail: ***

;********** MAIN CODE AREA **********************************************************************
extern printf                       ;access external Function
extern scanf
global resistance                   ;allow global access to function

segment .data                       ;declare strings
goodbye db "The total resistance will be returned to the caller (Electricity) module.",10,0
input db "Please enter the resistance numbers of the 3 subcircuits separated by white space and press enter: ",0
sixty4bit_floats db "%lf%lf%lf",0   ;%lf is the universal symbol for 64 bit float
received db "These resistances were received: %4.2lf Ω, %4.2lf Ω, %4.2lf Ω",10,0
output db "The resistance of the entire circuit is %4.2lf Ω",10,0
const dq 1.0                        ;constant number used for arithmetic operations

segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions

resistance:                         ;global function
;---------- Resistance Input Prompt ----------------------------------------------------------------------
push qword 0
mov rax, 0
mov rdi, input
call printf
pop rax

;---------- Resistance scanf ----------------------------------------------------------------------
push qword 0                    ;push a 64 bit block of 0's (4 bytes) to the top of the stack
push qword 0
push qword 0
mov rax, 0
mov rdi, sixty4bit_floats       ;tells scanf to expect 3 64 bit floats
mov rsi, rsp                    ;rsp is the pointer to the top of the stack but scanf can’t use it so another pointer is introduced
mov rdx, rsp
mov rcx, rsp
add rdx, 8
add rcx, 16
call scanf
movsd xmm15, [rsp]              ;place the content of the qword (top of the stack) into xmm15 register (dereferencing using [] because rsp is a pointer)
movsd xmm14, [rsp+8]
movsd xmm13, [rsp+16]
pop rax                         ;pop qword from the top of the stack
pop rax
pop rax

;---------- Display the Input ----------------------------------------------------------------------
push qword 0
mov rax, 3                      ;tell printf to expect 3 floats
mov rdi, received
movsd xmm0, xmm15               ;move xmm15 content to xmm0 because printf can't access other registers
movsd xmm1, xmm14               ;now higher xmm registers can be beused for printf
movsd xmm2, xmm13
call printf
pop rax

;---------- Calculate Total Resistance ----------------------------------------------------------------------
movsd xmm12, [const]        ;const is 1.0 - const is dereferenced
divsd xmm12, xmm15          ;divide xmm15 by the value of const (number "1") - save in xmm12
movsd xmm11, [const]
divsd xmm11, xmm14
movsd xmm10, [const]
divsd xmm10, xmm13
addsd xmm11, xmm12          ;add xmm11 and xmm12 - save in xmm11
addsd xmm11, xmm10
movsd xmm10, [const]        ;xmm10 is now free to be used again to keep a constant value
divsd xmm10, xmm11          ;xmm10 now contains the final value of resistance (1/R)

;---------- Display Total Resistance ----------------------------------------------------------------------
push qword 0
mov rax, 1                  ;tell printf to expect 3 floats
mov rdi, output
movsd xmm0, xmm10
call printf
pop rax

;********** EXIT **********************************************************************
;---------- Goodby Message ----------------------------------------------------------------------
push qword 0
mov rax, 0
mov rdi, goodbye
call printf
pop rax

;---------- Return to Main Function ----------------------------------------------------------------------
movsd xmm0, xmm10            ;return the content of xmm10 to the main function in electricity.c - refer to line #78
ret

;********** END **********************************************************************