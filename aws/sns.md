## SNS

## 黒帯
Amazon SNSはマルチプロトコルに対応したフルマネージド通知サービス

## 連携
- Amazon Cloudwatch
- SES
- S3
- Amazon Elastic Transcoder

## SQSとSNSの組み合わせ
- 画像をフォームからアップロードして登録するもの
  - 画像ファイルはS3
  - 画像コメントはRDS
  - 画像のメタデータはDynamoDB
  - WebアプリがSNSトピックを作成
  - SNSからそれぞれのSQSキューに通知
  - SQSをworkerがさばく
