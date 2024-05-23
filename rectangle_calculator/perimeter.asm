;****************************************************************************************************************************
;Program name: Rectangle                                                                                                    *
;This program will take the hight and width of a rectangle from the user and calculate the length of average side and the   *
;perimeter. Copyright (C) 2021 Brian Y.                                                                                     *                                                                                                                           *
;This file is part of the software program "Rectangle".                                                                     *
;****************************************************************************************************************************

;********** AUTHOR INFORMATION **********************************************************************
;  Author Name: Brian Y
;  Author E-mail: ***

;********** PROGRAM INFORMATION **********************************************************************
;  Program Name: Rectangle
;  Programming Languages: One modules in C and one module in Assembly X86
;  Date Program Began: 01/25/2021
;  Date of Last Update: 02/09/2021
;  Date of Reorganization of Comments: 02/09/2021
;  Files in this Program: rectangle.c, perimeter.asm
;  Status: Finished (the program was tested using WSL2 and gcc and nasm compilers extensively with no errors)

;********** FILE INFORMATION **********************************************************************
;  File Name: perimeter.asm
;  Language: Assembly X86 with Intel Syntax
;  Max Page width: 153 Columns
;  Assemble: nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm

;********** MAIN CODE AREA **********************************************************************
extern printf                   ;access external Function
extern scanf
global perimeter                ;allow global access to function

segment .data                   ;declare strings
welcome db "This program will compute the perimeter and the average side length of a rectangle.",10,0
goodbye db "The assembly program will send the perimeter to the main function.",10,0
hight db "Enter the height of the rectangle: ",0
width db "Enter the width of the rectangle: ",0
sixty4bit_float_1 db "%lf",0    ;%lf is the universal symbol for 64 bit float
sixty4bit_float_2 db "%lf",0
output_prm db "The perimeter is %5.3lf",10,0
output_avg db "The length of the average side is %5.3lf",10,0
const dq 2.0                    ;constant number used for arithmetic

segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions

perimeter:                      ;global function
;---------- Welcome Message ----------------------------------------------------------------------
push qword 0                ;sometimes necessary to correct the RSP off boundry problem (refer to week 2 notes)
mov rax, 0                  ;0 means printf uses no floats (no xmm registers)
mov rdi, welcome            ;"This program will..."
call printf
pop rax

;---------- Hight Input Prompt ----------------------------------------------------------------------
mov rax, 0
mov rdi, hight                  ;"Enter the height of the rectangle: "
call printf

;---------- Hight scanf ----------------------------------------------------------------------
push qword 0                    ;push a 64 bit block of 0's (4 bytes) to the top of the stack
mov rax, 1                      ;tells scanf to expect 1 float (number of xmm registers)
mov rdi, sixty4bit_float_1      ;tells scanf to expect a 64 bit float
mov rsi, rsp                    ;rsp is the pointer to the top of the stack but scanf can’t use it so another pointer is introduced
call scanf
movsd xmm15, [rsp]              ;place the content of the qword (top of the stack) into xmm15 register (dereferencing using [] because rsp is a pointer)
;movsd xmm13, xmm15              ;back up xmm15 in xmm13 for future access after pop
pop rax                         ;pop qword from the top of the stack

;---------- Width Input Prompt ----------------------------------------------------------------------
mov rax, 0
mov rdi, width                  ;"Enter the width of the rectangle: "
call printf

;---------- Width scanf ----------------------------------------------------------------------
push qword 0
mov rax, 1
mov rdi, sixty4bit_float_2
mov rsi, rsp
call scanf
movsd xmm14, [rsp]
;movsd xmm12, xmm14              ;back up xmm14 in xmm12 for future access after pop
pop rax

;---------- Calculate Perimeter ----------------------------------------------------------------------
movsd xmm10, xmm14          ;preserve original width value in xmm12
movsd xmm11, xmm15          ;preserve original hight value in xmm13
mulsd xmm10, [const]        ;multiply xmm10 by the value of const (number "2") - const is dereferenced
mulsd xmm11, [const]
addsd xmm10, xmm11          ;add xmm10 and xmm11

;---------- Display Perimeter ----------------------------------------------------------------------
push qword 0
mov rax, 1                  ;number of floats printf will access (number of xmm registers)
mov rdi, output_prm         ;"The perimeter is..."
movsd xmm0, xmm10           ;move xmm10 content to xmm0 because printf can't access other registers
movsd xmm11, xmm10          ;back up the perimeter in xmm11 to return to caller (rectangle.c) at the end
call printf
pop rax

;---------- Calculate Avrage Length ----------------------------------------------------------------------
movsd xmm10, xmm14          ;preserve original width value in xmm12
addsd xmm10, xmm15          ;add xmm10 and xmm13
divsd xmm10, [const]        ;devide xmm10 by the value of const (number "2") - const is dereferenced

;---------- Display Average Lenght ----------------------------------------------------------------------
push qword 0
mov rax, 1
mov rdi, output_avg         ;"The length of the average side is..."
movsd xmm0, xmm10
call printf
pop rax

;********** EXIT **********************************************************************
;---------- Goodby Message ----------------------------------------------------------------------
mov rax, 0
mov rdi, goodbye            ;"The assembly program will..."
call printf

;---------- Return to Main Function ----------------------------------------------------------------------
movsd xmm0, xmm11            ;return the content of xmm11 to the main function in rectangle.c - refer to line #102
ret

;********** END **********************************************************************