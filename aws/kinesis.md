## kinesis

## 用語整理
### プロデューサー
レコードをkinesis streamsに入れる主体

### コンシューマー
kinesisからレコードを取得する主体

### シャード
- 読み取りは最大1秒あたり5件のトランザクション
- データ読み取りの最大合計レートは1秒あたり2MB
- 書き込みについては最大1秒あたり1000レコード
- データ書き込みの最大合計レートは1秒あたり1MB（パーティションキーを含む）

### パーティションキー
ストリーム内のデータをシャード単位でグループ化するために使用される。どのシャードにデータを流すかはパーティションキーを使用して決める

## 設計のポイント
シャード数をどうするか？

最大トラフィックのシャード数とするか、需要の変動に応じてストリームを拡大縮小するかを選択する

- 平均レコードサイズ
- 1秒間に書き込まれる最大レコード数
- コンシューマーアプリケーションの数

## CLIを使った動作確認
### レコードの入力

```
aws kinesis put-record --stream-name Foo --partition-key 123 --data testdata
```

### レコードの取得

shard-iteratorを取得する

```
aws kinesis get-shard-iterator --shard-id shardId-000000000000 --shard-iterator-type TRIM_HORIZON --stream-name Foo
```

取得したshard-iteratorを使ってデータを取得する（Base64)

```
aws kinesis get-records --shard-iterator AAAAAAAAAAHSywljv0zEgPX4NyKdZ5wryMzP9yALs8NeKbUjp1IxtZs1Sp+KEd9I6AJ9ZG4lNR1EMi+9Md/nHvtLyxpfhEzYvkTZ4D9DQVz/mBYWRO6OTZRKnW9gd+efGN2aHFdkH1rJl4BL9Wyrk+ghYG22D2T1Da2EyNSH1+LAbK33gQweTJADBdyMwlo5r6PqcP2dzhg=
```

## Kinesis Streamsの推奨メトリクス

- GetRecords.IteratorAgeMilliseconds
  - 現在の時刻と  GetRecords 呼び出しの最後のレコード がストリームに書き込まれた時間の差 値が⼤大きい場合、シャードの分割とコンシューマーのス ケールアウトを検討
- ReadProvisionedThroughputExceeded
  - スロットリングされた  GetRecords 呼び出しの回数 断続的に発⽣生している場合、シャードの分割とコン シューマーのスケールアウトを検討
- WriteProvisionedThroughputExceeded
  - スロットリングされた  PutRecord および   PutRecords 呼び出しの回数 断続的に発⽣生している場合、シャードの分割を検討
- PutRecord.Success, PutRecords.Success
  - 成功した  PutRecord 呼び出しの回数および少なくと も  1  レコードが成功した  PutRecords 呼び出しの回 数 ストリームへの送信失敗を検出
- GetRecords.Success
  - 成功した  GetRecords 呼び出しの回数 ストリームからの受信失敗を検出

black beltより https://image.slidesharecdn.com/20160810aws-blackbelt-kinesis-160815123037/95/aws-black-belt-online-seminar-2016-amazon-kinesis-46-638.jpg?cb=1471264435

# document
## kinesisとは
## Amazon Kinesis Streamsへのデータの書き込み
### KPLとは
- Kinesis Producer Library
  - 自動的で設定可能な再試行メカニズムにより 1 つ以上の Kinesis stream へ書き込む
  - レコードを収集し、PutRecords を使用して、リクエストごとに複数シャードへ複数レコードを書き込む
  - ユーザーレコードを集約し、ペイロードサイズを増加させ、スループットを改善する
  - コンシューマーで Kinesis Client Library（KCL）とシームレスに統合して、バッチ処理されたレコードを集約解除する
  - Amazon CloudWatch メトリクスをユーザーに代わって送信し、プロデューサーのパフォーマンスを確認可能にする
- KPL では、ライブラリ内で最大 RecordMaxBufferedTime まで追加の処理遅延が生じる場合がありため、遅延を許容できない場合は自分で実装する
- KPLでレコードの集約をしている場合、KCL側でレコードの集約解除をして上げる必要が出てくる

### kinesis agent
OSに直接入れて、ログなどをkinesisに流すことができる

