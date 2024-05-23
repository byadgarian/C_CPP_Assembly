;********** LICENSE *********************************************************************************************************
;Program Name: Virtual Interview                                                                                            *
;This program takes the name and expected annual salary from an applicant and conducts a virtual interview. The outcome of  *
;the interview is determined based on the applicant's responses to interview questions.                                     *
;Copyright (C) 2021 Brian Y.                                                                                                *                                                                                                                           *
;This file is part of the software program "Virtual Interview".                                                             *
;****************************************************************************************************************************

;********** AUTHOR INFORMATION **********************************************************************
;  Author Name: Brian Y
;  Author E-mail: ***

;********** PROGRAM INFORMATION **********************************************************************
;  Program Name: Virtual Interview
;  Puropse: This program takes the name and expected annual salary from an applicant and conducts a virtual interview.
;           The outcome of the interview is determined based on the applicant's responses to interview questions.
;  Programming Languages: 1 modules in C++ and 1 module in Assembly X86
;  Date Program Began: 05/19/2021
;  Date of Last Update: 05/19/2021
;  Date of Reorganization of Comments: 0g/20/2021
;  Files in this Program: run.sh, main.cpp and interview.asm
;  Status: Finished (the program was tested using WSL2 and g++ and nasm compilers extensively with no errors)

;********** FILE INFORMATION **********************************************************************
;  File Name: interview.asm
;  Purpose: Assess applicant's responses to interview questions and submit the offer to the front desk (driver or main.cpp)
;  Language: Assembly x86
;  Max Page width: 126 Columns
;  Compile: nasm -dwarf -f elf64 -o interview.o interview.asm

;********** MAIN CODE AREA **********************************************************************
;---------- DECLARATIONS ----------------------------------------------------------------------
;---EXTERNAL AND GLOBAL FUNCTIONS
extern printf
extern scanf
global interview

;---OTHER DECLARATIONS---
segment .data
helloMsg db "Hello ",0
introMsg db ". I am Ms Fenster. The interview will begin now.",10,0
wowMsg db "Wow! $%.2lf. ",0
sawyerMsg db "That's a lot of cash. Who do you think you are, Chris Sawyer (y or n)?",10,0
majorMsg db "Were you a computer science major (y or n)?",10,0
yesNo db "%s",0
electricalMsg db "Alright. Now we will work on your electricity.",10,0
circuit1Msg db "Please enter the resistance of circuit #1 in Ohms: ",10,0
circuit2Msg db "What is the resistance of circuit #2 in Ohms: ",10,0
resistance db "%lf",0
totalResMsg db "The total resistance is 1.2 Ohms.",10,0
thankMsg db "Thank you. Please follow the exit signs to the front desk.",10,0
saywerSalary dq 1000000.00
compSciSalary dq 88000.88
socialSciSalary dq 1200.12

segment .bss

segment .text
interview:
push qword 0
push rbp
mov rbp, rsp

;---------- INTERVIEW ----------------------------------------------------------------------
mov r15, rdi                ;top-of-the-stack pointer (array pointer) from the caller function
movsd xmm15, xmm0           ;salary from the caller function

push qword 0
mov rax, 0
mov rdi, helloMsg           ;hello message
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, r15                ;print applicant name (use array address)
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, introMsg           ;introduction message
call printf
pop rax

push qword 0
mov rax, 1
mov rdi, wowMsg             ;wow message
movsd xmm0, xmm15
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, sawyerMsg          ;are you Chris Sawyer message
call printf
pop rax

push qword 0
mov rax, 1
mov rdi, yesNo              ;Chris Sawyer response
mov rsi, rsp
call scanf
pop rax

cmp rax, "y"                ;if yes, go to sawyer label
je sawyer
cmp rax, "Y"                ;if yes, go to sawyer label
je sawyer
jmp notSawyer               ;if no, go to notSaywer label

notSawyer:                  ;if not Chris Sawyer
push qword 0
mov rax, 0
mov rdi, electricalMsg      ;electrical messages
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, circuit1Msg        ;circuit #1 message
call printf
pop rax

push qword 0
mov rax, 1
mov rdi, resistance         ;resistance response
mov rsi, rsp
call scanf
movsd xmm14, [rsp]          ;store response
pop rax

push qword 0
mov rax, 0
mov rdi, circuit2Msg        ;circuit #2 message
call printf
pop rax

push qword 0
mov rax, 1
mov rdi, resistance         ;resistance response
mov rsi, rsp
call scanf
movsd xmm13, [rsp]          ;store response
pop rax

push qword 0
mov rax, 0
mov rdi, totalResMsg        ;total resistance message
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, majorMsg           ;major message
call printf
pop rax

push qword 0
mov rax, 1
mov rdi, yesNo              ;mejor response
mov rsi, rsp
call scanf
pop rax

cmp rax, "y"                ;if yes, go to compScience label
je compScience
cmp rax, "Y"                ;if yes, go to compScience label
je compScience
jmp notCompScience          ;if no, go to notCompScience label

compScience:                        ;if compScience
movsd xmm14, [compSciSalary]        ;choose good salary and store
jmp leave                           ;finish interview

notCompScience:                     ;if not compScience
movsd xmm14, [socialSciSalary]      ;choose bad salary and store
jmp leave                           ;finish interview

sawyer:                             ;if Chris Sawyer
movsd xmm14, [saywerSalary]         ;choose great salary and store

leave:                              ;finish interview
push qword 0
mov rax, 0
mov rdi, thankMsg                   ;thank you message
call printf
pop rax

;---------- RETURN ----------------------------------------------------------------------
pop rbp
pop rax
movsd xmm0, xmm14                ;return decided salary to the front desk (drive or main.cpp)
ret

;********** END **********************************************************************