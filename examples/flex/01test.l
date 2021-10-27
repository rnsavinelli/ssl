	#include <ctype.h>
	#include <stdio.h>
%%
[a-z]	putchar(toupper(yytext[0]));
