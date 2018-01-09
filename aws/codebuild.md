## codebuild

## メモ
- codebuild 0.1ではprivate repositoryに対応しておらず、今の0.2では今のところ対応状況が不明。必要に応じてjenkinsのpluginを入れる対応が必要そう
  - https://forums.aws.amazon.com/thread.jspa?threadID=244649
  - 見たところgithubの認証はできるっぽいので解決？
- githubのwebhookを直接受け取れないので、github -> api gateway -> lambda -> codebuildの流れを作らないとcircleciと同等のことはできないかもしれない
  - https://github.com/svdgraaf/github-codebuild-webhook
  - 認証の対応ができているかを確認
- 環境変数にシークレットな情報を入れるのはNGっぽい。KMS使えばいいのかな？
