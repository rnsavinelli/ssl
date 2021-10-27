/*
 * scanner.l
 *
 * Copyright 2021 Roberto Nicolás Savinelli <rnsavinelli@frba.utn.edu.ar>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 *
 */

%{

#include <stdio.h>
#include "tokens.h"

#define ERROR -1

%}

%option outfile="scanner.c"

%option noyywrap
%option nounput
%option noinput

nueva_linea (\n)
espacio [ \t]
letra [a-zA-Z]
digito [0-9]
separador [,]
operador_primario [+-]
operador_secundario [*/%]
asignacion <<
caracter_de_puntuacion [();,]
palabra_reservada (programa)|(entero)|(leer)|(escribir)|(fin-programa)
comentario \/\/[^\n]*

%%

{nueva_linea}+ {} /* ignore new lines */

{espacio}+ {} /* ignore whitespaces*/

{palabra_reservada} { return PALABRA_RESERVADA; }

{letra}({letra}|{digito})* { return IDENTIFICADOR; }

-?{digito}+ { return CONSTANTE; }

{operador_primario}|{operador_secundario} { return OPERADOR; }

{asignacion} { return ASIGNACION; }

{caracter_de_puntuacion} { return CARACTER_DE_PUNTUACION; }

{comentario} {} /* ignore comments */

. { printf( "Unrecognized character: %s\n", yytext );}

%%

char * token_names[] = {
    "IDENTIFICADOR",
    "CONSTANTE",
    "PALABRA RESERVADA",
    "OPERADOR",
    "ASIGNACION",
    "CARACTER DE PUNTUACION"
};


int main(void) {
    token_t token;

    while((token = yylex()) != 0)
    	printf("Token: \"%s\", Lexema: \"%s\"\n", token_names[token-1], yytext);

    return 0;
}
