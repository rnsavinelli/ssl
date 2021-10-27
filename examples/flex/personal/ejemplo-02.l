%{
/* Reconoce números enteros y palabras alfabéticas; además,
cuenta las ocurrencias de ambos */
#include <stdio.h>
int nros = 0, pals = 0;
%}

%option noyywrap

%%
[0-9]+ { nros++; }
[a-zA-Z]+ { pals++; }
.|\n ;
%%

int main(void) {
    yylex();
    printf("Se reconocieron:\n");
    printf("%d Numeros y\n", nros);
    printf("%d Palabras.\n\n", pals);
    return 0;
}
