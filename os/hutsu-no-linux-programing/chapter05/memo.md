## 標準入出力のストリーム
- 0 STDIN_FILENO
- 1 STDOUT_FILENO
- 2 STDERR_FILENO


## ファイルオフセット
- 同じファイルディスクリプタに対してread()を呼ぶと、前回の続きが帰ってくる。ファイルオフセットを記憶している
- lseek(2) でoffsetを移動できる
