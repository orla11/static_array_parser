%{
    #include <stdlib.h>
    #include <stdio.h>
    #include "sap.tab.h"
%}

    /* definitions */

alpha   [a-z]
digit   [0-9]
char    [_]

%%
    /* rules */
    /* NOTE: If two patterns match the same string the longest match wins. */

[ \t]                                                  ; /* ignore whitespace and tabs */
[-+*=/\n]                                              return *yytext; /* match operators */
int|float|double                                       { yylval.stringValue = yytext; return TYPE; } /* match array types */
{digit}+                                               { yylval.intValue = atoi(yytext); return NUM; } /* match array indexes or integers */
{digit}+(\.?{digit})+                                  { yylval.doubleValue = atof(yytext); return DECIMAL; } /* match any decimal number (double, float) */
{alpha}                                                { yylval.intValue = *yytext - 'a'; return ID; } /* match array identifier (name) */
"["                                                    return yytext[0]; /* match [ */
"]"                                                    return yytext[0]; /* match ] */
";"                                                    return yytext[0]; /* match ; */
","                                                    return yytext[0]; /* match , */
.                                                      return yytext[0]; /* match any other character */

%%
    /* subroutines */

int yywrap(void){
    return 1;
}