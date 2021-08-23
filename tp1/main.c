#include <stdio.h>
#include "scanner.h"

#define ERROR -1

int main(void)
{
    token_t token;

    token_reset(&token);
    token = get_token();

    while(token.type != ERROR) {

        print_token(token);
        free(token.content);

        token_reset(&token);
        token = get_token();
    }

    return 0;
}
