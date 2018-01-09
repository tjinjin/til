## VPC

## blackbelt

## document

## ネットワークACL
NACLは１つ以上のサブネットのインバウンド、アウトバウンドトラフィックを制御するVPC用のセキュリティのオプションレイヤー

SGと違いサブネットレベルで動作する点が大きな違い

- VPCには変更可能なデフォルトのNACLが設定されている。デフォルトでは全て許可？
- カスタムACLはルールを追加するまですべて拒否
- 利用する場合はサブネットとの関連付けが必須
- １つのACLに複数のサブネットをつけることはできる。１つのサブネットには１つのACLのみ
- ルールは低い番号から評価される。ルールがトラフィックに一致した時点で適用される