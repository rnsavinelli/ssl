%{
#include <stdio.h>
int nros=0;
int pal=0;
%}
%%
[0-9]+		{nros++; printf("Reconocido el nro %s\n",yytext);}
[a-zA-Z]+	{pal++; printf("Reconocido la palabra %s\n",yytext);}
.|\n    	;
%%
int main() {
    yylex();
    printf("Cant Nros %d\n",nros);
    printf("Cant Palabras %d\n",pal);
    return 0;
}
