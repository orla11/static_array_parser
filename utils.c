#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "utils.h"

// MAX_LEN string for banner, 
// symbol table, semantic-check utils arrays
#define MAX_LEN 256

void yyerror(const char *msg){
    const char error[5] = {0xE2, 0x9D, 0x8C, '\0', '\0'};
    fprintf(stderr, "\a %s %s \n", error, msg);
}

void banner(void) {
    char *filename = "header.txt";
    FILE *fptr = NULL;

    if((fptr = fopen(filename, "r")) == NULL) {
        fprintf(stderr, "error opening %s\n", filename);
    }

    printf("\n");
    print_image(fptr);
    printf("\n\n");
    emoji(3,39);

    printf("\n\n");
    printf("- Allowed Types: \t\t - Aritmetic Operations: + - * /\n");
    printf("\t int, float, double\n");

    printf("\nExamples: \n\n");
    printf("- Single Definition: \t\t - Array Assignments:\n");
    printf("\tint a[80]; \t\t \tb[2] = 10;\n");
    printf("\tdouble c[20]; \t\t \tx[3] = r[2] + 3;\n");

    printf("- Multiple Definition: \t\t \tm[3] = b[3] * x[2];\n");
    printf("\tfloat x[43], h[10], f[55];\n\n");
    emoji(3,21);

    printf("\n");
    emoji(4,0);
    printf("Enter array definition or assignment:");
    emoji(2,0);
    printf("\n");
    emoji(3,21);
    printf("\n");

    fclose(fptr);
}

void print_image(FILE *fptr){
    char read_string[MAX_LEN];

    while(fgets(read_string, sizeof(read_string),fptr) != NULL){
        printf("%s", read_string);
    }
}

void emoji(int choice, int divLen){   

    const char assignment[5]    =  {0xF0, 0x9F, 0x92, 0xAD, '\0'};
    const char check[5]         =  {0xE2, 0x9C, 0x85, '\0', '\0'};
    const char checkv2[5]       =  {0xE2, 0x9C, 0x94, '\0', '\0'};
    const char error[5]         =  {0xE2, 0x9D, 0x8C, '\0', '\0'};
    const char divider[5]       =  {0xE2, 0x9E, 0x96, '\0', '\0'};
    const char rightArrow[5]    =  {0xE2, 0x9E, 0xA1, '\0', '\0'};
    const char result[5]        =  {0xE2, 0x8F, 0xA9, '\0', '\0'};
    const char resultv2[5]      =  {0xE2, 0x9E, 0xA1, '\0', '\0'};
    
    switch(choice){
        case 0: // Error
            printf("%s ", error);
            break;
        case 1: // Check
            printf("\x1B[F");
            //printf("\x1B[%dC", input_length + 5);
            printf("\x1B[%dC", 40);
            printf("%s\n", checkv2);
            //input_length = 0;
            break;
        case 2: // Assignment
            printf(" %s ", assignment);
            break;
        case 3: // Divider
            for(int i = 0; i < divLen; i++){
                printf("%s", divider);
            }
            break;
        case 4: // Right Arrow
            printf("%s ", rightArrow);
            break;
        case 5: // Result
            printf("\x1B[F");
            //printf("\x1B[%dC", input_length + 3);
            printf("\x1B[%dC", 40);
            printf("%s", resultv2);
            printf("\x1B[2C");
            //input_length = 0;
            break;
    }
}

void print_result(){
    emoji(5,0);

    switch (type[(int)res_arr[1]]){
        case 1:
            printf("%d\n", (int)res_arr[0]);
            break;
        case 2:
            printf("%.02f\n", (float)res_arr[0]);
            break;
        case 3:
            printf("%.03f\n", (float)res_arr[0]);
            break;
        default:
            break;
    }

}

void check(int ref, int index){
    const char error[5] = {0xE2, 0x9D, 0x8C, '\0', '\0'};
    if(def[ref] != 1){
        printf("\a %s Error: undeclared array.\n", error);
        exit(1);
    }
    if(index >= bounds[ref] || index < 0){
        printf("\a %s Error: index %d out of bounds.\n", error, index);
        exit(1);
    }
}

void check_double_dec(int ref){
    const char error[5] = {0xE2, 0x9D, 0x8C, '\0', '\0'};
    if(dec[ref] == 1){
        printf("\a %s Error: array previously declared.\n", error);
        exit(1);
    }else{
        dec[ref] = 1;
    }
}

void assign_type(int refs[], char *string){

    char *int_type = "int";
    char *float_type = "float";

    int i;
    unsigned int result;

    if(strcasestr(string,int_type) != NULL){
        result = 1; // int
    }else if(strcasestr(string,float_type) != NULL){
        result = 2; // float
    }else{
        result = 3; // double
    }

    for(i=0;i<MAX_LEN;i++){
        if(multiple_defs[i] != 1111){
            type[i] = result;
        }
    }

}

void empty_res(){
    res_arr[0] = 0;
    res_arr[1] = 0;
}