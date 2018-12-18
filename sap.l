%{
    int input_length;
%}    
    /* definitions */

alpha   [A-Za-z]
digit   [0-9]
char    [_]

%%
    /* rules */

[\t\n]                                                 ;
int|float|double                                       input_length += yyleng; return TYPE;        /* array types */
{digit}+                                               input_length += yyleng; return NUM;         /* array indexes */
{digit}+(\.?{digit})+                                  input_length += yyleng; return DECIMAL;     /* any number (integer, double, float) */
{alpha}(({alpha}|{digit}|{char})*({alpha}|{digit})+)*  input_length += yyleng; return ID;          /* array identifier (naming) */
"["                                                    input_length += yyleng; return yytext[0];
"]"                                                    input_length += yyleng; return yytext[0];
" "                                                    input_length += yyleng;
";"                                                    input_length += yyleng; return yytext[0];
"="                                                    input_length += yyleng; return yytext[0];
","                                                    input_length += yyleng; return yytext[0];
.                                                      return yytext[0];                           /* any other character */

%%
    /* subroutines */

int yywrap(void){
    return 1;
}