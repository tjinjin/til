## heroku scheduler
- クレカ登録が必要

```
# addonのインストール
$ heroku addons:create scheduler:standard

# test実行
$ heroku run rake update_feed

# 画面に遷移して設定する
$ heroku addons:open scheduler

# ログを見る
$ heroku logs --ps scheduler.1
```
