## SQS
メッセージキューイングサービス

### 課金体系
主に下記の2つ

* リクエスト
* データ転送

ElasticCache運用と比べると安い！


## 参考
* [Amazon Simple Queue Service（メッセージキューサービス） | AWS] (https://aws.amazon.com/jp/sqs/)
* [【AWS】SQSキューの前には難しいこと考えずにSNSトピックを挟むと良いよ、という話 ｜ Developers.IO] (http://dev.classmethod.jp/cloud/aws/sns-topic-should-be-placed-behind-sqs-queue/)
* [Comentários no Disqus] (http://disqus.com/embed/comments/?base=default&version=208e70781fad1709ad376036d91294bc&f=pablocantero&t_u=http%3A%2F%2Fwww.pablocantero.com%2Fblog%2F2015%2F03%2F14%2Fsidekiq-redis-vs-shoryuken-aws-sqs%2F&t_d=Sidekiq%20(Redis)%20vs%20Shoryuken%20(AWS%20SQS)&t_t=Sidekiq%20(Redis)%20vs%20Shoryuken%20(AWS%20SQS)&s_o=default)
* http://www.slideshare.net/AmazonWebServicesJapan/aws-black-belt-tech-amazon-sns-amazon-sqs

## blackbelt
### 効率よくAmazon SQSを使う
- Visibility Timeout + EC2 Spot Instance
  - Visibility Timeoutはworkderが受信している間は他のworkerから見えない秒数（in Flight）
- 一度のAPIコールで10件のメッセージを送信/受信
- Long PollでReceive Messageコールの頻度を抑える
- 基本的にLong Pollingが推奨
- 複数キューを単一スレッドでポーリングする場合、Long Pollingするとその間、他のキューにアクセスできない

### 利用上の注意点
- 順序はベストエフォート
  - timestampやシーケンス番号をメッセージに含める
- 同じメッセージを複数回受信しり可能性がある（at least once）
  - 冪等性がある作りにする

### 時間をおいてからメッセージを見せたい
- 遅延キュー
  - キューに送られた新しいメッセージをある一定秒見えなくする
- Message Timers
  - 個々のメッセージに送信されたから見えるようになるまでの時間を設定。Delay Queueをウワ額

### Dead Letter Queue
メッセージを指定回数受信後に自動で別のキューに移動する

### Job Observerパターン
SQSのキューに応じてAuto Scalingの台数を調整する

## document
