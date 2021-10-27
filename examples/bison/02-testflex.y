%{
#include <stdio.h>
#include "02-testflex.h"
char *token_names[] = {"HEXA", "DECIMAL", "OCTAL", "REAL"};
%}

%code provides {
void yyerror(const char *);
}

%token HEXA DECIMAL OCTAL REAL
%define api.value.type {char *}

%%
listado : %empty
	| listado cte
	;
cte	: HEXA {printf("Token: %s\t\tValor: %s\n", token_names[0], $1);}
	| DECIMAL {printf("Token: %s\t\tValor: %s\n", token_names[1], $1);}
	| OCTAL {printf("Token: %s\t\tValor: %s\n", token_names[2], $1);}
	| REAL {printf("Token: %s\t\tValor: %s\n", token_names[3], $1);}
	;
%%

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
	puts(s);
	return;
}