### KCL
> KCL は Java ライブラリです。Java 以外の言語のサポートは、MultiLangDaemon という多言語インターフェイスを使用して提供されます。このデーモンは Java ベースで、Java 以外の KCL 言語を使用するときに実行されます。 たとえば、KCL for Python をインストールして、コンシューマーアプリケーションをすべて Python で書く場合でも、MultiLangDaemon を使用するために、Java をシステムにインストールする必要があります

- ストリームに接続する
- シャードを列挙する
- シャードと他のワーカー（存在する場合）の関連付けを調整する
- レコードプロセッサで管理する各シャードのレコードプロセッサをインスタンス化する
- ストリームからデータレコードを取得する
- 対応するレコードプロセッサにレコードを送信する
- 処理されたレコードのチェックポイントを作成する
- ワーカーのインスタンス数が変化したときに、シャードとワーカーの関連付けを調整する
- シャードが分割またはマージされたときに、シャードとワーカーの関連付けを調整する

### Amazon Kinesis Streamsコンシューマのトラブルシューティング
- 同じシャードに属するレコードが複数のレコードで実行される可能性

## 高度なトピック
- KCLを使うとDynamoDBを使うようになる。状態の追跡に利用しているっぽい
- kinesisの遅延に最も影響するのはコンシューマ側のポーリング感覚。1秒がよいと思われる
- LambdaでKPLが集約したレコードの解除を行うには特別なモジュールの使用が必要とのこと
- リシャーディングによってシャードが拡張したときにKCLなどでは自動で追従できるっぽい？


## リシャーディング
- できることは2つ、シャードの分割とマージ。前者では1つのシャードを2つに、後者は2つのシャードを1つに
- 実行対象のシャードおよびシャードペアは親シャードと呼ばれる

### リシャーディング戦略
リシャーディングの目的はストリームのデータ流量の変化に適応すること。

リシャーディングのトリガーは２つ考えられる。
- Cloudwatchメトリクスで、シャードがホットであるかコールドであるかを判断する
  - 具体的に何を見ればいいか調べる
- データレコードのパーティションキーによって生成されたハッシュキー値をログに記録する
  - これをチェックする仕組みを作って判断する

これからはProducer/Consumerとは別の存在が行うのがよさそう

### リシャーディング分割

- それぞれのシャードにはHashKeyRangeが定義されている。そのシャードを2つに分割したい場合は、通常はそのHasyKeyRangeの真ん中を指定して分割してやればよい。
- マネジメントコンソール上でのシャードのエディットはシャード数の増減でリシャーディングは行わないっぽい。なので、既存のシャードにたまったデータを早く処理したい場合はリシャーディングしないとダメ。

