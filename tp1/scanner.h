#ifndef SCANNER_H_
#define SCANNER_H_

#include <errno.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdbool.h>
#include <assert.h>
#include <stdlib.h>

enum TOKENS {
    CAD,
    FDT = EOF,
    SEP = (int) ','
};

typedef struct token {
    int type;
    char * content;
} token_t;

int get_character_type(int character);
bool character_is_terminal(int character);
bool character_is_not_terminal(int character);

void print_token(token_t token);
void token_reset(token_t *token);

token_t get_token();

#endif /* SCANNER_H_ */