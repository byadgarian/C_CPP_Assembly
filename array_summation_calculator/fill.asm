;****************************************************************************************************************************
;Program name: High Speed Array Summation                                                                                   *
;This program takes up to 7 floating point numbers from the user and calculates their sum after loading them into an array. *
;Copyright (C) 2021 Brian Y.                                                                                                *                                                                                                                           *
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
;  File Name: fill.asm
;  Purpose: load an array based on the passed pointer from the caller
;  Language: Assembly x86
;  Max Page width: 135 Columns
;  Compile: nasm -dwarf -f elf64 -o fill.o fill.asm

;********** MAIN CODE AREA **********************************************************************
;---------- DECLARATIONS ----------------------------------------------------------------------
;---EXTERNAL AND GLOBAL FUNCTIONS
extern printf
extern scanf
global fill

;---OTHER DECLARATIONS---
segment .data
inputMsg db "Please enter floating point numbers separated by white space.",10, "When finished press enter followed by ctrl+d.",10,0
inputFloat db "%lf",0

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

pop r12
mov [r15+(8*r13)], r12      ;load the next input in the next array index
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