/* definitions */
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
%type <doubleValue> DECIMAL
%type <intValue>    NUM
%type <stringValue> ID    
%type <doubleValue> E

/* operator precedence to avoid ambiguous grammar in BNF-like grammars (rules section) */
%right '='
%left '+' '-'
%left '*' '/'

/* rules */
%%

P:          P S '\n' | ;

S:          OP { emoji(1,0); } | RES { print_result(); empty_res();} | ;

OP:         TYPE MARRAY ';' { assign_type($<stringValue>1); }
            | EXPR ';';

MARRAY:     MARRAY ',' ARRAY { multiple_defs[$<intValue>3] = $<intValue>3; }
            | ARRAY { multiple_defs[$<intValue>1] = $<intValue>1; };

EXPR:       ID '[' NUM ']' '=' E    { check(get_index($<stringValue>1),$<intValue>3); sym[get_index($<stringValue>1)][$<intValue>3] = $<doubleValue>6; };     


E:          E '-' E          { $$ = $1 - $3; }
            | E '+' E        { $$ = $1 + $3; }
            | E '*' E        { $$ = $1 * $3; }
            | E '/' E        { $$ = $1 / $3; }
            | ID '[' NUM ']' { check(get_index($<stringValue>1),$<intValue>3); $<doubleValue>$ = sym[get_index($<stringValue>1)][$<intValue>3]; }
            | NUM            { $$ = (float)$1; }
            | DECIMAL;

RES:        ID '[' NUM ']'   { check(get_index($<stringValue>1),$<intValue>3); res_arr[0] = sym[get_index($<stringValue>1)][$<intValue>3]; res_arr[1] = get_index($<stringValue>1); }

ARRAY:      ID '[' NUM ']'   { check_double_dec(get_index($<stringValue>1),$<stringValue>1); def[get_index($<stringValue>1)] = 1; bounds[get_index($<stringValue>1)] = $<intValue>3; $<intValue>$ = get_index($<stringValue>1); };
            
%%
/* subroutines */
#include "lex.yy.c"

int main(void){
    
    int i,j;
    for(i=0;i<MAX_LEN;i++){
        multiple_defs[i] = 1111;
    }

    for(j=0;j<MAX_SYM;j++){
        const char *line = "octothorpe";
        strcpy(symbol[j],line);
    }
    
    banner();
    yyparse();
    return 0;
}