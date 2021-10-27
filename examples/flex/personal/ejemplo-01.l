%{
/* Detecta e imprime los números enteros */
#include <stdio.h>
%}

%option noyywrap

%%
[0-9]+ { printf("%s\n", yytext); }
.|\n ;
%%


int main(void) {
    yylex();
    return 0;
}
