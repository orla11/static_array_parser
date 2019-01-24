%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <math.h>

    // MAX_LEN string for banner
    #define MAX_LEN 256

    // defining symbol table dimension
    int sym[100];

    extern int yylex();
    void yyerror(const char *msg);
    void emoji(int choice, int divLen);
    void banner(void);
    void print_image(FILE *fptr);
%}

%error-verbose
%token TYPE NUM ID DECIMAL

%right '='
%left '+' '-'
%left '*' '/'

%%

P:          E ';' { printf("%d\n", $1 ); } | EXPR ';' { emoji(1,0); } ;     

DEF:        TYPE MARRAY ';' 
            | EXPR ';';

MARRAY:     MARRAY ',' ID '[' NUM ']' 
            | ID '[' NUM ']';

EXPR:       ID '[' NUM ']' '=' DECIMAL | ID '[' NUM ']' '=' NUM { sym[(int)(floor(((($1+$3) - 0)/100)))] = $6 };

E:          E '-' E          { $$ = $1 - $3 }
            | E '+' E        { $$ = $1 + $3 }
            | E '*' E        { $$ = $1 * $3 }
            | E '/' E        { $$ = $1 / $3 }
            | ID '[' NUM ']' { $$ = sym[(int)(floor(((($1+$3) - 0)/100)))] }
            | NUM
            | DECIMAL;
            
%%

#include "lex.yy.c"

int main(void){
    banner();
    yyparse();
}

void yyerror(const char *msg){
    const char error[5] = {0xE2, 0x9D, 0x8C, '\0', '\0'};
    fprintf(stderr, "\a %s %s\n", error, msg);
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

    printf("- Single Definition: \t\t - Array Assignments:\n");
    printf("\tint nightmare[80]; \t\t \tbed[2] = 10;\n");
    printf("\tdouble dreams[20]; \t\t \tpillow[3] = dreams[2] + 3;\n");

    printf("- Multiple Definition: \t\t\t \trem[3] = bed[3] * pillow[2];\n");
    printf("\tdouble pillow[43], rem[10], bed[55];\n\n");
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

    const char assignment[5] = {0xF0, 0x9F, 0x92, 0xAD, '\0'};
    const char check[5] = {0xE2, 0x9C, 0x85, '\0', '\0'};
    const char error[5] = {0xE2, 0x9D, 0x8C, '\0', '\0'};
    const char divider[5] = {0xE2, 0x9E, 0x96, '\0', '\0'};
    const char rightArrow[5] = {0xE2, 0x9E, 0xA1, '\0', '\0'};
    
    switch(choice){
        case 0: // Error
            printf("%s ", error);
            break;
        case 1: // Check
            printf("\x1B[F");
            printf("\x1B[%dC", input_length + 3);
            printf("%s\n", check);
            input_length = 0;
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
    }
}