## トップレベル
メソッド呼び出しの際レシーバを記述しない

## 変数
- グローバル変数： $で始まる
- 定数：大文字から始まる。再代入もWarningが出るが出来てしまう


## 真偽値
- falseとnil以外は真になる


## クラスメソッド
- selfが付いたメソッド


## 手続きオブジェクト

```ruby
greeter = Proc.new{|name|
  puts "Hello, #{name}"
}
greeter.call 'Proc' # "Hello, Proc"
greeter.call 'Ruby' # "Hello, Ruby"

# 違う書き方
by_proc = proc{|name| puts "Hello, #{name}!" }
by_lambda = lambda{|name| puts "Hello, #{name}!" }
by_literal ->(name) { puts "Hello, #{name}!" }
```
