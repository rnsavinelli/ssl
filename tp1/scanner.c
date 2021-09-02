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

static bool is_terminal(int character)
{
	token_t token = get_token(character);
	return token == FDT || token == SEP;
}

static bool is_space(int character)
{
	return isspace(character);
}

static bool is_newline(int character)
{
	return character == '\n';
}

static char * store_character(word_t *word, int character)
{
	if(word->content == NULL) {

		word->content_size = sizeof(*(word->content)) * 2;
		word->content = (char *) malloc(word->content_size);

		if (word->content != NULL) {

			*(word->content) = (char) character;
			*(word->content + 1) = '\0';

		}

	} else {

		word->content_size += sizeof(*(word->content));
		word->content = (char *) realloc(word->content, word->content_size);

		if (word->content != NULL) {

			sprintf(word->content, "%s%c", (const char *) word->content, (char) character);

		}
	}

	return word->content;
}

// EO static methods

void word_purge(word_t *word)
{
	word->token = UNDEFINED;
	word->content_size = 0;

	if (word->content != NULL) {

		free(word->content);
		word->content = NULL;

	}
}

token_t get_token(int character)
{
	switch (character) {

	case EOF:
		return FDT;

	case ',':
		return SEP;

	default:
		return CAD;

	}
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

	default:
		printf("Cadena");
		break;

	}

	printf(": %s\n", word.content);
}

word_t get_word(void)
{
	int character = EOF;

	word_t word = {
		.token = UNDEFINED,
		.content = NULL,
		.content_size = 0
	};

	do {
		character = getchar();

		if(not(is_terminal(character))) {

			if(is_space(character) || is_newline(character)) {

				if(word.content != NULL) break;

				else continue;

			}

			word.token = get_token(character);

			if(store_character(&word, character) == NULL) {

				perror("Memory allocation request failed");
				exit(ERROR);

			}			

		} else {

			if (word.content != NULL) {

				ungetc(character, stdin);

			} else {

				if(store_character(&word, character) == NULL) {

					perror("Memory allocation request failed");
					exit(ERROR);

				}

				word.token = get_token(character);

			}

			break;
		}

	} while(not(is_terminal(character)));

	return word;
}