;********** PROGRAM INFORMATION **********************************************************************
;  Program Name: Harmonic Mean
;  Student Name: Brian Y
;  Student Email: ***

;********** MAIN CODE AREA **********************************************************************
;---------- DECLARATIONS ----------------------------------------------------------------------
;---EXTERNAL AND GLOBAL FUNCTIONS
extern printf
extern scanf
extern fill
extern display
extern harmonic
global control

;---OTHER DECLARATIONS---
segment .data
displayMsg db "The numbers you entered are these:",10,0
harmMsg db "The harmonic mean of these values is %lf.",10,0
leaveMsg db "The Control module will now return the harmonic mean to the caller module.",10,0
inputFloat db "%lf",0

segment .bss

segment .text
control:
push qword 0            ;prevent off-boundary address issue
push rbp                ;save the buttom-of-the-stack pointer from the caller stack block
mov rbp, rsp            ;make the current top-of-the-stack the buttom of the callee stack block

;---------- CALL EXTERNAL FUNCTIONS ----------------------------------------------------------------------
push qword 0
sub rsp, 128            ;reserve 16 bytes for the the array (up 16 inputs/indices)
mov rax, 0
mov rdi, rsp            ;pass the current top-of-the-stack (array pointer) to the callee
mov rsi, 7              ;pass the max size of the array to the callee
call fill
mov r13, rax            ;save the current size of the array after return (r13 is over-written)
;pop rax

;push qword 0
mov rax, 0
mov rdi, displayMsg     ;display message
call printf
;pop rax

;push qword 0
mov rax, 0
mov rdi, rsp            ;pass the current top-of-the-stack (array pointer) to the callee
mov rsi, r13            ;pass the current size of the array to the callee
call display
;mov r14, rax           ;not necessary because display function is a void function
;pop rax

;push qword 0
mov rax, 0
mov rdi, rsp            ;pass the current top-of-the-stack (array pointer) to the callee
mov rsi, r13            ;pass the current size of the array to the callee
call harmonic
movsd xmm15, xmm0       ;save the returned harmonic mean
pop rax
add rsp, 128            ;restore the reserved 16 bytes

;---------- SHOW MESSAGES & RETURN ----------------------------------------------------------------------
push qword 0
mov rax, 1
mov rdi, harmMsg        ;harmonic message
movsd xmm0, xmm15
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, leaveMsg       ;leave message
call printf
pop rax

movsd xmm0, xmm15       ;return the harmonic mean to the caller
pop rbp                 ;restore to buttom-of-the-stack pointer from the caller stack block
pop rax                 ;prevent off-boundary address issue (undo)
ret

;********** END **********************************************************************