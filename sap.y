%{
    #include <stdio.h>
    #include <stdlib.h>

    #define MAX_LEN 256

    extern int yylex();
    void yyerror(char *msg);
%}

%token TYPE NUM ID DECIMAL

%right '='
%left '+' '-'
%left '*' '/'

%%

S:          S DEF | DEF   {printf("Input accepted\n");exit(0);};              
DEF:        TYPE MARRAY ';' | EXPR ';';
MARRAY:     MARRAY ',' ARRAY | ARRAY;
EXPR:       ARRAY '=' E;
E:          E '-' E 
            | E '+' E 
            | E '*' E 
            | E '/' E 
            | ARRAY
            | NUM
            | DECIMAL
            | ID;
ARRAY:      ID '[' NUM ']';

%%

#include "lex.yy.c"

void header(void);
void print_image(FILE *fptr);

int main(void){
    header();
    printf("\nEnter array definition or assignment:\n");
    yyparse();
}

void yyerror(char *msg){
    fprintf(stderr, "%s\n", msg);
    exit(1);
}

void header(void) {
    char *filename = "header.txt";
    FILE *fptr = NULL;

    if((fptr = fopen(filename, "r")) == NULL) {
        fprintf(stderr, "error opening %s\n", filename);
        exit(1);
    }

    print_image(fptr);

    fclose(fptr);
}

void print_image(FILE *fptr){
    char read_string[MAX_LEN];

    while(fgets(read_string, sizeof(read_string),fptr) != NULL){
        printf("%s", read_string);
    }
}