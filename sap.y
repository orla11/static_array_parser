%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%token TYPE NUM IDX IDX

%right '='
%left '+' '-'
%left '*' '/'

%%

S:          DEF { printf("Input accepted\n"); exit(0); }
DEF:        TYPE MARRAY;
MARRAY:     MARRAY ',' ARRAY | ARRAY | ;
ARRAY:      ID '[' IDX ']' | ;
E:          ARRAY '=' E 
            | E '-' E 
            | E '+' E 
            | E '*' E 
            | E '/' E 
            | ARRAY
            | NUM
            | ID;

%%

#include "lex.yy.c"

int main(void){
    printf("Enter array definition or assignment:\n");
    yyparse();
    return 0;
}