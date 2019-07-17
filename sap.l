%{
    #include <stdlib.h>
    #include <stdio.h>
    #include "sap.tab.h"

    int input_length;
%}

    /* definitions */

alpha   [a-z]
digit   [0-9]
char    [_]

%%
    /* rules */
    /* NOTE: If two patterns match the same string the longest match wins. */

[ \t]                                                  ; /* ignore whitespace and tabs */
[-+*=/\n]                                              input_length += yyleng; return *yytext; /* match operators */
int|float|double                                       input_length += yyleng; { yylval.stringValue = yytext; return TYPE; } /* match array types */
{digit}+                                               input_length += yyleng; { yylval.intValue = atoi(yytext); return NUM; } /* match array indexes or integers */
{digit}+(\.?{digit})+                                  input_length += yyleng; { yylval.doubleValue = atof(yytext); return DECIMAL; } /* match any decimal number (double, float) */
{alpha}                                                input_length += yyleng; { yylval.intValue = *yytext - 'a'; return ID; } /* match array identifier (name) */
"["                                                    input_length += yyleng; return yytext[0]; /* match [ */
"]"                                                    input_length += yyleng; return yytext[0]; /* match ] */
";"                                                    input_length += yyleng; return yytext[0]; /* match ; */
","                                                    input_length += yyleng; return yytext[0]; /* match , */
.                                                      return yytext[0]; /* match any other character */

%%
    /* subroutines */

int yywrap(void){
    return 1;
}