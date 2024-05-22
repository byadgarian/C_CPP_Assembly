//********** AUTHOR INFORMATION **********************************************************************
//  Author Name: Brian Y
//  Author E-mail: ***

//********** MAIN CODE AREA **********************************************************************
#include <stdio.h>

extern double resistance();              //declare function for external access

int main()
{
    double res = 0.0;
    printf("Welcome to the Electric Resistance Calculator programmed by Brian Y.\n");
    res = resistance();                  //call resistance function from the .asm file
    printf("The Electricity module received the resistance %4.2lf Ω and will keep it.\n", res);
    printf("Have a very nice evening. The Electricity module will now return 0 to the operating system. Bye!\n");
    return 0;
}

//********** END **********************************************************************