%{
    #include <stdio.h>
    #include <stdlib.h>
    

    extern int yylex();
    void yyerror(char *msg);


%}

%token TYPE NUM ID DECIMAL

%right '='
%left '+' '-'
%left '*' '/'

%%

S:          S DEF | DEF
DEF:        TYPE MARRAY ';' | EXPR ';';
MARRAY:     MARRAY ',' ARRAY | ARRAY;
EXPR:       ARRAY '=' E 
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

int main(void){
    printf("Enter array definition or assignment:\n");
    yyparse();
    return 0;
}