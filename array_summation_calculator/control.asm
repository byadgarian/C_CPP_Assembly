;****************************************************************************************************************************
;Program name: High Speed Array Summation                                                                                   *
;This program takes up to 7 floating point numbers from the user and calculates their sum after loading them into an array. *
;Copyright (C) 2021 Brian Y.                                                                                      *                                                                                                                           *
;This file is part of the software program "High Speed Array Summation".                                                    *
;High Speed Array Summation is a free software. You can redistribute it and/or modify it under the terms of the GNU General *
;Public                                                                                                                     *
;License version 3 as published by the Free Software Foundation.                                                            *
;High Speed Array Summation is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the   *
;implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more       *
;details.                                                                                                                   *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************

;********** AUTHOR INFORMATION **********************************************************************
;  Author Name: Brian Y
;  Author E-mail: ***

;********** PROGRAM INFORMATION **********************************************************************
;  Program Name: High Speed Array Summation
;  Puropse: This program takes up to 7 floating point numbers from the user and calculates their sum after loading them into an array.
;  Programming Languages: 1 modules in C, 1 module in C++ and 3 module in Assembly X86
;  Date Program Began: 03/10/2021
;  Date of Last Update: 03/22/2021
;  Date of Reorganization of Comments: 03/22/2021
;  Files in this Program: run.sh, main.c, contorl.asm, fill.asm, display.cpp and sum.asm
;  Status: Finished (the program was tested using WSL2 and g, g++ and nasm compilers extensively with no errors)

;********** FILE INFORMATION **********************************************************************
;  File Name: control.asm
;  Purpose: call different functions
;  Language: Assembly x86
;  Max Page width: 135 Columns
;  Compile: nasm -dwarf -f elf64 -o control.o control.asm

;********** MAIN CODE AREA **********************************************************************
;---------- DECLARATIONS ----------------------------------------------------------------------
;---EXTERNAL AND GLOBAL FUNCTIONS
extern printf
extern scanf
extern fill
extern display
extern sum
global control

;---OTHER DECLARATIONS---
segment .data
fillMsg db "Welcome to HSAS. The accuracy and reliability of this program is guaranteed by Brian Y.",10,0
displayMsg db "The numbers you entered are these:",10,0
sumMsg db "The sum of these values is %lf.",10,0
leaveMsg db "The Control module will now return the sum to the caller module.",10,0
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
mov rsi, 7              ;pass the current size of the array to the callee
call sum
movsd xmm15, xmm0       ;save the returned sum
pop rax
add rsp, 128            ;restore the reserved 16 bytes

;---------- SHOW MESSAGES & RETURN ----------------------------------------------------------------------
push qword 0
mov rax, 1
mov rdi, sumMsg         ;sum message
movsd xmm0, xmm15
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, leaveMsg       ;leave message
call printf
pop rax

movsd xmm0, xmm15       ;return the sum to the caller
pop rbp                 ;restore to buttom-of-the-stack pointer from the caller stack block
pop rax                 ;prevent off-boundary address issue (undo)
ret

;********** END **********************************************************************