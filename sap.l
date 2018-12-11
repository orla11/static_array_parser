    /* definitions */

alpha   [A-Za-z]
digit   [0-9]
char    [_]

%%
    /* rules */

[\t\n]                                              ;
int|float|double                                    return TYPE;        /* array types */
{digit}+                                            return IDX;         /* array indexes */
{digit}+(\.{digit})?                                return NUM;         /* any number (integer, double, float) */
{alpha}({alpha}|{digit}|_)*({alpha}|{digit})+\S     return ID;          /* array identifier (naming) */
.                                                   return yytext[0];   /* any other character */

%%
    /* subroutines */

int yywrap(void){
    return 1;
}