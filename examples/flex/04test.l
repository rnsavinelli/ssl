%{
#include <stdio.h>
int enteros=0;
int pal=0;
int reales=0;
%}

%%
0[xX][0-9a-fA-F]+|[1-9][0-9]*|0[0-7]*	printf("Entero %d: %s\n",++enteros, yytext);
[0-9]*\.[0-9]+				printf("Real %d: %s\n",++reales, yytext);
[a-zA-Z]+				printf("Palabra %d: %s\n",++pal, yytext);
.|\n    				;
%%
int main() {
    yylex();
    printf("\nTOTALES\n-------\n\n");
    printf("Cant Enteros %d\n",enteros);
    printf("Cant Reales %d\n",reales);
    printf("Cant Palabras %d\n",pal);
    return 0;
}
