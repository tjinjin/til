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
