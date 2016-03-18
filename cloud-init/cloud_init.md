## cloud-initについて
cloud-initとはクラウドサービスにおいて、サーバの初期設定を簡単にできる仕組み。pythonで出来ている。よく利用するCentOSのAMIにはデフォルトで入っている。

## どんなことができる
* localeの設定
* hostnameの設定
* SSHのsecret keyを作成
* ユーザのpublic keysを`~/.ssh/authorized_keys`に追加
* diskの初期化やマウントをしたり

## どうやって使う
ドキュメントを見るとuser-dataを使ってと書いてある。

### ディレクトリ構造

```
/var/lib/cloud/
    - data/
       - instance-id
       - previous-instance-id
       - datasource
       - previous-datasource
       - previous-hostname
    - handlers/
    - instance
    - instances/
        i-00000XYZ/
          - boot-finished
          - cloud-config.txt
          - datasource
          - handlers/
          - obj.pkl
          - scripts/
          - sem/
          - user-data.txt
          - user-data.txt.i
    - scripts/
       - per-boot/
       - per-instance/
       - per-once/
    - seed/
    - sem/
```

### 利用できるEC2のmetadata

```
GET http://169.254.169.254/2009-04-04/meta-data/
ami-id
ami-launch-index
ami-manifest-path
block-device-mapping/
hostname
instance-id
instance-type
local-hostname
local-ipv4
placement/
public-hostname
public-ipv4
public-keys/
reservation-id
security-groups
```

### モジュール
モジュールがいろいろ用意されている。基本的にそのモジュールを`cloud.cfg`で呼び出す感じ。

### 使い方
基本的にcloud.cfgはいじらず、AMI作成側に任せた方がいい気がしている。変更に追随できるように。
user_data使えるが、実行タイミングの指定ができない（初回のみ実行だったはず）なので、下記フォルダにスクリプトを入れるとよさそう

```
/var/lib/cloud/scripts/per-boot
/var/lib/cloud/scripts/per-instance
/var/lib/cloud/scripts/per-once
/var/lib/cloud/scripts/vendor
```

`user_data`は下記にある（たぶん）

```
/var/lib/cloud/instance -> /var/lib/cloud/instances/<instance_id>
/var/lib/cloud/instances/<instance_id>
```

## Link
* [Documentation — Cloud-Init 0.7.7 documentation] (https://cloudinit.readthedocs.org/en/latest/index.html)
* [cloud-init in Launchpad] (https://launchpad.net/cloud-init)
* [nofficial mirror of Ubuntu's cloud-init dev trunk lp:cloud-init https://launchpad.net/cloud-init] (https://github.com/number5/cloud-init)
