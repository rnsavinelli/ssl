%code top{
#include <stdio.h>
#include "03-registro.h"
}
%code provides {
struct YYSTYPE {
	int    num;
	double real;
	char   *str;
	};
void yyerror(const char *s);
}
%token ID DECIMAL REAL
%define api.value.type {struct YYSTYPE}

%code {
char *token_names[] = {"ID", "DECIMAL", "REAL"};
}

%%
listado : cte
	| listado cte
	;
cte	: ID {printf("Token: %s\t\tValor texto: %s\n", token_names[0], $1.str);}
	| DECIMAL {printf("Token: %s\t\tValor texto: %s\tValor entero: %d\n",
			token_names[1], $1.str, $DECIMAL.num);}
	| REAL {printf("Token: %s\t\tValor texto: %s\tValor real: %g\n", 
			token_names[2], $1.str, $REAL.real);}
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
