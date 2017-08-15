## RDS

## マイナーアップグレード
replicaがある場合、replicaのアップグレード後にmasterをアップグレードする

## postgresql
### パラメータグループ

* [付録: PostgreSQL の一般的な DBA タスク - Amazon Relational Database Service](http://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/Appendix.PostgreSQL.CommonDBATasks.html#Appendix.PostgreSQL.CommonDBATasks.Parameters)
* [PostgresのRDSチューニング - Qiita](http://qiita.com/awakia/items/9981f37d5cbcbcd155eb)

## リストア
RDSのスナップショットから復元するときにSGやパラメータグループの設定はない。スナップショットの設定が引き継がれると思いきや、デフォルトの設定が適用されてしまう

- パラメータグループ
- セキュリティグループ

オプショングループは、既存の設定を引き継ぐっぽい

- http://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/USER_RestoreFromSnapshot.html

## ベスト・プラクティス
### RAM
メモリが十分かどうかは下記の方法で検証が可能

- DBインスタンスに負荷を欠ける
- その状態でReadIOPSを確認する
- インスタンスタイプを上げてみる

上記を実施したときにReadIOPSが劇的に低下しなかったり、非常に小さい値のままであればメモリ上で解決しているといえそう

## RDSのダウンタイム
http://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/Overview.DBInstance.Modifying.html

ストレージタイプの変更では機能停止が発生する。詳細はリンクを。
MySQLにおいてシングルAZでリードレプリカを作成すると、1分程度の機能停止があるので注意

## オプショングループ
> DB エンジンによっては、データとデータベースの管理を容易にしたり、データベースのセキュリティを強化したりするための、追加の機能が用意されている場合があります。Amazon RDS では、オプショングループを使用してこれらの機能を有効にして設定します。

## モニタリング
### CPU/RAMの高消費量
アプリケーションのスループットに合わせて。負荷が高くても問題とは言えない

### diskスペース
85%を超えている場合は何らかの対応をすべし

### Network traffic
スループットが低すぎないか確認

### データベース接続数
ユーザ接続数が多いことがインスタンスのパフォーマンス低下や、応答時間の遅延につながっていることがわかったら制限を考える

#### IOPS

RDSのログをコンソール上でも確認することができる（わかりにくいけど）

## セキュリティ
### IAMデータベース認証
- IAMデータベース認証用のデータベースアカウントを作成する（DBの中に
- 利用するユーザやロールにIAMポリシーを設定
- 認証トークンを取得してそれをパスワード代わりにして接続する（15分だけ
- http://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html

## ネットワーク
### ClassicLink
privateなRDSにパブリックなインスタンスからアクセスできる。classic専用っぽい

## ストレージ
### gp2
- ベースラインは3IOPS/GiB
- 最大は3000IOPSなので、1000GBだったらその速度が維持できる

### PIOPS
I/Oサイズの最大は256KBだが、ほとんど使われない。32KB未満は1つのI/Oとして扱われる

> I/O サイズが 32 KB より大きい場合、指定より少ない I/O で Provisioned IOPS がすべて消費される可能性もあります。たとえば、5,000 IOPS にプロビジョニングされたシステムでは、64 KB の I/O では最大 2,500 IOPS、128 KB の I/O では 1,250 IOPS を達成できます。

細かい情報も乗っているのでパフォーマンスで困ったら読む http://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/CHAP_Storage.html