```
# shardのHashRangeを確認する
$ aws kinesis describe-stream --stream-name examplestream
{
    "StreamDescription": {
        "RetentionPeriodHours": 24,
        "StreamName": "examplestream",
        "Shards": [
            {
                "ShardId": "shardId-000000000000",
                "HashKeyRange": {
                    "EndingHashKey": "340282366920938463463374607431768211455",
                    "StartingHashKey": "0"
                },
                "SequenceNumberRange": {
                    "StartingSequenceNumber": "49576292205153501102148580626741318270310083545912049666"
                }
            }
        ],
        "StreamARN": "arn:aws:kinesis:ap-northeast-1:hogehoge:stream/examplestream",
        "EnhancedMonitoring": [
            {
                "ShardLevelMetrics": []
            }
        ],
        "StreamStatus": "ACTIVE"
    }
}
# シャードを分割する
$ aws kinesis split-shard --stream-name examplestream --shard-to-split shardId-000000000000 --new-starting-hash-key 170141183460469231731687303715884105727
$ aws kinesis describe-stream --stream-name examplestream
{
    "StreamDescription": {
        "RetentionPeriodHours": 24,
        "StreamName": "examplestream",
        "Shards": [
            {
                "ShardId": "shardId-000000000000",
                "HashKeyRange": {
                    "EndingHashKey": "340282366920938463463374607431768211455",
                    "StartingHashKey": "0"
                },
                "SequenceNumberRange": {
                    "EndingSequenceNumber": "49576300004002856343289126011049985768053015998086774786",
                    "StartingSequenceNumber": "49576292205153501102148580626741318270310083545912049666"
                }
            },
            {
                "ShardId": "shardId-000000000001",
                "HashKeyRange": {
                    "EndingHashKey": "170141183460469231731687303715884105726",
                    "StartingHashKey": "0"
                },
                "ParentShardId": "shardId-000000000000",
                "SequenceNumberRange": {
                    "StartingSequenceNumber": "49576408637188077414142288222735669739519391729014800402"
                }
            },
            {
                "ShardId": "shardId-000000000002",
                "HashKeyRange": {
                    "EndingHashKey": "340282366920938463463374607431768211455",
                    "StartingHashKey": "170141183460469231731687303715884105727"
                },
                "ParentShardId": "shardId-000000000000",
                "SequenceNumberRange": {
                    "StartingSequenceNumber": "49576408637210378159340818845877205457792040090520780834"
                }
            }
        ],
        "StreamARN": "arn:aws:kinesis:ap-northeast-1:hogehoge:stream/examplestream",
        "EnhancedMonitoring": [
            {
                "ShardLevelMetrics": []
            }
        ],
        "StreamStatus": "ACTIVE"
    }
}
# 分割したシャードを更に分割する
$ aws kinesis split-shard --stream-name examplestream --shard-to-split shardId-000000000000 --new-starting-hash-key 170141183460469231731687303715884105727
$ aws kinesis describe-stream --stream-name examplestream

{
    "StreamDescription": {
        "RetentionPeriodHours": 24,
        "StreamName": "examplestream",
        "Shards": [
            {
                "ShardId": "shardId-000000000000",
                "HashKeyRange": {
                    "EndingHashKey": "340282366920938463463374607431768211455",
                    "StartingHashKey": "0"
                },
                "SequenceNumberRange": {
                    "EndingSequenceNumber": "49576300004002856343289126011049985768053015998086774786",
                    "StartingSequenceNumber": "49576292205153501102148580626741318270310083545912049666"
                }
            },
            {
                "ShardId": "shardId-000000000001",
                "HashKeyRange": {
                    "EndingHashKey": "170141183460469231731687303715884105726",
                    "StartingHashKey": "0"
                },
                "ParentShardId": "shardId-000000000000",
                "SequenceNumberRange": {
                    "EndingSequenceNumber": "49576408637199227786741553534305228672836114887049478162",
                    "StartingSequenceNumber": "49576408637188077414142288222735669739519391729014800402"
                }
            },
            {
                "ShardId": "shardId-000000000002",
                "HashKeyRange": {
                    "EndingHashKey": "340282366920938463463374607431768211455",
                    "StartingHashKey": "170141183460469231731687303715884105727"
                },
                "ParentShardId": "shardId-000000000000",
                "SequenceNumberRange": {
                    "StartingSequenceNumber": "49576408637210378159340818845877205457792040090520780834"
                }
            },
            {
                "ShardId": "shardId-000000000003",
                "HashKeyRange": {
                    "EndingHashKey": "85070591730234615865843651857942052862",
                    "StartingHashKey": "0"
                },
                "ParentShardId": "shardId-000000000001",
                "SequenceNumberRange": {
                    "StartingSequenceNumber": "49576408708238251616660853551668468156177085162244276274"
                }
            },
            {
                "ShardId": "shardId-000000000004",
                "HashKeyRange": {
                    "EndingHashKey": "170141183460469231731687303715884105726",
                    "StartingHashKey": "85070591730234615865843651857942052863"
                },
                "ParentShardId": "shardId-000000000001",
                "SequenceNumberRange": {
                    "StartingSequenceNumber": "49576408708260552361859384174810003874449733523750256706"
                }
            }
        ],
        "StreamARN": "arn:aws:kinesis:ap-northeast-1:hogehoge:stream/examplestream",
        "EnhancedMonitoring": [
            {
                "ShardLevelMetrics": []
            }
        ],
        "StreamStatus": "ACTIVE"
    }
}
```

### リシャーディング結合
- shardを結合するにはハッシュキーの範囲が隣接していないとだめ。
- ハッシュキーのレンジはストリームごとにもっているっぽい。
-
