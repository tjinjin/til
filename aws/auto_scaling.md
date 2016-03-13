## Auto scalingとは
EC2インスタンスを動的に増減が可能な機能。負荷状況に応じて増やしたり、あるインスタンスで障害が起きた時、自動で新しいインスタンスを構築できたりできる。

* インスタンスの異常を検知して、新しいインスタンスを起動でき耐障害性が向上する。
* 一つのAZが起動できなくなると、もう一方のAZに移る。
* コストの削減。必要な分だけインスタンスを立てることができる。

## Auto scalingの機能
### 複数AZへのインスタンス分散
一つのAZが起動できなくなると、もう一方のAZに移る。その後、復旧するとAZ間でインスタンス数を分散させようとする。注意が必要かも。

### 起動設定(Launch configuration)
起動時のAMIやインスタンスタイプなどを設定できる。起動中のインスタンスを使用して設定を作成することもできる。

設定できるのは下記
* AMI
* インスタンスタイプ
* spot intanceの利用有無
* IAM role
* CloudWatchでのMonitoring
* User dataの指定
* IP Addressの割当指定。publicIPを与えるとか
* Volumeの指定。追加も可能
* Security Groupの指定


### グループ(Auto scaling group)

EC2インスタンスの集合。1つの起動設定を指定できる。インスタンス終了時のライフサイクルなどを指定できる。

利用するには名前と最大許容数と最小許容数だけでよいがあまり意味がない。下記の設定もしたほうがいい。

* 希望する容量
* 複数AZを利用するような設定
* 起動設定を指定
* メトリックスとヘルスチェック指定をしてスケールアウト、インの指定と障害の検知を決めるべき

設定できる項目は下記

* Launch Configuration
* Groupの名前
* 希望するインスタンス数
* 利用するサブネット（複数選択可能）
* ELBの指定
* ヘルスチェックの猶予期間。インスタンスが起動してから何秒待つか
* CloudWatchでのMonitoring
* スケールイン時のインスタンス保護。これを設定すると勝手にterminateされなくなる
* スケールアウト・イン時の指定
* 通知設定。インスタンスの起動成功、起動失敗、終了、終了失敗など指定されたタイミングで通知できる
* タグ

#### ライフサイクルフック
インスタンスの起動・終了時などに特定のイベントをフックできる

Pending:Wait/Terminating:Waitの間にイベントが実行される。この時間はデフォルトで1時間で、それを超えると、起動・終了状態になる。

##### 待機時間
先ほどの通りデフォルトでは3600秒。待機状態は`RecordLifecycleActionHeartbeat`などを使うことで最大48時間まで調整できる。その他Heartbeatでタイムアウト値を定義したり、`CompleteLifecycleAction`を使うことで即座に待機を終わらせることができる。

#### その他できること
* 既存のインスタンスのアタッチ・デタッチ
* 複数AZのマージ
* 一時的にインスタンスを削除


### スケーリングプラン
#### クールダウン
ClowdWatchのアラームをCPUの90%にしたとして、アラートが起きた場合にインスタンスが起動するが、利用できるようになるまでに数分かかる。その間もアラートが来ると、再度インスタンスを起動させようとしてしまうがそういったものを防ぐ仕組みがクールダウン。クールダウン中は他のアクションが実行されない。

#### 終了時の挙動
どのインスタンスを終了させるかポリシーで指定が可能

* `OldestInstance`:最も古いインスタンスを終了。徐々に置き換えるときに。
* `NewestInstance`:最も新しいインスタンスを終了。新しいものの起動テストとかに。
* `OldestLaunchCofiguration`:最も古い起動設定を終了。古い設定を置き換えるときに。
* `ClosestToNextInstanceHour`:次の課金時間に一番近いものを。コスト削減に。
* `Default`:デフォルトの終了ポリシーを利用。複数のポリシーがある場合に。

#### ヘルスチェックについて
デフォルトでは、インスタンスステータスが`running`以外、システムステータスが`impaired`である場合は異常とみなす。

ELBのヘルスチェックを利用する場合は、OutofServiceだと異常とみなす。

#### スケーリング
事前に予測してスケーリングプランを設定できる。コンソールから設定可能。


## 使いドコロを考える
auto scalingでのヘルスチェックと、アプリケーションとしてのヘルスチェックが同期されていることが好ましいと思われる。Auto hearlingにより新しいインスタンスが出来たり、再分散によってAZの平均を取ろうとするので、インスタンス起動＝サービスインが前提になっている気がする。

## Terraformでの使い方
Terraformでは5つのリソースをサポートしている
* [AWS: aws_autoscaling_group - Terraform by HashiCorp] (https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html)
* [AWS: aws_autoscaling_lifecycle_hook - Terraform by HashiCorp] (https://www.terraform.io/docs/providers/aws/r/autoscaling_lifecycle_hooks.html)
* [AWS: aws_autoscaling_notification - Terraform by HashiCorp] (https://www.terraform.io/docs/providers/aws/r/autoscaling_notification.html)
* [AWS: aws_autoscaling_policy - Terraform by HashiCorp] (https://www.terraform.io/docs/providers/aws/r/autoscaling_policy.html)
* [AWS: aws_autoscaling_schedule - Terraform by HashiCorp] (https://www.terraform.io/docs/providers/aws/r/autoscaling_schedule.html)

### aws_autoscaling_group
auto scaling groupの設定。この設定が基本で、launch_configurationで各インスタンスの起動時の挙動を決め、こちらでグループ全体の設定を定義する

### aws_autoscaling_lifecycle_hook

### aws_autoscaling_notification

### aws_autoscaling_policy


### aws_autoscaling_schedule
スケジュールの設定。特定時間帯で台数を変更するなどの設定をする。

#### start_time/end_time
スケジュールの時間を設定する。

#### recurrent
cronのフォーマットで時間を設定する。こっちを使えば、繰り返し処理（週末は台数減らすなど）の処理ができる。両方合わせて使用すると、recurrentの開始、終了をstart_time/end_timeが指し示すと思われる（未検証）

## 注意点
* auto scalingを使うにはcloudwatchの詳細モニタリングの利用が必須で、インスタンスあたり、毎月$3.5かかる。

## Link
* [What Is Auto Scaling? - Auto Scaling] (http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/WhatIsAutoScaling.html)
* [【AWS】Auto Scalingまとめ - Qiita] (http://qiita.com/iron-breaker/items/2b55da35429da7b19e49#auto-scaling%E3%81%AE%E8%A8%AD%E8%A8%88%E8%80%83%E6%85%AE%E3%83%9D%E3%82%A4%E3%83%B3%E3%83%88)
