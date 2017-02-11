## stdio
システムコールは非常に遅い。効率的に入出力するためのライブラリがstdio。
stdioだと1B単位でのバッファリングをするので効率がよい

書き込みタイミングはバッファを超えるか、その他の例外がある

- 改行('\n')が書き込まれた
- アンバッファモードになっている
- stderr（アンバッファモードがデフォルト


### fopen(3)
open()に対応するAPI

```
#include <stdio.h>

FILE *fopen(const char *path, const char *mode);
```

### fclose(3)
close()に対応

```
#include <stdio.h>

FILE fclose(FILE *stream);
```

## バイト単位の入出力
### fgetc(3), fputc(3)
バイト単位の入出力API

```
#include <stdio.h>

int fgetc(FILE *stream);
int fputc(int c, FILE *stream);
```

### getc(3), putc(3)
必ずマクロとして定義される

```
#include <stdio.h>

int getc(FILE *stream);
int putc(int c, FILE* *stream);
```

### getchar(3), putchar(3)
入力元・出力先が固定されているバイト単位の入出力API

```
#include <stdio.h>

int getchar(void);
int putchar(int c);
```

### ungetc(3)
バイト単位で値をバッファに戻す


## 文字列の入出力
### fgets(3)
行単位で読み取る

```
#include <stdio.h>

char *fgets(char *buf, int size, FILE *stream);
```

最大size-1 バイトまで読み込む（-1は'\0'を書き込むため）

### fputs(3)
出力

```
#include <stdio.h>

int fputs(const char *buf, FILE *stream);
```

文字列bufをstreamに出力する

エラーなのか全て書き終わったかを判断するためにerrnoを見る
どちらの場合もEOFを返すため

```
#include <errno.h>

{
  errno = 0;
  if (fputs(buf, f) == EOF) {
    if (errno != 0) {
      // エラー処理
    }
  }
}
```

### puts(3)
改行を付けて出力する

### printf(3), fprintf(3)
printfは標準出力にfprintfなら引数のstreamに書き込む

printfを使いがちだが、bufに入る文字列に'%'があると思わぬ動きをすることもある

### scanf(3)
フォーマットを指定して入力ができる。バッファオーバーフローの可能性があるらしい

## 固定長の入出力
### fread(3)

```
size_t fread(void *buf, size_t size, size_t nmemb, FILE *stream)
```

streamから(size * nmemb)を読み込む。成功したら、nmembを返す


### fwrite(3)

```
size_t fwrite(const void *buf, size_t size, size_t nmemb, FILE *stream);
```

(size * nmemb)バイト分のバイト列をbufからstreamに書き込む

#### 固定長入出力APIの必要な理由
- 他のstdioのAPIと同時に使える。独自バッファをもっているため影響しない
- より普遍的

## ファイルオフセットの操作
### fseek(3), fseeko(3)

```
int fseek(FILE *stream, long offset, int whence);
int fseeko(FILE *stream, off_t offset, int whence);
```

2GBを超える場合にはlongで対応できないので、fseekoがある

### ftell(3), ftello(3)

```
long ftell(FILE *stream)
off_t ftello(FILE *stream)
```

ファイルオフセットの値を返す

### rewind(3)

```
void rewind(FILE *stream)
```

ファイルオフセットをファイルの先頭に戻す

## ファイルディスクリプタとFILE型
### fileno(3)
streamがラップしているファイルディスクリプタを返す

### fdopen(3)
ファイルディスクリプタfdをラップするFILE型の値を新しく作成してポインタを返す

## バッファリング
### fflush(3)
streamがバッファリングしている内容を即剤にwrite()させる

### setvbuf(3)
こちらで指定したバッファをstdioに強制的に使わせることができる

## EOFとエラー
### feof(2)
直前の読み込み操作でstreamがEOFに達していたら真を返す。これは使っちゃいけないらしい

### ferror(3)
直前の入出力でエラーが起きていたら真を返す。ほとんど使わない

### clearerr(3)
streamのエラーフラグとEOFフラグをクリアする。tailfとかだと１つのストリームに対し何度もEOFが発生する。

## stdioの動作を確かめる
straceを使う

-eオプションで確認したいシステムコールを指定できる

```
$ strace -e trace=open,read,write,close ./cat data > /dev/null
```
