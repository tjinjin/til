## EC2

## t2シリーズ
t2シリーズはCPUクレジットという考え方がある。クレジットを消化仕切ったときのパフォーマンスはベースラインパフォーマンスが決まっている

http://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/t2-instances.html


### CPUクレジットの消費
1個のCPUクレジットは1台のvCPUを使用率100%で1分間実行することに相当する。下記はすべて1クレジット分の消化

- 1台のvCPUを使用率50%で2分間実行
- 2台のvCPUを使用率25%で2分間実行

| instanceType  | 初期CPUクレジット  | 1時間あたりの増加 | 単一のvCPU | baseline  | max cregit |
|------------|------|----|---|---------------|-------|
| t2.nano    | 30   | 3  | 1 | 5%            | 72    |
| t2.micro   | 30   | 6  | 1 | 10%           | 144   |
| t2.small   | 30   | 12 | 1 | 20%           | 288   |
| t2.medium  | 60   | 24 | 2 | 40%(max200)   | 576   |
| t2.large   | 60   | 36 | 2 | 60%(max200)   | 864   |
| t2.xlarge  | 120  | 54 | 4 | 90%(max400)   | 1296  |
| t2.2xlarge | 240  | 81 | 8 | 135%(max800)  | 1944  |

t2.medium以上は複数のvCPUを持つ。ベースラインは単一vCPUあたりの割合なので、例えばt2.largeは2つのvCPUでベースライン60%なので、CPU使用率は30%になる


### クレジットの監視

- CPUCreditUsage: インスタンスによって消費されるCPUクレジットすう
- CPUCreditBalance: クレジット数

## パフォーマンス
- https://d0.awsstatic.com/events/jp/2017/summit/slide/D4T2-5.pdf
