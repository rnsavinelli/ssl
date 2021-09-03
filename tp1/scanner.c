/*
 * scanner.c
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

#include "scanner.h"

// BO static methods

static bool isnewline(int character)
{
	return character == '\n';
}

static bool is_escape_sequence(int character)
{
	return isspace(character) || isnewline(character);
}

static bool is_cad(int charcater) {
	return not(charcater == EOF || charcater == SEP);
}

static char * store_character(char **buffer, int character)
{
	size_t buffer_size = 0;

	if(*buffer == NULL) {

		buffer_size = sizeof(char) + sizeof('\0');
		*buffer = (char *) malloc(buffer_size);

		if (*buffer != NULL) {
			*(*buffer) = character;
			*(*buffer + 1) = '\0';
		}

	} else {

		buffer_size = strlen(*buffer) + sizeof(char) + sizeof('\0');
		*buffer = (char *) realloc(*buffer, buffer_size);

		if (*buffer != NULL) {
			sprintf(*buffer, "%s%c", (const char *) *buffer, (char) character);
		}
	}

	return *buffer;
}

// EO static methods

void word_purge(word_t *word)
{
	word->token = FDT;

	if (word->morpheme != NULL) {

		free(word->morpheme);
		word->morpheme = NULL;

	}
}

token_t get_token(char ** morpheme)
{
	int character = EOF;

	while((character = getchar()) != EOF) {

		if(is_escape_sequence(character))
			continue;

		switch (character) {
			case SEP:
				store_character(morpheme, character);
				return SEP;

			default:
				do {
					if(is_escape_sequence(character)) {
						break;
					}
					store_character(morpheme, character);

				} while (is_cad(character = getchar()));

				ungetc(character, stdin);
				return CAD;
		}
	}

	store_character(morpheme, character);
	return FDT;
}

void print_word(word_t word)
{
	switch (word.token) {

		case FDT:
			printf("Fin de texto");
			break;

		case SEP:
			printf("Separador");
			break;

		default /* CAD */:
			printf("Cadena");
			break;
	}

	printf(": %s\n", word.morpheme);
}

word_t get_word(void)
{
	word_t word = {
		.token = FDT,
		.morpheme = NULL,
	};
	
	word.token = get_token(&word.morpheme);

	return word;
}