%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <math.h>
    #include "utils.h"

    extern int yylex();
%}

%union
{
    int intValue;
    double doubleValue;
    char *stringValue;
}

%error-verbose
%token TYPE NUM ID DECIMAL

%type <stringValue> TYPE
%type <doubleValue>  DECIMAL
%type <intValue>    NUM
%type <intValue>    ID    
%type <doubleValue>  E

%right '='
%left '+' '-'
%left '*' '/'

%%
P:          P S '\n'
            |
            ;

S:          DEF { emoji(1,0); } | RES { print_result(); empty_res();} | ;

DEF:        TYPE MARRAY ';' { assign_type(multiple_defs,$<stringValue>1); }
            | EXPR ';';

MARRAY:     MARRAY ',' ARRAY { multiple_defs[$<intValue>3] = $<intValue>3; }
            | ARRAY { multiple_defs[$<intValue>1] = $<intValue>1; };

EXPR:       ID '[' NUM ']' '=' E    { check($1,$<intValue>3); sym[$1][$<intValue>3] = $<doubleValue>6; };     


E:          E '-' E          { $$ = $1 - $3; }
            | E '+' E        { $$ = $1 + $3; }
            | E '*' E        { $$ = $1 * $3; }
            | E '/' E        { $$ = $1 / $3; }
            | ID '[' NUM ']' { check($1,$<intValue>3); $<doubleValue>$ = sym[$1][$<intValue>3]; }
            | NUM            { $$ = (float)$1; }
            | DECIMAL;

RES:        ID '[' NUM ']'   { check($1,$<intValue>3); res_arr[0] = sym[$1][$<intValue>3]; res_arr[1] = $1; }

ARRAY:      ID '[' NUM ']'   { check_double_dec($<intValue>1); def[$1] = 1; bounds[$1] = $<intValue>3; $<intValue>$ = $1; };
            
%%

#include "lex.yy.c"

int main(void){
    
    int i;
    for(i=0;i<MAX_LEN;i++){
        multiple_defs[i] = 1111;
    }
    
    banner();
    yyparse();
    return 0;
}