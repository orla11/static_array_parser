%{
    #include <stdlib.h>
    #include <stdio.h>
    #include "sap.tab.h"

    int input_length;

%}

    /* definitions */

alpha   [A-Za-z]
digit   [0-9]
char    [_]

%%
    /* rules */

[ \t]                                                  ;
[-+*=/\n]                                              input_length += yyleng; return *yytext;
int|float|double                                       input_length += yyleng; { yylval.stringValue = yytext; return TYPE; }         /* array types */
{digit}+                                               input_length += yyleng; { yylval.intValue = atoi(yytext); return NUM; }       /* array indexes and integers */
{digit}+(\.?{digit})+                                  input_length += yyleng; { yylval.doubleValue = atof(yytext); return DECIMAL; }   /* any number (double, float) */
{alpha}(({alpha}|{digit}|{char})*({alpha}|{digit})+)*  input_length += yyleng; { yylval.intValue = *yytext - 'a'; return ID; }       /* array identifier (naming) */
"["                                                    input_length += yyleng; return yytext[0];
"]"                                                    input_length += yyleng; return yytext[0];
";"                                                    input_length += yyleng; return yytext[0];
","                                                    input_length += yyleng; return yytext[0];
.                                                      return yytext[0];                                                     /* any other character */

%%
    /* subroutines */

int yywrap(void){
    return 1;
}