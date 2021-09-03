/*
 * scanner.h
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

#ifndef SCANNER_H_
#define SCANNER_H_

#include <errno.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdbool.h>
#include <assert.h>
#include <stdlib.h>

#define not !
#define ERROR -1

typedef enum TOKENS {
	CAD,
	FDT = EOF,
	SEP = ','
} token_t;

typedef struct word {
	token_t token;
	char * morpheme;
} word_t;

token_t get_token(char ** morpheme);

void print_word(word_t word);

void word_purge(word_t *word);

word_t get_word(void);

#endif /* SCANNER_H_ */