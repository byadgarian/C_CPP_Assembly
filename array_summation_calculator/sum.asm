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
;  File Name: sum.asm
;  Purpose: add up all the array indices and return the sum to the caller
;  Language: Assembly x86
;  Max Page width: 135 Columns
;  Compile: nasm -dwarf -f elf64 -o sum.o sum.asm

;********** MAIN CODE AREA **********************************************************************
;---------- DECLARATIONS ----------------------------------------------------------------------
;---EXTERNAL AND GLOBAL FUNCTIONS
extern printf
extern scanf
global sum

;---OTHER DECLARATIONS---
segment .data

;--constants for arthmetic operations
const dq 0.0

segment .bss

segment .text
sum:
push qword 0
push rbp
mov rbp, rsp
;---------- ADD UP ARRAY INDICES ----------------------------------------------------------------------
mov r15, rdi                    ;top-of-the-stack pointer (array pointer) from the caller
mov r14, rsi                    ;max array size from the caller function
mov r13, 0                      ;loop counter
movsd xmm15, [const]            ;initialize xmm15 (alternatively use cvtsi2sd)

;---BEGIN LOOP---
next:
addsd xmm15, [r15+(8*r13)]      ;add up all array indices
inc r13

cmp r13, r14
je leave                        ;leave if all the array indices have been added up
jmp next

leave:

;---------- RETURN ----------------------------------------------------------------------
movsd xmm0, xmm15               ;return the sum to the caller
pop rbp
pop rax
ret

;********** END **********************************************************************