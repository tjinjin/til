## backup編

こちらと同じもの https://devcenter.heroku.com/articles/heroku-postgres-backups

### DBのbackup

```
# backupを取得する
$ heroku pg:backups:capture --app <appname>

# backupの状況を確認する
$ heroku pg:backups:info

# backupを辞める
$ heroku pg:backups:cancel
```

backupの数はplanで決まっているので注意

### スケジュールでのbackup

```
# スケジュールを確認する
$ heroku pg:backups:schedules --app <appname>

# スケジュールを登録する
$ heroku pg:backups:schedule DATABASE_URL --at '02:00 Asia/Tokyo' --app <appname>

# スケジュールを解除する
$ heroku pg:backups:unschedule --app <appname>
```

### backupにアクセスする

```
# backupが保存してあるpublicなendpointを取得する（60minutesで使えなくなる
$ heroku pg:backups:url --app <appname>

# donwloadする
$ heroku pg:backups:download
# currentにdumpファイルが出来ている
```

### backup情報を確認する

```
# 概要を取得
$ heroku pg:backups
=== Backups
ID    Created at                 Status                               Size    Database
────  ─────────────────────────  ───────────────────────────────────  ──────  ────────
b001  2017-01-30 05:44:27 +0000  Completed 2017-01-30 05:44:29 +0000  5.36kB  DATABASE

=== Restores
No restores found. Use heroku pg:backups:restore to restore a backup

=== Copies
No copies found. Use heroku pg:copy to copy a database to another

# backupの詳細情報を取得
$ heroku pg:backups:info b001
=== Backup b001
Database:         DATABASE
Started at:       2017-01-30 05:44:28 +0000
Finished at:      2017-01-30 05:44:29 +0000
Status:           Completed
Type:             Manual
Original DB Size: 7.30MB
Backup Size:      5.36kB (100% compression)
```

### backupをrestore/deleteする

```
$ heroku pg:backups:restore b001 DATABASE_URL --app <appname>
# appnameのタイプを求められる

# 他のアプリのバックアップを利用する
$ heroku pg:backups:restore <appname>:b001 DATABASE_URL --app <appname>-staging
$ heroku pg:backups:restore 'https://hogehoge/me/items/mydb/dump' DB_URL -a <appname>

# DBのバックアップを削除する
$ heroku pg:backups:delete b001 --app <appname>

# DBをコピーする
$ heroku pg:copy COBALT GREEN --app <appname>
# COBALT -> GREENにコピー
```

### sqlを直接叩く

```
$ heroku pg:psql -c "select * from users"
```
