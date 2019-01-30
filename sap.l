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
int|float|double                                       input_length += yyleng; return TYPE;                             /* array types */
{digit}+                                               input_length += yyleng; { yylval = atoi(yytext); return NUM; }   /* array indexes */
{digit}+(\.?{digit})+                                  input_length += yyleng; { yylval = atof(yytext); 
                                                                                 if(yylval == (int)atof(yytext)) { yylval = (int)yylval; }
                                                                                 return DECIMAL; }                      /* any number (integer, double, float) */
{alpha}(({alpha}|{digit}|{char})*({alpha}|{digit})+)*  input_length += yyleng; { yylval = *yytext - 'a';
                                                                                 return ID; }                           /* array identifier (naming) */
"["                                                    input_length += yyleng; return yytext[0];
"]"                                                    input_length += yyleng; return yytext[0];
";"                                                    input_length += yyleng; return yytext[0];
","                                                    input_length += yyleng; return yytext[0];
.                                                      return yytext[0];                                                /* any other character */

%%
    /* subroutines */

int yywrap(void){
    return 1;
}