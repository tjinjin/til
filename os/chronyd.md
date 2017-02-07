## chronyd

## command

## 設定ファイル

### defaultの設定ファイル（client側

```
# Use public servers from the pool.ntp.org project.
# Please consider joining the pool (http://www.pool.ntp.org/join.html).
server 0.centos.pool.ntp.org iburst
server 1.centos.pool.ntp.org iburst
server 2.centos.pool.ntp.org iburst
server 3.centos.pool.ntp.org iburst

# Ignore stratum in source selection.
stratumweight 0

# Record the rate at which the system clock gains/losses time.
driftfile /var/lib/chrony/drift

# Enable kernel RTC synchronization.
rtcsync

# In first three updates step the system clock instead of slew
# if the adjustment is larger than 10 seconds.
makestep 10 3

# Allow NTP client access from local network.
#allow 192.168/16

# Listen for commands only on localhost.
bindcmdaddress 127.0.0.1
bindcmdaddress ::1

# Serve time even if not synchronized to any NTP server.
#local stratum 10

keyfile /etc/chrony.keys

# Specify the key used as password for chronyc.
commandkey 1

# Generate command key if missing.
generatecommandkey

# Disable logging of client accesses.
noclientlog

# Send a message to syslog if a clock adjustment is larger than 0.5 seconds.
logchange 0.5

logdir /var/log/chrony
#log measurements statistics tracking

```

### 各設定の意味
- server
  - 同期に利用するserver。複数記述が可能
  - iburstと書くと初回起動時に短い間隔でパケットを投げる
- stratumweight
  - よくわからん
- driftfile
  - rate情報を一次記録する場所
- rtcsync
  - ハードウェアのシステムクロック(RTC)と同期する設定?
- makestep
  - defaultではslewだが、?
- bindcmdaddress
  - comandを発行できるIPアドレスを指定
- keyfile
  - keyfileの場所を指定
- commandkey
  - chronycコマンドを利用するときのkeyを指定。数字は`/etc/chrony.keys`の番号に対応する
- generatecommandkey
  - commandkeyがなければgenerateする
- noclientlog
  - clientのログを出さない
- logchange 0.5
  - 0.5秒以上ずれるようになったらsyslogに通知する
- logdir /var/log/chrony

## 資料
- https://access.redhat.com/documentation/ja-JP/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/ch-Configuring_NTP_Using_the_chrony_Suite.html
- https://access.redhat.com/documentation/ja-JP/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/sect-Understanding_chrony_and-its_configuration.html
- https://chrony.tuxfamily.org/manual.html
