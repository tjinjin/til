## elasticsearch
分散型RESTful検索/分析エンジン。日本語の全文検索もできる。

## Monitoring 2.X系
### Cluster Health

```
GET _cluster/health
```

- status
  - green: すべてのprimaryとreplica shardsが割り当てられている
  - yellow: すべてのprimary shardsは割当られているが、少なくもと一つのreplicaが割当たっていない。現状は問題ないが、シャードが失われるとデータが消失する状態となる
  - red: 少なくとも１つのprimary shardがなくなっている
- number_of_nodes / number_of_data_nods
- active_primary_shards: cluster内のprimary shard数を示す
- active_shards: replicaも含めたshardの数
- relocating_shards: シャードの入れ替えが起きたときに数が増える普段は一つ
- initializing_shards: 新しく作成されたシャードの数
- unassigned_shards: 割り当てられていないシャード。

#### 詳細な調査
clusterのステータスがredのときに詳細を調査するための方法

```
GET _cluster/health?level=indices
```

各インデックス毎の状態を確認することができる

level=shardsとするとシャードの状態を確認できる。冗長なのであんまり見ないかも

#### ステータスの変更するまでブロックする

wait_for_status を指定するとステータスが指定したものになるまでレスポンスが返らない。ただしタイムアウトはあり

```
GET _cluster/health?wait_for_status=green
```

### Monitoring Individual Nodes

```
GET _nodes/stats
```

```
"store": {
  "size_in_bytes": 24272400,
  "throttle_time_in_millis": 0
}
```

throttle_time_in_millisが長い場合、ディスクスロットルが小さすぎることを示していると思われる

### Cluster Stats

```
GET _cluster/stats
```

### Index Stats

ノードをチェックして細かいことがきになったときに利用する

```
GET my_index/_stats

GET my_index,another_index/_stats

GET _all/_stats
```

### Pending Tasks
masterでのみ実行されるタスクがあるが、新しいインデックスの作成やshardの移動など、その際にmasterのmetadataの処理より早くクラスタが処理してしまうケースがある。その際にpendingされているタスクのこと。クラスタレベルのメタデータの変更がキュー内で保留中のもの

```
GET _cluster/pending_tasks
```

masterがクラスタのボトルネックになることはめったにない

仮にボトルネックになった場合は3つの解決策がある

- masterのスケールアップ
- documentの動的な性質を制限し、クラスターのサイズを制限する
- 特定の閾値を超えた後に別のクラスタをスピンアップする

### cat API

JSONではなく表形式で出力できる

``
GET /_cat
```

上記コマンドを打つと打てるコマンドの一覧を取得できる

```
GET /_cat/health
GET /_cat/health?v
GET /_cat/nodes?help
GET /_cat/nodes?v&h=ip,port,heapPercent,heapMax
```

## 用語
### field data
分析されたフィールドデータはキャッシュになる。フィールドデータへのアクセスはインデックス内のすべてのドキュメントが読み込まれる仕組み。defaultは無制限となっている。limitを設定するのは推奨ではない？フィールドデータをひたすらため続ける

無制限だと新しいデータへのアクセスができなくなってしまうっぽい？

indices.fielddata.cache.size設定をすると古いデータが削除されるようになる

```
GET /_stats/fielddata?fields=*
```

```
GET /_nodes/stats/indices/fielddata?fields=*
```

```
GET /_nodes/stats/indices/fielddata?level=indices&fields=*
```

### Circuit Breaker
クエリを実行する前に必要なメモリを計算し、OOMになりそうな場合はクエリを投げない仕組み

- indices.breaker.fielddata.limit
  - defaultでは60%
- indices.breaker.request.limit
  - defaultは40%
- indices.breaker.total.limit
  - requestとfielddataをラップしたもの。２つの組み合わせが70%を超えないかがdefault

indices.fielddata.cache.sizeとindices.breaker.fielddata.limitは深い関係がある。サーキットブレーカの制限がキャッシュサイズよりも小さい場合、データが削除されない。正しく動作させるために、サーキットブレーカの制限値をキャッシュサイズよりも大きくする必要がある

## 参考
- [第１回 Elastisearch 入門 インデックスを設計する際に知っておくべき事 ｜ Developers\.IO](http://dev.classmethod.jp/server-side/elasticsearch-getting-started-01/)
- [Elasticsearch システム概要 – Hello\! Elasticsearch\. – Medium](https://medium.com/hello-elasticsearch/elasticsearch-afd52d72711)
## search api
### Mappingの確認

```
GET {index}/_mapping
```

### Query DSLを使って検索

- 全文検索に利用する
- 関連性のスコアに依存する結果を得たいときに利用
- 一致率をみる検索

```
curl -XGET 'localhost:9200/_search?pretty' -H 'Content-Type: application/json' -d'
{
    "query" : {
        "term" : { "user" : "kimchy" }
    }
}
'

