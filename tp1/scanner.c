#include "scanner.h"

int get_character_type(int character)
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

bool character_is_terminal(int character)
{
    return
        get_character_type(character) == FDT ||
        get_character_type(character) == SEP ? true : false;
}

bool character_is_not_terminal(int character)
{
    return ! character_is_terminal(character);
}

token_t get_token()
{
    int character = EOF;
    size_t content_size = 0;

    token_t token = {
        .type = 0,
        .content = NULL
    };

    do {
        character = getchar();

        if(character_is_not_terminal(character)) {
            if(token.content == NULL) {
                content_size = sizeof(*(token.content)*2);
                token.content = (char *) malloc(content_size);
                *(token.content) = (char) character;
                *(token.content + 1) = '\0';
            } else {
                content_size += sizeof(*(token.content));
                token.content = (char *) realloc(token.content, content_size);
                sprintf(token.content, "%s%c", (const char *) token.content, (char) character);
            }
        }

        else {
            if (token.content != NULL) {
                ungetc(character, stdin);
                break;

            } else {
                content_size = sizeof(*(token.content)*2);
                token.content = (char *) malloc(content_size);
                *(token.content) = (char) character;
                *(token.content + 1) = '\0';

                token.type = get_character_type(character);

                return token;
            }
        }

    } while(character_is_not_terminal(character));

    token.type = CAD;

    return token;
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

void token_reset(token_t *token)
{
    token->type = 0;
    token->content = NULL;
}