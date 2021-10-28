#include <stdio.h>
#include <stdlib.h>
#include "tokens.h"
#include "scanner.h"

char *token_names[] = {
    "",
    "IDENTIFICADOR",
    "CONSTANTE",
    "PALABRA RESERVADA",
    "OPERADOR",
    "ASIGNACION",
    "CARACTER DE PUNTUACION"};

int main(void)
{
    token_t token;

    while ((token = yylex()) != 0)
        printf("Token: \"%s\", Lexema: \"%s\"\n", token_names[token], yytext);

    return 0;
}
