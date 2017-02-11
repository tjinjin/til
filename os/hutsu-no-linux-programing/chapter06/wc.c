#include <stdio.h>
#include <stdlib.h>

static void wc(FILE *f);

int main(int argc, char *argv[])
{
  // 引数をチェック
  if (argc == 1) {
    // 1つなら標準入力を
    wc(stdin);
  } else {
    int i;

    // ファイルを読み込む処理
    for (i = 1; i < argc; i++) {
      FILE *f;

      f = fopen(argv[i], "r");
      if (!f) {
        perror(argv[i]);
        exit(1);
      }
      wc(f);
      fclose(f);
    }
  }
  exit(0);
}

static void wc(FILE *f)
{
  // counter
  unsigned long n;
  int c;
  int prev = '\n';   /* '\n' is for empty file */

  n = 0;
  while ((c = getc(f)) != EOF) {
    if (c == '\n') {
        n++;
    }
    prev = c;
  }
  if (prev != '\n') {
    /* missing '\n' at the end of file */
    n++;
  }
  printf("%lu\n", n);
}
