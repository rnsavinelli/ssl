#include <stdio.h>
#include <stdlib.h>
#include "08scanner.h"

int main(void)
{
	char *tok_names[] = {"Fin De Texto", "Separador", "Cadena"};
	TOKEN token;
	do {
		token = yylex();
		printf("%s: %s\n", tok_names[token], yytext);
	} while (token != FDT);
	return EXIT_SUCCESS;
}
