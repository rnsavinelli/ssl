%{
#include <stdio.h>
#include <strings.h>
#include "02-testflex.tab.h"
char msg[120]; //para poder armar mensajes a enviar a yyerror
%}
%option header-file="02-testflex.h"
%option outfile="02-testflex.c"

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
{prehex}{dighex}+                 {yylval = strdup(yytext); return HEXA;}
{nocero}{digdec}*{sufint}?        {yylval = strdup(yytext); return DECIMAL;}
{nocero}({digdec}|[a-z])*         {
                                   sprintf(msg, "Error léxico ENTERO inválido: %s"
                                              , yytext);
                                   yyerror(msg);
                                  }
0{digoct}*                        {yylval = strdup(yytext); return OCTAL;}
{fracc}{expo}?{sufreal}?          |
{digdec}+{expo}{sufreal}?         {yylval = strdup(yytext); return REAL;}
{fracc}{inval}+{expo}?{sufreal}?  {
                                   sprintf(msg, "Error léxico REAL inválido: %s"
                                              , yytext);
                                   yyerror(msg);
                                  }
.|\n                              ;
%%

