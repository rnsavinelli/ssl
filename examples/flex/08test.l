%top{
#include "tokens_08.h"
}
%option outfile="08scanner.c"
%option header-file="08scanner.h"

S  [[:space:]]
O  [^,]{-}[[:space:]]

%%

,      return SEP;
{S}+   /*ignorar*/
{O}+   return CAD;

