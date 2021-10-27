%{
#include <stdio.h>
#include "tokens_07.h"
%}
%option outfile="07test.c"

prehex  0[xX]
dighex  [0-9a-fA-F]
digoct  [0-7]
nocero  [1-9]
digdec  [0-9]
sufint  [uU][lL]|[lL][uU]|[lL]|[uU]
sufreal [fFlL]
expo    [eE][+-]?{digdec}+
fracc   {digdec}*\.{digdec}+|{digdec}+\.{digdec}*
inval   [0-9.]

%%
{prehex}{dighex}+                 return HEXA;
{nocero}{digdec}*{sufint}?        return DECIMAL;
{nocero}({digdec}|[a-z])*         printf("Error léxico ENTERO inválido: %s\n", yytext);
0{digoct}*                        return OCTAL;
{fracc}{expo}?{sufreal}?          |
{digdec}+{expo}{sufreal}?         return REAL;
{fracc}{inval}+{expo}?{sufreal}?  printf("Error léxico REAL inválido: %s\n", yytext);
.|\n                              ;

%%
char *token_names[] = {"", "HEXA", "DECIMAL", "OCTAL", "REAL"};
int main() {
	enum token t;
	while ((t = yylex()) != FDT)
		printf("Token: %s\t\tValor: %s\n", token_names[t], yytext);
	return 0;
}
