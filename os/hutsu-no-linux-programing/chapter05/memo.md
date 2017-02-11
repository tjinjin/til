## 5.2 ファイルディスクリプタ
カーネルが持っているストリームの番号を対応付プロセス側で番号を指定する必要がある。
一番簡単な方法として、プロセス開始時から使えるものがある。それが、標準入力・標準出力・標準エラー出力

### 標準入出力のストリーム
- 0 STDIN_FILENO
- 1 STDOUT_FILENO
- 2 STDERR_FILENO

## ストリームの読み書き
### read(3)

```
#include <unistd.h>

ssize_t read(int fd, void *buf, size_t bufsize);
```

ssize_t,size_tはsys/type.hで定義されている型


## ファイルオフセット
- 同じファイルディスクリプタに対してread()を呼ぶと、前回の続きが帰ってくる。ファイルオフセットを記憶している
- lseek(2) でoffsetを移動できる
