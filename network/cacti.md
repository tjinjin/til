## cacti

## フォルダ
```
/var/www/cacti # cacti
/var/www/cacti/rra # rrd用のファイル？
```

## 原因切り分け
* [グラフの確認 - あえて・・・ - Seesaa Wiki（ウィキ）](http://seesaawiki.jp/w/slt33333/d/%A5%B0%A5%E9%A5%D5%A4%CE%B3%CE%C7%A7))]
* [cactiでSNMPで取得した値を使い独自グラフを作成するメモ。 - oranie s blog](http://oranie.hatenablog.com/entry/20110106/1294282700)

### グラフが表示できないだけ？
* スパナのボタンを押して確認
* debugモードで"OK"が返ってくるか確認

### データが取得できない？
対象のrrdファイルを使ってコマンド経由で情報を取得してみる

```
rrdtool fetch test.rrd [LAST|AVERAGE|MIN|MAX]
```
nanが返ってくる場合は何かがおかしい。OIDやtemplateの項目名をチェック

## link
* [公式](http://docs.cacti.net/)
* [RRDTool+Cactiによるサーバ監視(Linux編)](http://www.aconus.com/~oyaji/suse9.3/cacti_linux2.htm)
