## cloud desigin pattern

## memo
### snapshot
- snapshotを取る
- ブートディスクの容量が大きくなると仮想サーバの起動が遅くなるらしい
- ブートとデータディスクをわけて、データディスクをスナップショットするとかも考えられるとのこと
- disposalに扱うことを考えるとブートとデータをわけないほうがいいかなー
- 暗号化したディスクを他のアカウントに公開しても利用できない

### scaleup
- スモールスタートで、リソースが足りなくなったら増やす
- 垂直スケール

### scaleout
- 水平スケール
- ELBでconnection drainingをオンにすると、処理中のリクエストが完了するまでインスタンスの登録解除をしないようにできる。
- デフォルトで有効になっているらしい。
- http://kakakakakku.hatenablog.com/entry/2016/05/18/184633
- スパイクに対応はできないので事前に準備するとかの対応が必要

    > ELBにはスペックに応じて分散量を変える仕組みは備わっていないので、配下のEC2インスタンスタイプは統一したほうがよい。

- へー

### ondemand disk
- diskも必要になったら増やすパターン
- 16TB、20,000IOPS以上のスループットが必要なときは複数のEBSでストライピングするらしい。
- http://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/raid-config.html
- snapshotとか取りにくくなるので、よほどのことがない場合はやらないほうがいいかも

### Multi-Server
- サーバを複数台用意する。前段にELBを
- N+1構成にする。2台必要であれば3台用意する的な。ギリギリを攻めるのではなくて、1台死んでもサービス影響しないってのが大事そう

### Multi-Datacenter
- DRを考えた構成？AZを分けるとか
- AZをまたぐと若干速度が落ちるので、許容するのかどうか考える

### Floating IP
- EIPを付け替えることで高速に切り替えする（数秒）
- ENIには複数のIPを割り当て可能

### Deep Health Check
- ELBのヘルスチェックで深い所まで健全性を確認する
- プログラムを用意してDBでの処理までするとか
- Auto Scaleとの組み合わせはダメ。DBに障害があるのにWebが入れ替わり続けたりする
- 副作用いろいろありそうなので、DBまではやらないほうがよさそうかな。

### Routing Based HA
- DNSではなく、ルーティングの変更によって切り替える方法
- どのサーバがどのIPかを把握して向き先をどう切り替えるかをイメージしないと変なルーティングにしてしまいそう。切り替えは早いみたいなので、うまく使えればよさそうではある

### Clone Server
- 既に動いているEC2をシードにしてサーバを複数台構成にする
- マスターEC2と他のEC2で同期を取る
- 積極的に利用するケースはないかも

### NFS Sharing
- NFSサーバをマウントしてコンテンツを同期的に扱う
- NFSがSPOFになるのでGlusterFSなども検討
- 今だとEFSもあるので、NFSの管理の大変さがなくなって使えるかも？
- パフォーマンスは考慮したほうがいい

### NFS Replica
- NFSを利用するサーバが多くなった際のパフォーマンス劣化を防止する方法。
- NFSの情報を各サーバのEBSにコピーして使う。
- AutoScalingするときは、初回起動時にNFSの情報をコピーして起動する
- NFSの情報を更新するにはrsyncなどが必要になる。

### State Sharing
- セッション情報をKVSに逃がす
- ElastiCache,NoSQL,RDSなど
- パフォーマンスが求められるときはDynamoDBがいいらしい

### URL Rewriting
- 静的コンテンツはCloudfrontやS3にアクセスさせるようにする
- 直接HTMLを修正する以外にもWebサーバでHTMLをリライトすることも可能

### Rewrite Proxy
- コンテンツを格納したサーバの手前にプロキシサーバを配置し、アクセス先をCDNやストレージに向ける
- ELB <-> Proxy <-> CDN

### Cache Proxy
- Webサーバの前段にキャッシュサーバを置き、変化の少ない動的・静的コンテンツはそこで配信する
- Varnishとかでやる
- リバースプロキシって感じ

### Scheduled Scale Out
- 負荷がかかる時間帯がわかる場合にインスタンスの増減を計画しておく

### IP Pooling
- IP制限を加えたい場合に事前にEIPを確保しておき、新しくサーバを起動したときにIPアドレス一覧から未使用のものを紐付ける
- privateのネットワークにWebサーバを確保している場合、IPはNatのものになるのでこのパターンとはずれるかも

### Web Storage
- でかいファイルをS3のWebホスティングを使って直接ダウンロードさせる

### Direct Hosting
- S3ですべてを簡潔させる？
- 署名付きURLを発行すれば利用者を限定できる
- バケットポリシーでのアクセス制限も可能
- Cognitoでセキュリティトークンを発行してクライアントからファイルアップロード可能にしたり、lambdaで何らかの処理することでEC2が不要になる

### Private Distribution
- 制限付きURLを発行して、それをクライアントに利用させる
- EC2にアクセスして制限付きURLを取得した後にS3からコンテンツをダウンロードする

