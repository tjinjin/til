## mysql

## トランザクション分離レベル
### 確認方法

```
> select @@tx_isolation
```

### 種類
- READ UNCOMMITTED
- READ COMMITTED
- REPEATABLE READ
- SERIALIZABLE


### 変更方法

```
> set session transaction isolation level read committed;
```

## 初期設定

## ユーザ作成

```
> select host,user from mysql.user;
> create 'hoge'@'localhost'; # localhostからのみhogeというユーザ名でパスワードなしでアクセスできる
> create user 'hoge'@'%' identified by 'password'; # どこからでもhogeというユーザ名でパスワードを使ってアクセスできる
```

上記時点だと権限がない

```
> grant <権限の内容> on <どこに対して> to <誰に>
> grant all privileges on *.* to hoge@localhost
```


## import/export
### import

```
$ mysqldump -uroot --quick --single-transaction -p$PASSWORD -h$DB_HOSTNAME $database $table > $table.sql
# まとめて実行
$ for table in \
  aaa \
  aaa \
  aaa \
  aaa \
  aaa \
;do mysqldump -uroot --quick --single-transaction -pQqLLNtqPsy -h$DB_HOSTNAME -t goose $table > $table.sql ;done
```

--quick メモリにためずに1行ずつ書き込む
--single-transaction テーブルをロックせずにダンプする

### export

```
$ mysql -uroot -h$DB_HOSTNAME -p$DB_PASSWORD $database < $table.sql
# 一気に
$ for table in \
  aaa \
  bbb \
;do mysql -uroot -h$DB_HOSTNAME -p$DB_PASSWORD $database < $table.sql ; done

```

## ちょい技
### tableのレコード数を確認する

```
> select table_name, table_rows
from information_schema.tables
where table_schema in ('aaa', 'bbb');
```
