%{
#include <stdio.h>
int octales=0;
int decimales=0;
int hexas=0;
int reales=0;
%}
%option outfile="06test.c"

prehex  0[xX]
dighex  [0-9a-fA-F]
digoct  [0-7]
nocero  [1-9]
digdec  [0-9]
sufint  [uU][lL]|[lL][uU]|[lL]|[uU]
sufreal [fFlL]
expo    [eE][+-]?{digdec}+
fracc   {digdec}*\.{digdec}+|{digdec}+\.{digdec}*

%%
{prehex}{dighex}+           {hexas++; printf("Reconocido el hexa %s\n",yytext);}
{nocero}{digdec}*{sufint}?  {decimales++; printf("Reconocido el decimal %s\n",yytext);}
0{digoct}*                  {octales++; printf("Reconocido el octal %s\n",yytext);}
{fracc}{expo}?{sufreal}?    {reales++; printf("Reconocido el real %s\n",yytext);}
{digdec}+{expo}{sufreal}?   {reales++; printf("Reconocido el real (sin .) %s\n",yytext);}
.|\n                        ;

%%
int main() {
    yylex();
    printf("\nTOTALES\n-------\n");
    printf("Cant Octales %d\n",octales);
    printf("Cant Decimales %d\n",decimales);
    printf("Cant Hexadecimales %d\n",hexas);
    printf("Cant Reales %d\n",reales);
    return 0;
}
