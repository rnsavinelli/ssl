
	#include <stdio.h>
	int octales=0;
	int decimales=0;
	int hexas=0;
	int reales=0;
	int pal=0;

%option outfile="05test.c"
%%
0[xX][0-9a-fA-F]+	{
				hexas++;
				printf("Reconocido el hexa %s\n",yytext);
			}
[1-9][0-9]*		{decimales++; printf("Reconocido el decimal %s\n",yytext);}
0[0-7]*			{octales++; printf("Reconocido el octal %s\n",yytext);}
[0-9]*\.[0-9]+		{reales++; printf("Reconocido el real %s\n",yytext);}
[a-zA-Z]+		{pal++; printf("Reconocida la palabra %s\n",yytext);}
0[0-7]*[0-9]+		{printf("ERROR octal %s\n",yytext);}
.|\n    		;
%%
int main() {
    yylex();
    printf("\nTOTALES\n-------\n\n");
    printf("Cant Octales %d\n",octales);
    printf("Cant Decimales %d\n",decimales);
    printf("Cant Hexadecimales %d\n",hexas);
    printf("Cant Reales %d\n",reales);
    printf("Cant Palabras %d\n",pal);
    return 0;
}
