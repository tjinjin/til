## blackbelt

## document
### EBSのメリット
- データの可用性
  - 同じゾーン内で自動的にレプリケートされる
- データの永続性
- データの暗号化
- スナップショット

## ボリュームの種類
### gp2
最小100IOPS 〜 10000IOPSまでベースラインパフォーマンスは変化する。ストレージサイズによる

I/Oクレジットがあり、ボリュームサイズによってベースラインパフォーマンスを超えるパフォーマンスを出すときに使われる
ベースラインパフォーマンスは1GiB = 3IOPSでgp2。

### io1
I/Oのレイテンシーを考えると、IOPSとGiBの比率を2:1にするのがよいとのこと。2000IOPSだったら1000GiB

### スループット最適化(st1)
バーストモデル

IOPSではなくスループットでパフォーマンスを示す

Amazon EMR, ETL, DWH, ログ処理などサイズの大きなシーケンシャルワークロードに適する

### Cold HDD(sc1)
バーストモデル

データへのアクセス頻度が低くコストが重要な場合に有用

### マグネティック（standard)
平均約100IOPSでバースト能力は最大約数百IOPS

### HDDボリュームの使用上の考慮事項
フルスキャンの時間をざっくり試算できるので、確認の上何を使うか選択すること

#### HDDに対する読み取り・書き込みサイズが小さい場合の非効率性
st1/sc1はシーケンシャルI/Oに最適化され、高スループットのワークロードに適する。一方サイズの小さなランダムI/Oのワークロードには向かない

## ステータスチェックによるボリュームのモニタリング
ボリュームのデータに潜在的に不整合があると判断された場合、デフォルトでアタッチされたすべてのEC2インスタンからボリュームへのI/Oが向こうになる。
I/Oが向こうになると次のボリュームステータスチェックが失敗し、ボリュームステータスはimpairedになる

## LinuxのEBSボリュームサイズ、IOPS、タイプの変更
ボリュームサイズを変更してもLinux側でファイルシステムの拡張をしないとダメ
IOPSの変更は数分から数時間かかる可能性がある
ルートボリュームの変更にはインスタンスの再起動が必要

## EBSボリュームの変更に関する考慮事項
- EBSボリュームのサイズを小さくすることはできない。rsyncなどで小さいボリュームに移すなどをすること
- 一度変更したボリュームの変更を置こうなうには6時間以上待つ必要がある
- Linux AMIでは2TiB以上のブートボリュームについてはGUIDパーティションテーブル(GPT)とGRUB2が必要

## EBSスナップショット
- スナップショットは増分バックアップ
- 暗号化されたボリュームのスナップショットは暗号化される
- スナップショットはコピーすることが可能
- 他リージョンへの最初のスナップショットコピーは常に完全コピー

## EBS最適化
インスタンスの属性。起動時に指定できる

## EBS暗号化


## EBSパフォーマンス
パフォーマンスを理解するために

- EBS最適化インスタンスの利用
- パフォーマンスの計算方法を理解
- ワークロードを理解
- スナップショットからボリュームを初期化する際のパフォーマンス低下を理解する
- HDDパフォーマンスが低下する要因
- st1/sc1で読み取りの多い高スループットワークロードは先読みを1MiBに設定する
- 最新のカーネルを利用する
- RAID 0を使用してインスタンスのリソース使用率を最大化する

### EC2の構成
- ec2のパフォーマンスの目安があるので参考にする
- http://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/ebs-ec2-config.html

### I/O特性とモニタリング
#### IOPS
- SSDだと最大I/Oサイズは256KiB, HDDだと1,024KiB
- 小さなI/O操作が物理的に連続している場合、EBSは最大サイズになるまで単一のI/Oにマージして処理する
- 1,024KiBのI/Oは4, 32KiB * 8のI/Oは1つとしてカウントされる
- ただし、32KiBの8つのランダムI/Oは8つの操作としてカウントされる
- HDDだと1,024KiBも8つの連続する128KiBも１つのカウントになる
- ただし, 128KiBのランダムI/O操作8つは8カウント

#### ボリュームのキュー長とレイテンシー
- ボリュームのキュー長とはデバイスに対する保留中のI/Oリクエスト数
- レイテンシーは実際にI/O操作にかかるエンドツーエンドのクライアント時間
- トランザクションの多いワークロードでは、I/Oレイテンシーの上昇の影響を受けるため、io1/gp2が適している。キュー長を小さく抑え、高いIOPSを維持することで低レイテンシーを実現できる
- スループットが高いワークロードではI/Oレイテンシーの上昇による影響を受けにくいため、st1/sc1が適している。高いスループットを維持するにはサイズの大きなシーケンシャルI/Oを実行するときにキュー長を大きくする

#### I/Oサイズとボリュームのスループット制限
- ssdでI/Oサイズが非常に大きい場合スループットの制限に達するとIOPS値がプロビジョニングした値よりも小さくなることがある
- IOPSが3000のとき、ボリュームのスループットが160MiB/sとすると使用するI/Oサイズが256KiBの場合、640IOPSでスループット制限に達する。IOが小さければあ3000KiBを維持できる
- サイズの小さなI/Oではインスタンス内で測定したIOPSがプロビジョニングの値より高くなることがある。これはOSが小さなI/OをEBSに投げる前にマージ下場合に生じる
- HDDの場合、I/Oがシーケンシャルリードであれば、インスタンス内で測定したIOPSが予測値より高くなることがある。これはOSがシーケンシャルI/Oをマージして1,024KiBサイズ単位でカウントすることによって生じる
- ボリュームタイプに関係なく設定したはずのIOPSまたはスループットを得られない場合はEC2インスタンスの帯域幅が制限要因になっていないか確認する


#### CloudWatchでI/O特性を監視する
考慮するメトリクスは下記

- BurstBalance
- VolumeReadBytes
- VolumeWriteBytes
- VolumeReadOps
- VolumeWriteOps
- VolumeQueueLength
- Instance bandwidth

クレジットが枯渇していることが原因化はBurstBalanceで判断する

HDD系は1,024KiBの最大I/Oサイズを活用するワークロードに最適なため、ボリュームの平均I/Oを知ることが大切。VolumeWriteBytes / VolumeWriteOpsで計算できる。平均64KiBを下回る場合はボリュームに送るI/Oサイズを大きくするとパフォーマンスが向上する。平均I/Oが44KiB前後であれば間接記述子がサポートされていないインスタンスやカーネルを使用している可能性がある

I/Oレイテンシーが高い場合、VolumeQueueLengthをチェックして、アプリケーションがプロビジョニングしたIOPS以上の処理を実行しようとしていないことを確認する


### ebs designing for performance
#### Queuing theory

W = L / A

- W: wait time = average wait time per request
- L: Queue length = average number of requests waiting
- A: Arrival rate = the rate of requests arriving

参考 https://www.slideshare.net/AmazonWebServices/stg403-amazon-ebs-designing-for-performance

### ボリュームの初期化
新しいEBSボリュームはプリウォーミングは不要。ただしスナップショットから復元されたボリュームは初期化が必要。ddかfloを使う

```
$ sudo dd if=/dev/xvdf of=/dev/null bs=1M
```

### LinuxでのRAID構成
- RAID1（ストライピング）だと性能が上がる

### EBSボリュームのベンチマーク
- fio
- Oracle Orion Calibration
