%{
#include <stdio.h>
#include <strings.h>
#include "05-unionparser.h"
%}
%option header-file="05-unionscanner.h"
%option outfile="05-unionscanner.c"
%option yylineno

dig   [0-9]
expo  [eE][+-]?{dig}+
frac  {dig}*\.{dig}+|{dig}+\.{dig}*
letra [a-zA-Z]

%%
{letra}({letra}|{dig})*	{yylval.str = strdup(yytext);
			 return ID;}
{dig}+			{sscanf(yytext, "%d", &yylval.num);
			 return DECIMAL;}
{dig}+{letra}+		{nerrlex++; yyerror("Constante decimal mal formada\n");}
{frac}{expo}?		|
{dig}+{expo}		{sscanf(yytext, "%lf", &yylval.real);
			 return REAL;}
.|\n    		;
%%

