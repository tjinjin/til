## Rails5.X
https://devcenter.heroku.com/articles/getting-started-with-rails5

## Railsアプリを作る

```
$ be rails new myapp -d postgresql
$ cd myapp
$ be rails g controller welcome
$ vim app/views/welcome/index.html.erb
<h2>Hello World</h2>
<p>
  The time is now: <%= Time.now %>
</p>
```

```
$ vim config/routes/rb
Rails.application.routes.draw do
  root 'welcome#index'
end
$ be rails db:create
```

ここまで来れば`rails s` してローカル上でアプリが見られる

## herokuにdeploy

```
$ git init
$ git add .
$ git commit -m "init"
```

```
# appを作成する
$ heroku create
$ git config --list | grep heroku

# pushしてアプリがdeployされる
$ git push heroku master

# deployしたアプリを確認する（この時点ではエラー
$ heroku apps:info

# dbをmigrate
# ログインしてrails db:migrateを叩く
$ heroku run rails db:migrate

# ブラウザで開く
$ heroku open

# アプリの状況を確認する
$ heroku ps

# ログを確認する
$ heroku logs
$ heroku logs --tail
```

## 番外編

```
# pumaを利用する
$ vi Procfile
web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
```
