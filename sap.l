    /* definitions */

alpha   [A-Za-z]
digit   [0-9]
char    [_]

%%
    /* rules */

[ \t\n]                                                 ;
int|float|double                                        return TYPE;        /* array types */
{digit}+                                                return NUM;         /* array indexes */
{digit}+(\.?{digit})+                                   return DECIMAL;         /* any number (integer, double, float) */
{alpha}(({alpha}|{digit}|{char})*({alpha}|{digit})+)*   return ID;          /* array identifier (naming) */
.                                                       return yytext[0];   /* any other character */

%%
    /* subroutines */

int yywrap(void){
    return 1;
}