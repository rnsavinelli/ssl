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
	return get_token_type(character) == FDT || get_token_type(character) == SEP;
}

static bool is_space(int character)
{
	return isspace(character);
}

static bool is_newline(int character)
{
	return character == '\n';
}

static char * store_character(token_t *token, int character)
{
	if(token->content == NULL) {

		token->content_size = sizeof(*(token->content)) * 2;
		token->content = (char *) malloc(token->content_size);

		if (token->content != NULL) {

			*(token->content) = (char) character;
			*(token->content + 1) = '\0';

		}

	} else {

		token->content_size += sizeof(*(token->content));
		token->content = (char *) realloc(token->content, token->content_size);

		if (token->content != NULL) {

			sprintf(token->content, "%s%c", (const char *) token->content, (char) character);

		}
	}

	return token->content;
}

// EO static methods

void token_purge(token_t *token)
{
	token->type = UNDEFINED;
	token->content_size = 0;

	if (token->content != NULL) {

		free(token->content);
		token->content = NULL;

	}
}

int get_token_type(int character)
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

void print_token(token_t token)
{
	switch (token.type) {

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

	printf(": %s\n", token.content);
}

token_t get_token(void)
{
	int character = EOF;

	token_t token = {
		.type = UNDEFINED,
		.content = NULL,
		.content_size = 0
	};

	do {
		character = getchar();

		if(not(is_terminal(character))) {

			if(is_space(character) || is_newline(character)) {

				if(token.content != NULL) break;
                
				else continue;

			}

			if(store_character(&token, character) == NULL) {

				perror("Memory allocation request failed");
				exit(ERROR);

			}

            token.type = get_token_type(character);

		} else {

			if (token.content != NULL) {

				ungetc(character, stdin);

			} else {

				if(store_character(&token, character) == NULL) {

					perror("Memory allocation request failed");
					exit(ERROR);

				}

				token.type = get_token_type(character);

			}

			break;
		}

	} while(not(is_terminal(character)));

	return token;
}