Server-Monitoring-Bot
=====================

## 概要

サーバの死活監視を、"ICMP" の疎通確認、または "HTTPステータスコード 200" の確認を用いて行う。  
監視結果は、Twitter にツイートするか、slack の掲示板書込みを行う。


## 使い方

### 使用する環境変数

```
# 監視設定
CHECK_ADDRESS  ="http://example.com" # ICMP で監視する場合は、ホスト名 example.com を設定する
CHECK_INTERVAL ="3.hours"            # 未定義なら "3.hours" 設定
CHECK_TIMEOUT  ="5"                  # ICMP とHTTPリクエストのタイムアウト時間[s]。未定義なら "5" 秒の設定
# Twitter 設定
YOUR_CONSUMER_KEY    ="xxxx"         # 未定義なら、ツイートは行わない
YOUR_CONSUMER_SECRET ="xxxx"         # 未定義なら、ツイートは行わない
YOUR_ACCESS_TOKEN    ="xxxx"         # 未定義なら、ツイートは行わない
YOUR_ACCESS_SECRET   ="xxxx"         # 未定義なら、ツイートは行わない
TWEET_SUCCESS ="対象が稼働中の時の、Twitterへの書込み内容" # 未定義なら "稼働中" の設定になる
TWEET_FAIL    ="対象が停止中の時の、Twitterへの書込み内容" # 未定義なら "停止中" の設定になる
# slack 設定
WEBHOOK_URL   ="https://hooks.slack.com/services/xxxxxx"   # 未定義なら slack への書込みは行わない
SLACK_SUCCESS ="対象が稼働中の時の、slackへの書込み内容"   # 未定義なら "稼働中" の設定になる
SLACK_FAIL    ="対象が停止中の時の、slackへの書込み内容"   # 未定義なら "停止中" の設定になる
```


### heroku で使う

ローカル環境で、git コマンドと "Heroku Toolbelt" は既に導入していることが前提です。

* 死活監視は "HTTPステータスコード 200" を確認する
* 監視結果は Twitter にツイートする

```sh
git clone https://github.com/maijou2501/Server-Monitoring-Bot.git
cd Server-Monitoring-Bot.git
heroku login
heroku create
heroku config:set CHECK_ADDRESS="http://example.com"
heroku config:set YOUR_CONSUMER_KEY="xxxx"
heroku config:set YOUR_CONSUMER_SECRET="xxxx"
heroku config:set YOUR_ACCESS_TOKEN="xxxx"
heroku config:set YOUR_ACCESS_SECRET="xxxx"
git push heroku master
```

※ heroku には ping コマンドが無いため、"ICMP" の疎通確認は利用できません。


### 自前のサーバ環境で実行する

サーバに、git・rbenv コマンドを既に導入していることが前提です。

* 死活監視は "ICMP" 疎通確認を行う
* 監視結果は Twitter へのツイートと、slack への書込みを行う

```sh
git clone https://github.com/maijou2501/Server-Monitoring-Bot.git
cd Server-Monitoring-Bot.git
export CHECK_ADDRESS="example.com"
export YOUR_CONSUMER_KEY="xxxx"
export YOUR_CONSUMER_SECRET="xxxx"
export YOUR_ACCESS_TOKEN="xxxx"
export YOUR_ACCESS_SECRET="xxxx"
export WEBHOOK_URL="https://hooks.slack.com/services/xxxx"
# Ruby 環境
rbenv install 2.2.3
rbenv local 2.2.3
gem bundler
bundle install
bundle exec clockworkd -c clock.rb start --log
```


## Twitter 利用時の注意

Twitter の書込みは、Twitter の仕様で前ツイートと同内容の書込みが約12時間ほどできないようでした。  
何が問題かというと、__死活監視が行えているか確認できる粒度が約12時間ほどである__という点です。

ツイート内容に変更を加えるために日付を記載する実装も考えたのですが、一日に2回は監視botが動いていることが分かることを良しとし、前述の実装は見送りました。


## プログラムに対するドキュメント

yard で出力したドキュメントをアップロードしています。

[ Server-Monitoring-Bot ]( http://maijou2501.github.io/Server-Monitoring-Bot/frames.html#!file.README.html )


## 免責

作者は、本ソフトウェアの使用または使用不能から生じるコンピュータの故障、情報の  
消失、その他あらゆる直接的及び間接的被害に関して一切の責任を負いません。

これに同意できない場合、本ソフトウェアの使用を禁止します。


## 更新履歴

* version 1.0 (2016/01/23 ) 公開


## 謝辞

"ruedap" さん、"motoso" さんの記事に影響を受けて作成を思い立ち、プログラムも一部流用させていただきました。  
この場を借りて、感謝を申し上げます。
