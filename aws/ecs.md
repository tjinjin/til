## ECS

## クラスタのスケーリング
ちゃんと設定ができていればECSの画面で[Scale ECS Instances] というボタンが表示される。

## ECS agent
- nannyというのが動いているらしい https://linux.die.net/man/8/nanny
- あとecs-initと呼ばれるもの https://github.com/aws/amazon-ecs-init

##  ストレージ
- dockerコンテナが停止・終了したあとにデフォルトでは3時間は残っているらしい
  - ECS_ENGINE_TASK_CLEANUP_WAIT_DURATION で設定できる
- 最適化インスタンスはrootとdocker image用で２つのディスクがアタッチされている。ただし後者はマウントはしていないので、dfコマンドでは見えない

## コンテナインスタンス
- インスタンス起動時にclusterにジョインする
- /etc/ecs/ecs.configにuser_dataを使って書き込むのもあるが、S3にファイルをおいてコピーするのもありとのこと
- user_dataはcloud-boothookで行っていて、実行タイミングはインスタンス起動後。dockerデーモンをカスタマイズしたちときはcloud-init-perを使う
- MIMEマルチパートアーカイブというのがある

## ログ
- CloudWatch Logsにはcloudwatchエージェントが送っている

## コンテナインスタンスのドレイン
- コンテナインスタンスをドレイニングにすると、新規タスクがコンテナインスタンスに配置されなくなる。リソースがあまっていれば他のインスタンスでサービスタスクを実行する。
- サービスのデプロイ設定パラメータに応じてローリング方法が変わる
- 動いているタスクがなくなるとドレインを終了する。ただし、ステータス上はドレインのままなので自分で停止させる必要がある？

## コンテナエージェントの設定
- http://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/ecs-agent-config.html
- ECS_ENGINE_TASK_CLEANUP_WAIT_DURATION タスクが停止してからdockerコンテナが削除されるまでの時間
- ECS_UPDATES_ENABLED ECS エージェントの更新がリクエストされた場合に終了するかどう defaultはfalse
- ecs.configはS3においておくのが基本っぽい？

## コンテナイメージのクリーンアップ
- サイクルなどを指定できるので頻度に合わせて設計する


## プライベートレジストリの利用
- 環境変数を使って認証情報を設定できる


## タスク定義パラメーター
- memory メモリのハードリミット
- memoryReservation メモリのソフトリミット
- essential trueだと何らかの理由でコンテナが死んだときにタスクに含まれるすべてのコンテナは停止される

## タスクのスケジューリング
- RunTask -> クラスタ内のコンテナインスタンスからランダムで実行
- StartTask -> Task実行時に指定した特定のコンテナインスタンスで事項


## タスクの配置
- 基本のタスク配置戦略は
  - binpack（CPUやメモリを最適化する配置。使用するインスタンス数を抑える）
  - random 完全にランダム
  - spread 指定された値にもとづいてタスクを均等に配置。属性、InstanceID、host
- タスク配置の条件としてattributeによって配置を制御できる。クラスタークエリ言語がある。
  - 例えばインスタンスタイプによってやAZによって配置するなどが可能。attributeは自分で作成できる

## サービス
- サービスは指定したコンテナ数を維持しようとする
- serviceで定義できるもの（一部
  - clientToken: リクエストのべき等のために割り当てる一意の識別子
  - deploymentConfiguration: デプロイ時に実行されるタスクの数と、タスクの停止及び開始の順序を制御するオプション
  - placementConstraints: サービスのタスクに使用する、配置制約オブジェクトの配列。
  - placementStrategy: サービスのタスクで配置戦略するオブジェクト

## サービスのAuto Scaling
- CloudWatchアラームに応じて必要数を調整できる
- CPUとメモリ以外にもELBのメトリックやSQSのメトリックに応じてタスクのスケーリングが可能
  - ECSとEC2のAutoScalingは別個のもの。

## サービスの更新
- serviceのタスク定義が更新されると、新しいコンテナに置き換わる。これはデプロイ戦略によって判断される
- コンテナの置き換えはまずLBからの切り離し、その後接続のdraining待ちとなり、完了後にdocker stopと同等のコマンドが実行される

## コンテナインスタンスのスケーリング
- AutoScalingGroupのpolicyで指定

## コンテナを安全に止めるには
- Auto Scaling Lifecycle Hooksと連携
  - スケールイン時インスタンスはTerminating:Wait状態になれる
  - そのフックイベントでインスタンスをDRAINING
  - LambdaとかでタスクがなくなったらTerminateする
- Spotインスタンスの削除通知
  - 削除の2分前にインスタンスのメタデータ経由で通知が来る
  - イベントを受け取ったらDRAININGする
