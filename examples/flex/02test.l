	#include <stdio.h>
/*%option debug*/
%%
[ \t]+	putc(' ', yyout);
[ \t]+$	/* No hago nada, implica que los elimino*/