### Cache Distribution
- 全世界からアクセスがある場合にエッジのサーバを用意するとレスポンス遅延が減るって話
- オリジンを更新してもキャッシュが残ってしまうので、そのあたりの考慮が必要。fastlyだとpurgeが出来たはず。

### Rename Distribution
- Cache Distributionでのデメリットを回避するやり方
- 更新したいファイルを別の名前で配置することで、新しくキャッシュさせる仕組み
- ベースコンテンツはマスターサーバから配布するようにして、マスターサーバで更新後のファイルへアクセスするようにリンクをリネームする

### Private Cache Distribution
- CDNで特定のユーザにのみコンテンツを配布したい場合の方法
- Webサーバで署名付きURL/署名付きcookieを発行してCDNのコンテンツにアクセスさせる

### Latency Based Origin
- オリジンサーバを地域毎に用意することで、どこからでも同じURLでアクセスさせることができる
- Route53でRouting PolicyをLatencyにして一番近くのリージョンのEC2にアクセスさせるようにする

### Write Proxy
- S3は書き込みが遅いので、アップロードする際にはクライアントからではなくEC2から書き込みを行う
- EC2から書き込むときは高速なネットワーク・プロトコルを利用するとよい

### Storage Index
- S3は特定ユーザのデータ一覧取得や日付範囲の取得が得意ではない。
- EC2からS3にアップロードするときに、そのメタ情報をKVS等に保存しておくとよい。

### Direct Object Upload
- ユーザが大きいサイズのデータをアップロードするときのパターン
- ネットワーク帯域が辛いので、S3に直接アップロードさせる
- WebサーバでS3アップロード用のフォームを作る

### Job Observer
- SQSのキューの数を見てAutoScalingする

### Fanout
- SNS+SQSで並列処理

### Bootstrap
- S3やgitにパラメータを用意して、cloud-initとかを使ってAMIからの起動時に取得して、セットアップを行う
- consul + stretcherのpull型の仕組み

### Cloud DI
- サーバ固有の情報を外出しておきたい場合に有効
- 起動時にtagにEIPの情報やDBサーバの向き先、サーバ名などを外出しておき、タグに従ってEC2の初期化を行う
- タグに入り切らない文字数の場合は、渡したい情報のポインタをタグにセットする

### Server Swapping
- EC2自体に障害が発生した場合、そのEBSを使って別サーバを起動させることでダウンタイムを減らす

### Weighted Transition
- システムを移行する際にRoute53の重み付けを使って徐々に新システムに切り替えを行っていく技法

### Ondemand Activation
- bastionなどの踏み台サーバは必要なときにのみ起動させる

### Backnet
- ENIを2つつけて片方は外部公開用、片方は管理用として利用する

### Operational Firewall
- 複数の組織が開発保守する場合に組織毎にSGを分ける
- EC2には複数のSGを付けられるので、それを利用
- ホワイトリスト形式で利用

### Multi Balancer
- Webアプリケーションをマルチデバイス対応するような場合にデバイス毎にELBを作成して、同じアプリケーションにアクセスさせる。デバイス毎に分けるのはSSLやセッションの振り分けの問題
- このパターンを使わなくても、一つのENIに複数のIPアドレスを利用できるので、同一EC2で複数のSSLを利用できる
  - [１つのインスタンスで240個のSSLサイトをホストしてみた \- log4moto](http://d.hatena.ne.jp/j3tm0t0/20121204/1354621074)

### WAF Proxy
- Webサーバの前にプロキシサーバを挟んでそこにWAFを入れる
- Webサーバへの影響無しで導入できる

### Sorry Page
- Route53のfailoverを使って、バックエンドの障害児にS3のSorryページを表示させる

### Self Registration
- 自分のメタ情報をKVSに登録して停止時に削除する
- ConsulのKVっぽい
- 正常終了しなかった際のKVSの整合性チェックも必要

### Shared Service
- システム共通のサービスを各サービスから利用させたい場合のパターン
- 各サービスとシステム共通サービスはVPCでわけ、VPC peeringで接続する

### High Availability NAT
- privateにEC2を置く際の外部への通信時に通る道
- 今だとNAT GatewayをMultiAZ化する感じかな。


## 参考
- http://aws.clouddesignpattern.org/index.php/%E3%83%A1%E3%82%A4%E3%83%B3%E3%83%9A%E3%83%BC%E3%82%B8#AWS_Cloud_Design_Pattern_.28CDP.29.E4.B8.80.E8.A6.A7
- http://en.clouddesignpattern.org/index.php/Main_Page
- http://aws.typepad.com/sajp/2016/10/blackbelt-architecture-best-practice.html
- [12 Fractured Apps – Medium](https://medium.com/@kelseyhightower/12-fractured-apps-1080c73d481c#.e4i9clpkf)
