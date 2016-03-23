## SNMPとは
Simple Network Management Protocolの略。よくネットワーク機器などの監視で使われる。SNMPに対応している機器ではMIBというデータ・モデルを持っていて、取得側でそのMIBを指定して機器の情報を取得する仕組み。ヤマハのルータとかでは、マニュアルを見るとMIBの設定が確認できる。

## ユースケース
* サーバの監視に使ったり
* ルータの監視に使ったり

## SNMPを構成する要素
### バージョン
SNMPに現在主に3つのバージョンがある。v1/v2c/v3

### MIB
Managemet information baseの略。機器の情報を一意に表したもの。RFC1155/RFC1213/RFC1157辺りが関連する。SNMPマネージャ側で取得したい情報をOIDを指定することで情報を取得できる

### OID
Object Identifierの略。一つ一つのオブジェクトを区別するために振られた識別子で、オブジェクト識別子ともよばれる

### コミュニティ名
マネージャとエージェント間でやりとりするパスワードのような情報

### SNMPトラップ
SNMPではSNMPマネージャからエージェントに対して問い合わせを行うモデルだが、SNMPトラップを使うとエージェントからマネージャに通知を送ることができる

## コマンド
SNMPにはたくさんのコマンドがある。

### snmpwalk
指定したOIDに一致するものを前方一致で一覧を取得する


### snmpget
指定したOIDの情報を取得する

```
$ snmpget -v 1 -c public localhost 1.3.6.1.4.1.1182.2.1.6.0 # yamaha cpu 1minute
```

### snmptranslate
SNMPには標準のMIBがあるがベンダ毎に拡張したある場合どのOIDを指定すればよいかわからないそんなときに使う

```
$ snmptranslate .1.3.6.1.2.1.2.2.1.1 # OID->名前
$ snmptranslate -On IF-MIB::ifIndex
```

MIBの一覧も登録されているデータ(`/usr/share/snmp/mibs/`)などから表示できる

```
$ snmptranslate -Tp # ツリー表示
+--iso(1)
   |
   +--org(3)
      |
      +--dod(6)
$ snmptranslate -Tl # ドット区切りでとラベルとOIDを順に表示
.iso(1).org(3).dod(6).internet(1).snmpV2(6).snmpModules(3).snmpv2tm(19)
$ snmptranslate -To # OIDだけを表示
.1.3.6.1.6.3.19
$ snmptranslate -Ts # TlのOIDがないバージョン
.iso.org.dod.internet.snmpV2.snmpModules.snmpv2tm
$ snmptranslate -Tz # 名称とOIDを表示（これがよさそう）
```


### snmptrap

### snmptest

## Links
* [使用頻度の高そうなsnmpコマンドまとめ](https://gist.github.com/bahootyper/575190)
* [SNMPについて](http://ash.jp/net/snmp.htm)
