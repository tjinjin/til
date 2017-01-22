#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

// 関数のプロトタイプ宣言
// これがないと呼び出し順の制限に引っかかることがある
static void do_cat(const char *path);
static void die(const char *s);

int
main(int argc, char *argv[])
{
    int i;

    if (argc < 2) {
        fprintf(stderr, "%s: file name not given\n", argv[0]);
        exit(1);
    }
    for (i = 1; i < argc; i++) {
        do_cat(argv[i]);
    }
    exit(0);
}

// 記号変数
#define BUFFER_SIZE 2048

static void
do_cat(const char *path)
{
    int fd;
    unsigned char buf[BUFFER_SIZE];
    int n;

    fd = open(path, O_RDONLY);
    if (fd < 0) die(path);
    //無限ループ
    for (;;) {
        //fd:ファイルディスクリプタ buf
        n = read(fd, buf, sizeof buf);
        // errorチェック
        if (n < 0) die(path);
        if (n == 0) break;
        // readで読んだ部分まで書き込む
        if (write(STDOUT_FILENO, buf, n) < 0) die(path);
    }
    if (close(fd) < 0) die(path);
}

static void
die(const char *s)
{
    // 標準エラー出力にメッセージを出す
    perror(s);
    exit(1);
}
