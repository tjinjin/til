## Amazon SES(Simple Email Service)
メールの送受信が可能なサービス。

## 主にできること
* Eメールの送信
* Eメールの受信
* APIを使ったSESの操作

## メール送信
メール送信するには3つの方法がある

* Amazon SESコンソールから
* SMTPインターフェイスから
* Amazon SES APIから

セットアップ後はまずサンドボックス環境になる（制限がある）。制限を外すにはサポートセンターに申請が必要。

またバウンスメールの率が高くなると送信制限があるとのこと。

## SESの制限
- 送信クォータ（24時間あたりに送信できるEメールの最大数）
- 最大送信レート（1秒あたりのEメール最大数）

## Link
* [Amazon SESによるメール送信環境の構築と実践 ｜ Developers.IO] (http://dev.classmethod.jp/cloud/aws/amazon-ses-build-and-practice/)
* [Amazon Simple Email Service（クラウドベースのメールサービス） | AWS] (https://aws.amazon.com/jp/ses/)
* [Amazon SESとSNSを利用してバウンスメールを自動的にハンドリングする - $shibayu36->blog;] (http://blog.shibayu36.org/entry/2015/08/27/101815)
* [AWS Black Belt Tech シリーズ 2016 - Amazon SES] (http://www.slideshare.net/AmazonWebServicesJapan/aws-black-belt-tech-2016-amazon-ses)
