;****************************************************************************************************************************
;Program name: Root Calculator                                                                                              *
;This program will take 3 coefficients of a quadratic equation from the user and calculate it's roots.                      *
;Copyright (C) 2021 Brian Y.                                                                                                *                                                                                                                           *
;This file is part of the software program "Second Degree".                                                                 *
;****************************************************************************************************************************

;********** AUTHOR INFORMATION **********************************************************************
;  Author Name: Brian Y
;  Author E-mail: ***

;********** PROGRAM INFORMATION **********************************************************************
;  Program Name: Root Calculator
;  Programming Languages: 3 modules in C++ and 1 module in Assembly X86
;  Date Program Began: 02/20/2021
;  Date of Last Update: 02/28/2021
;  Date of Reorganization of Comments: 02/28/2021
;  Files in this Program: second_degree.cpp, quad_library.cpp, isfloat.cpp and quadratic.asm
;  Status: Finished (the program was tested using WSL2, and g++ and nasm compilers extensively with no errors)

;********** FILE INFORMATION **********************************************************************
;  File Name: quadratic.asm
;  Language: Assembly X86 with Intel Syntax
;  Max Page width: 178 Columns
;  Assemble: -f elf64 -o quadratic.o quadratic.asm

;********** NOTE **********************************************************************
; Since the size of a double floating point is 64 bits, I have limited the number of input digits to 7 (7 + 1 null = 8).
; If any of the 3 inputs contain more than 8 digits (including '+', '-', and '.') the program will end with an error message.

;********** MAIN CODE AREA **********************************************************************
;---------- DECLARATIONS ----------------------------------------------------------------------
;---EXTERNAL AND GLOBAL FUNCTIONS
extern printf
extern scanf
extern isfloat
extern atof
extern showTwoRoots
extern showOneRoot
extern showNoRoots
global quadratic

;---OTHER DECLARATIONS---
segment .data
welcomeMsg db "This program will find the roots of any quadratic equation.",10,0
errorMsg db "At least one of the inputs is invalid. Please re-run the program and try again. Thank you.",10,0
goodbyeMsg db "One of the roots will be returned to the caller function (second_degree.cpp).",10,0
input db "Please enter the three floating point coefficients of a quadratic equation in the order a, b, c separated by the end of line character (maximum of 7 digits per input): ",0
equation db "Thank you! The equation is %lfx^2 + %lfx + %lf",10,0
string db "%s",0                    ;64 bit string

;--constants for arthmetic operations
const1 dq 4.0
const2 dq 0.0
const3 dq -1.0
const4 dq 2.0

segment .bss

segment .text
quadratic:
;---------- INPUT PROMPT ----------------------------------------------------------------------
push qword 0
mov rax, 0
mov rdi, input
call printf
pop rax

;---------- SCAN, VALIDATE & CONVERT INPUTS ----------------------------------------------------------------------
;---BEGIN LOOP---
mov r15, 0                  ;counter for the main loop
next:                       ;scan, validate and convert next input

;---SCAN---
push qword 0
mov rax, 0
mov rdi, string
mov rsi, rsp
call scanf

;---VALIDATE---
mov rax, 0
mov rdi, rsp                ;rdi is the first argument to be passed - move top of the stack content to rdi
call isfloat                ;call validation funciton
mov r14, rax                ;move the returned value to r14

cmp r14, 0                  ;if input is invalid display an error message and terminate the program
je error

;---CONVERT & CONTINUE SCANNING---
mov rax, 0
mov rdi, rsp                ;rdi is the first argument to be passed - move top of the stack content to rdi
call atof                   ;call atof function to convert string to floating point

;--check which register is next to be populated
cmp r15, 0                  ;if first input, copy to xmm15
je reg15
cmp r15, 1                  ;if second input, copy to xmm14
je reg14
cmp r15, 2                  ;if third input, copy to xmm13
je reg13
jmp continue1               ;one of the cases must be ture - this can be removed

reg15:
movsd xmm15, xmm0           ;copy the returned value from atof to xmm15
pop rax
inc r15                     ;update the counter
jmp next                    ;start over
reg14:
movsd xmm14, xmm0
pop rax
inc r15
jmp next
reg13:
movsd xmm13, xmm0
pop rax

;---------- DISPLAY INPUTS ----------------------------------------------------------------------
continue1:
push qword 0
mov rax, 3
mov rdi, equation
movsd xmm0, xmm15
movsd xmm1, xmm14
movsd xmm2, xmm13
call printf
pop rax

;---------- CALCULATE & DISPLAY ROOTS ----------------------------------------------------------------------
;--BACK UP INPUTS---
movsd xmm12, xmm15                  ;save the input for future use
movsd xmm11, xmm14
movsd xmm10, xmm13

;---CALCULATE DELTA---
mulsd xmm14, xmm14                  ;b^2
mulsd xmm15, [const1]               ;4a
mulsd xmm15, xmm13                  ;4ac
subsd xmm14, xmm15                  ;delta

;---CHECK NUMBER OF ROOTS---
ucomisd xmm14, [const2]             ;compare delta to 0
ja twoRoots                         ;delta > 0
je oneRoot                          ;delta = 0
jb noRoots                          ;delta < 0

;---CALCULATE & DISPLAY ROOTS---
jmp continue2
twoRoots:
;--calculate first root
sqrtsd xmm14, xmm14                 ;square root of delta
movsd xmm10, xmm11                  ;b is backed up in xmm10
mulsd xmm11, [const3]               ;-b
addsd xmm11, xmm14                  ;-b + sqert(delta)
mulsd xmm12, [const4]               ;2a
divsd xmm11, xmm12                  ;-b + sqert(delta) / 2a     (first root is in xmm11)

;--claculate second root
mulsd xmm10, [const3]               ;-b
subsd xmm10, xmm14                  ;-b - sqert(delta)
divsd xmm10, xmm12                  ;-b + sqert(delta) / 2a     (second root is in xmm10)

;--display the two roots
push qword 0
mov rax, 2
movsd xmm0, xmm11
movsd xmm1, xmm10
call showTwoRoots
pop rax

jmp continue2
oneRoot:
;--calculate the root
sqrtsd xmm14, xmm14                 ;square root of delta
mulsd xmm11, [const3]               ;-b
addsd xmm11, xmm14                  ;-b + sqert(delta)
mulsd xmm12, [const4]               ;2a
divsd xmm11, xmm12                  ;-b + sqert(delta) / 2a     (the root ins xmm11)

;--display one root
push qword 0
mov rax, 1
movsd xmm0, xmm11
call showOneRoot
pop rax

jmp continue2
noRoots:
movsd xmm11, [const2]               ;copy 0.0 into xmm11 to be returned to caller function if no roots
;--display no roots
push qword 0
mov rax, 0
call showNoRoots
pop rax
jmp continue4

;---------- SHOW MESSAGES & RETURN ----------------------------------------------------------------------
continue2:
jmp continue3
error:
pop rax                     ;this was not popped yet when the error occured
push qword 0
mov rax, 0
mov rdi, errorMsg
call printf
pop rax
jmp continue4

continue3:
;---END MESSAGE---
push qword 0
mov rax, 0
mov rdi, goodbyeMsg
call printf
pop rax

continue4:
;---RETURN---
movsd xmm0, xmm11
ret

;********** END **********************************************************************