#### match_all 検索

```
curl -XGET 'localhost:9200/_search?pretty' -H 'Content-Type: application/json' -d'
{
    "query": {
        "match_all": { "boost" : 1.2 }
    }
}
'
```

### Filters

- ドキュメントそのものを検索する感じ

#### Term Query

下の例の場合、userフィールドにKimchyが含まれるものを検索する

```
curl -XPOST 'localhost:9200/_search?pretty' -H 'Content-Type: application/json' -d'
{
  "query": {
    "term" : { "user" : "Kimchy" }
  }
}
'
```

### Term level queries
#### Terms Query

Term Queryの複数書ける番？

```

curl -XGET 'localhost:9200/_search?pretty' -H 'Content-Type: application/json' -d'
{
    "query": {
        "constant_score" : {
            "filter" : {
                "terms" : { "user" : ["kimchy", "elasticsearch"]}
            }
        }
    }
}
'
```

#### Range Query

データの範囲指定

- gte greater-than or equal to
- gt  greater-than
- lte less-than or equal to
- lt  less-than
- boost

```
curl -XGET 'localhost:9200/_search?pretty' -H 'Content-Type: application/json' -d'
{
    "query": {
        "range" : {
            "age" : {
                "gte" : 10,
                "lte" : 20,
                "boost" : 2.0
            }
        }
    }
}
'
```


#### Exists Query

下記だとuser というfieldがnullでなければ引っかかる

```
curl -XGET 'localhost:9200/_search?pretty' -H 'Content-Type: application/json' -d'
{
    "query": {
        "exists" : { "field" : "user" }
    }
}
'
```

以下は引っかかる

```
{ "user": "jane" }
{ "user": "" }
{ "user": "-" }
{ "user": ["jane"] }
{ "user": ["jane", null ] }
```

#### Prefix Query

指定したフィールドで指定したprefixで始まる文字が抽出される

```
curl -XGET 'localhost:9200/_search?pretty' -H 'Content-Type: application/json' -d'
{ "query": {
    "prefix" : { "user" : "ki" }
  }
}
'
```

#### Wildcard Query

#### Regexp Query

#### Fuzzy Query

#### Type Query

#### Ids query

### Compound queries

### Joining queries
SQLでいう結合。コストが高い。

#### Nested Query

nestされたmappingに対してpathを指定してそこから絞り込み検索ができる

```
curl -XPUT 'localhost:9200/my_index?pretty' -H 'Content-Type: application/json' -d'
{
    "mappings": {
        "type1" : {
            "properties" : {
                "obj1" : {
                    "type" : "nested"
                }
            }
        }
    }
}
'

curl -XGET 'localhost:9200/_search?pretty' -H 'Content-Type: application/json' -d'
{
    "query": {
        "nested" : {
            "path" : "obj1",
            "score_mode" : "avg",
            "query" : {
                "bool" : {
                    "must" : [
                    { "match" : {"obj1.name" : "blue"} },
                    { "range" : {"obj1.count" : {"gt" : 5}} }
                    ]
                }
            }
        }
    }
}
'
```
