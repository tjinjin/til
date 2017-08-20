## Elasticsearch
- クラスタースケーリングオプション
- 自己修復クラスター
- 可用性を高めるレプリケーション
- データの耐久性
- 強化されたセキュリティ
- ノードモニタリング

### Amazon ESの特徴
- インスタンスタイプと呼ばれる、CPU、メモリ、ストレージ容量の複数の設定
- Amazon EBS ボリュームを使用したデータ用のストレージボリューム
- リージョンおよびアベイラビリティゾーンと呼ばれる、リソース用の複数の地理的場所
- ゾーン対応と呼ばれる、同じリージョン内の 2 つのアベイラビリティーゾーンにまたがるクラスターノード割り当て
- AWS Identity and Access Management (IAM) のアクセスコントロールによるセキュリティ
- クラスターの安定性を高める専用マスターノード
- Amazon ES ドメインをバックアップおよび復元し、アベイラビリティーゾーン間でドメインをレプリケートするドメインスナップショット
- Kibana ツールの使用によるデータの可視化
- Amazon ES ドメインメトリクスをモニタリングするための Amazon CloudWatch との統合
- Amazon ES ドメインへの設定 API 呼び出しを監査するための AWS CloudTrail との統合
- Amazon ES にストリーミングデータをロードするための Amazon S3、Amazon Kinesis、Amazon DynamoDB との統合

### Amazon ESでのスケーリング
- データ量またはデータサイズの増加
  - 大きいインスタンスタイプの選択か、インスタンスの追加
  - EBSのサイズを大きくする
- Elasticsearchリクエストのボリュームと複雑さによるトラフィックの増加
  - 大きいインスタンスタイプを選択
  - インスタンスを追加
  - レプリカシャードを追加

### 署名サービスリクエスト
ESのAPIに直接アクセスするよりも、SDKを利用したほうが楽なケースがある。（署名の問題らしい）

## ESドメインの作成
- domain name
- Version
- Instance count
- Instance type
- Enable dedicated master: 専用マスターノードの有無
- Enable zone awareness: ゾーン対応
- EBS
- Automated snapshot start hour: 自動のスナップショットの時間
- rest.action.multi.allow_explicit_indes: ドメインのサブリソースへのアクセス
- indices.fielddata.cache.size: フィールドデータキャッシュに割り当てるヒープスペースの割合
- アクセスポリシー

## Amazon Elasticsearch Service ドメインの作成と設定
- 10を超えるインスタンスが存在する場合は専用マスターノードを作る。スプリットブレインの問題などがあるので、奇数が推奨。3がよい
- Enable zone awarenessをオンにするとデータノードが同じリージョンの複数のAZに分散される

### アクセスポリシーの設定
#### リソースベース
> リソースベースのアクセスポリシーは、特定の Amazon ES ドメインにアタッチされます。リソースベースのポリシーでは、ドメインのエンドポイントにアクセスできるユーザーを指定します。アクセスを許可されたユーザーを指定するには、Principal ポリシーエレメントを使用します。アクセス可能なリソースを指定するには、Resource ポリシーエレメントを使用します。


#### IPベース
> IP ベースのアクセスポリシーは、Amazon ES ドメインへのアクセスを 1 つ以上の特定の IP アドレスに制限します。匿名アクセスを許可するように IP ベースのポリシーを設定することもできます。これにより、未署名のリクエストを Amazon ES ドメインに送信できるようになります。サービスへのアクセスが許可される IP アドレスを指定するには、Condition ポリシー要素を使用します。

curlなどを使う場合には必須

#### IAMユーザとロールベース
> Amazon ES では、IAM ユーザーおよびロールに基づくアクセスポリシーもサポートされます。サービスにアクセスできるユーザーおよびロールと、それらのユーザーおよびロールが使用できるサブリソースを指定するには、IAM サービスを使用します。

## ドメインの管理
### 専用マスターノードのスペック
インスタンス数に応じたインスタンスタイプの目安がある

マスターノードの負荷状況には下記を見る

- MasterCPUUtilization: アクティブのときに40%,ドメインの更新中に60$を超える場合はスケールアップを検討
- MasterJVMMemoryPressure: アクティブのときに60%, 処理中のときに85%を超える場合スケールアップを検討

### ゾーン対応
同じリージョンの2つのAZにノードとレプリカインデックスシャードを割り当てることができる

- インスタンス数を偶数にしないといけない

### snapshot
AWS提供の自動スナップショットの復元はAWSサポートへの連絡が必須。自身で手動スナップショットを撮影しそれをS3にアップロードするとよい。

- S3バケットの作成
- ESにIAMロールを付与（サービスロール）
- IAMポリシーの付与
- snapshotディレクトリの登録（初回のみ,pythonのスクリプトがある）

snapshotの復元は同じESドメインのインデックス削除 -> 復元
異なるドメインにスナップショットの復元

#### command

```
# 削除
curl -XDELETE 'http://search-weblogs-abcdefghijklmnojiu.us-east-1.example.com/_all'

# 復元
curl -XPOST 'http://<Elasticsearch_domain_endpoint>/_snapshot/snapshot_repository/snapshot_name/_restore'
curl -XPOST 'http://search-weblogs-abcdefghijklmnojiu.us-east-1.example.com/_snapshot/weblogs-index-backups/snapshot_1/_restore'
```

### モニタリング

## ダウンタイム
ESドメインのスケーリングはオンライン操作なのでダウンタイムはない。index, search, data upload等

- インスタンス及びストレージボリュームの追加または変更
- アクセスポリシーの変更

## Link
http://www.slideshare.net/AmazonWebServicesJapan/aws-black-belt-tech-webinar-2016-amazon-cloudsearch-amazon-elasticsearch-service


