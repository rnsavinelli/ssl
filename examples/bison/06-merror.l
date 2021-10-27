%{
#include <stdio.h>
#include <strings.h>
#include "06-merror-par.h"
%}
%option header-file="06-merror-scan.h"
%option outfile="06-merror-scan.c"
%option yylineno

%%
[a-zA-Z]+		{yylval = strdup(yytext); return PALABRA;}
[0-9]+			{yylval = strdup(yytext); return NRO;}
,			{return ',';}
!			{return '!';}
[[:space:]]+		;
[[:punct:]]{-}[,!]+	{yylexerrs++; yyerror("Error léxico");}
.			;
%%

