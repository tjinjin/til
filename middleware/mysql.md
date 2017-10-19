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

## パーティショニング
- http://nippondanji.blogspot.jp/2009/04/1.html

## パラメーター
- "character_set_database" : "現在参照しているDBの文字コード",
- "character_set_client" : "クライアント側で発行したsql文",
- "character_set_connection" : "utf8mb4",
- "character_set_results" : "utf8mb4",
- "character_set_server" : "utf8mb4",
- "sort_buffer_size" : "2097152",
- "log_bin_trust_function_creators" : "1",
- "innodb_log_buffer_size": "33554432",
- "general_log" : "1",
- "log_output" : "FILE",
- "slow_query_log" : "1",
- "long_query_time" : "1",
- "innodb_file_format" : "MySQLのファイル形式。Antelope/Barracuda",
- "tx_isolation" : "分離レベル"

## ちょい技
### tableのレコード数を確認する

```
> select table_name, table_rows
from information_schema.tables
where table_schema in ('aaa', 'bbb');
```

### フラクメンテーションの確認

大きめのフラグメンテーションが起きているテーブルを洗い出す

```
SELECT TABLE_NAME, (DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024 AS sizeMb,DATA_FREE / 1024 / 1024 AS data_free_MB
FROM information_schema.tables
WHERE engine LIKE 'InnoDB'
and TABLE_SCHEMA = 'db_name'
AND DATA_FREE > 100 * 1024 * 1024;
```

https://mysqlstepbystep.com/2015/07/15/useful-queries-on-mysql-information_schema/
=======
### コネクションの情報を見る

```
> show processlist
```


### mysqlのテーブルサイズの確認方法
http://d.hatena.ne.jp/sho-yamasaki/20120405/1333640589

### プロシージャを確認する

```
> show create procedure mysql.rds_rotate_general_log;
```
