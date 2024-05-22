//********** PROGRAM INFORMATION **********************************************************************
//  Program Name: Harmonic Mean
//  Student Name: Brian Y
//  Student Email: ***

//********** MAIN CODE AREA **********************************************************************
#include <stdio.h>

extern double control();    //define external function

int main()
{
    double ret;
    printf("This is 240-5 programming final by Brian Y.\n");
    ret = control();
    printf("The main has received %12.8f and will keep it.\n", ret);
    printf("A 0 will be returned to the operating system.\n");
    printf("Have a great next semester. Bye.\n");
    return 0;
}

//********** END **********************************************************************