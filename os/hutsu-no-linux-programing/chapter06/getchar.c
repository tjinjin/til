// http://www.c-tipsref.com/reference/stdio/getchar.html
/* header files */
#include <stdio.h>
#include <stdlib.h>

/* macros */
#define N 256

/* main */
int main(void) {
    int i;
    int ch;
    char read_str[N] = {'\0'};

    i = 0;
    /* 中断されるまで文字を読み取る */
    /* ctrl dで終了する*/
    while (( ch = getchar()) != EOF ) {
        read_str[i++] = ch;
        if ( i >= N - 1 ){
            break;
        }
    }

    printf("%s\n", read_str);

    return EXIT_SUCCESS;
}
