## ELB

### 暖機運転
基本的に負荷に合わせてスケールする機能があるが、ELBのスケールにある程度の時間がかかり、リクエストが瞬間的に増えると503を返してしまう。そう言った際に事前にスケールアップ申請が可能。ただし、Bussiness/Enterpriseサポートプランに加入していることが条件

### Auto Scalingとの連携
一定期間レスポンスをチェックし、遅延が増加したらインスタンスを自動追加

### Route53 DNSフェイルオーバ対応
例えばELB配下に正常なEC2インスタンスがなくなると、S3内のSorryページ見せるとか

### link
- http://www.slideshare.net/AmazonWebServicesJapan/aws-black-belt-online-seminar-elastic-load-balancing
