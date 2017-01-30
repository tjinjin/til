## heroku

## 準備編

```
$ brew install heroku
```

## 基本編

```
# ログインする
$ heroku login

# 環境変数を確認する
$ heroku config

# 環境変数を登録する
$ heroku config:set HOGE=fuga

# 環境変数を取得する
$ heroku config:get HOGE

# 環境変数を登録解除する
$ heroku config:unset HOGE

```

```
# addonを導入する
$ heroku addons:add heroku-postgresql
```
