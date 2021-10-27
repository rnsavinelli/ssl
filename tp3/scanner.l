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

%}

%option outfile="scanner.c"
%option header-file="scanner.h"

%option noyywrap
%option nounput
%option noinput

espacio_en_blanco [ \t\n]
comentario \/\/[^\n]*

letra [a-zA-Z]
digito [0-9]

operador_primario [+-]
operador_secundario [*/%]

identificador {letra}({letra}|{digito})*
constante -?{digito}+
operador {operador_primario}|{operador_secundario}
palabra_reservada programa|entero|leer|escribir|fin-programa
asignacion <<
caracter_de_puntuacion [();,]

%%

{espacio_en_blanco}+ {} /* ignorar nuevas lineas, tabuladores y espacios */

{comentario} {} /* ignorar comentarios */

{palabra_reservada} { return PALABRA_RESERVADA; }

{identificador} { return IDENTIFICADOR; }

{constante} { return CONSTANTE; }

{operador} { return OPERADOR; }

{asignacion} { return ASIGNACION; }

{caracter_de_puntuacion} { return CARACTER_DE_PUNTUACION; }

. { printf( "ERROR: Caracter no reconocido: %s\n", yytext ); }

%%