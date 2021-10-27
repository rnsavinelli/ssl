%code top{
#include <stdio.h>
#include "06-merror-scan.h"
}
%code provides{
void yyerror(const char *);
extern int yylexerrs;
}
%defines "06-merror-par.h"
%output "06-merror-par.c"
%token PALABRA NRO
%define api.value.type {char *}
%define parse.error verbose

%%
todo	: listado { if (yynerrs || yylexerrs) YYABORT;}
listado : lista
	| listado lista
	;
lista	: palabras '!'
	| numeros '!'
	| error '!'
	;
palabras: PALABRA
	| palabras ',' PALABRA
	;
numeros	: NRO
	| numeros ',' NRO
	;
%%

int yylexerrs = 0;
int main() {
	switch( yyparse() ){
	case 0:
		puts("Pertenece al LIC"); return 0;
	case 1:
		puts("No pertenece al LIC"); return 1;
	case 2:
		puts("Memoria insuficiente"); return 2;
	}
	return 0;
}
/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
	printf("línea #%d: %s\n", yylineno, s);
	return;
}
