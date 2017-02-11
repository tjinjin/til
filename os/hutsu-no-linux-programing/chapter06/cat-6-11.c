#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const* argv[])
{

  int i;

  // 引数が一つもなければ即終了
  for(i = 1; i< argc; i++){
    // streamを作る
    FILE *f;
    // 読み込んだ文字を数字で持っておく
    // ASCIIのコードで10進数形式で持っておく
    int c;

    f = fopen(argv[i], "r");
    if (!f) {
      perror(argv[i]);
      exit(1);
    }
    // fgetcでも字を読み込んでいく
    while ((c = fgetc(f)) != EOF) {
      switch (c) {
        case '\t':
          if (fputs("\\t", stdout) == EOF) exit(1);
          break;
        case '\n':
          if (fputs("$\n", stdout) == EOF) exit(1);
          break;
        default:
          if (putchar(c) < 0) exit(1);
          break;
      }
    }
    fclose(f);
  }
  exit(0);
}
