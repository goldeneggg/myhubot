# mybot

## Setup dependencies

### Node.js

```bash
$ wget http://nodejs.org/dist/v0.10.31/node-v0.10.31-linux-x64.tar.gz
$ tar zxf node-v0.10.31-linux-x64.tar.gz
$ cd tar zxf node-v0.10.31-linux-x64
$ sudo cp -r bin include lib share /usr/local/
```

### Coffeescript

```bash
$ sudo npm install -g coffee-script
```

### This bot

```bash
$ git clone https://github.com/goldeneggg/mybot.git
$ cd mybot
$ npm install
```


## Usage

### Set required env values

```bash
$ export HUBOT_CHANNELS=<YOUR_CHANNELS>
$ export HUBOT_NICKNAME=<YOUR_BOT_NICKNAME>
$ export HUBOT_GITHUB_TOKEN=<YOUR_GITHUB_ACCESS_TOKEN>
$ export HUBOT_DOCKER_API_HOST=<YOUR_DOCKER_API_HOST>
$ export HUBOT_DOCKER_API_PORT=<YOUR_DOCKER_API_PORT>
$ export HUBOT_LOG_LEVEL=debug
```

### Run IRC Adapter

```bash
$ export HUBOT_IRC_SERVER=<YOUR_IRC_SERVER>

$ nohup ./run.sh irc &
```

### Run Slack Adapter

```bash
$ export HUBOT_SLACK_TOKEN=<YOUR_SLACK_TOKEN>
$ export HUBOT_SLACK_TEAM=<YOUR_SLACK_TEAM>

$ nohup ./run.sh slack &
```

## TODO
* add __help reference bot__
* use redis storage


## Hubot reference memo

### hubot-scripts.json, external-scripts.json

> 本家が公開しているhubot-scriptsは通常、npm install後にhubot-scripts.jsonに使用するスクリプト名を指定して読み込みを行います
> 外部モジュールの場合はどうするかというと、external-scripts.jsonという仕組みが用意されていて、そこにモジュール名を記述することでスクリプトが利用できるようになっています

* __スクリプト名__ を記述して設定するのが `hubot-scripts.json"
* __パッケージ名/モジュール名__ を記述して設定するのが `external-scripts.json"

### functions
* `robot.name` - botの名前を取得
* `robot.respond <正規表現>, (msg) -> <処理>` - hubotに問いかけた内容が指定した正規表現にマッチする場合に後続の処理を実行する
* `robot.hear <正規表現>, (msg) -> <処理>` - チャネル内の発言に反応して処理を実行する
    * `msg.send <MSG>` - メッセージを送信する
    * `msg.reply <MSG>` - メッセージを返信する
    * `msg.emote <MSG>` - 感情を送信する
    * `msg.topic <MSG>` - トピックを送信する
    * `msg.random <ITEMS>` - ITEMSからランダムに抽出した値を送信する
    * `msg.http(<URL>)` - URLにHTTPアクセスする
        * `.get() (err, res, body) ->` - GETアクセス
        * `.post() (err, res, body) ->` - POSTアクセス
* `robot.enter <MSG>` - botが入室した際にメッセージを送信する
* `robot.leave <MSG>` - botが退室した際にメッセージを送信する
* `robot.messageRoom <ROOM>, <MSG>` - ROOMにメッセージを送信する
* `robot.router.{get,post} "<PATH>", (req, res) ->` - REST API, __デフォルトでは環境変数`PORT`(=8080)のポートで起動される__, インストール直後にいくつかのサンプルが用意されている
    * `robot.router.get "/hubot/version", (req, res) ->` - hubotのバージョンを確認, `http://<HOST>:<PORT>/hubot/version`でアクセス
    * `robot.router.get "/hubot/time", (req, res) ->` - hubot稼働サーバーの時刻を確認, `http://<HOST>:<PORT>/hubot/time`でアクセス
    * `robot.router.get "/hubot/info", (req, res) ->` - 稼働しているhubotの情報を確認, `http://<HOST>:<PORT>/hubot/info`でアクセス
    * `robot.router.get "/hubot/ip", (req, res) ->` - hubotのバージョンを確認, `http://<HOST>:<PORT>/hubot/ip`でアクセス
        * `http://ifconfig.me/ip`にアクセスして調べるので外への通信が可能な環境でないと動かない
    * `robot.router.post "/hubot/ping", (req, res) ->` - hubotにpingを送る, `http://<HOST>:<PORT>/hubot/ping`にPOSTでアクセス
* `robot.brain.data.<データ>` - データを登録する
* `robot.brain.save` - データを永続化(保存)する
* `robot.logger.{debug,info,warning} "<MSG>"` - ログを出力する
* `console.log` - consoleログを出力する

### regexp for capture
`()`を指定した場合のキャプチャについて

* `(.*)` - 任意の文字列にマッチ・キャプチャする
* `(hoge)` - "hoge"にマッチしたらキャプチャする
* `(hoge)?` - 括弧の後に`?`がある場合、"hoge"はあってもなくてもよくて、マッチしたらキャプチャする
* `(?:hoge)` - `?:`がある括弧は、"hoge"にマッチしてもキャプチャしない
* `\s+` - 1つ以上の空白
* `(?:\s+)([^\s]+)(?:\s+)([^\s]+)` - 任意の数のスペースで区切られた2つのパラメータ(必須)をキャプチャする
    * `hoge arg1 arg2` (arg1, 2共に必須)
* `(?:\s+)([^\s]+)(?:\s+)?([^\s]+)?` - 任意の数のスペースで区切られた2つのパラメータ(第1パラメータのみ必須)をキャプチャする
    * `hoge arg1 arg2` (arg1は必須)
* `(?:\s+)?([^\s]+)?(?:\s+)?([^\s]+)?` - 任意の数のスペースで区切られた2つのパラメータ(任意)をキャプチャする
    * `hoge arg1 arg2` (arg1, 2共に任意)
* `(?:\s+)(([^\s]+)\s+)?(.+)` - 任意の数のスペースで区切られた2つのパラメータ(第2パラメータのみ必須)をキャプチャする
    * `hoge arg1 arg2` (arg2は必須)
* ` ((.+) )?(.+)` - スペース1つで区切られた2つのパラメータ(第2パラメータのみ必須)をキャプチャする
    * `hoge arg1 arg2` (arg2は必須)
* (スペースを含むパラメータをキャプチャしたい場合どうすればよいか？)
* `([1-9]\d*)` - 1以上の数値をキャプチャする

## Bookmarks

### node.js
* [Node.js : exports と module.exports の違い（解説編） - ぼちぼち日記](http://d.hatena.ne.jp/jovi0608/20111226/1324879536)
    * ___require()の戻り値をコンストラクター関数や配列・文字列など別のものにしたいなら module.exports にしろ___
* [Node.jsのmoduleの書き方の基本: 別のファイルのオブジェクトや関数をrequireして使う方法 - memo.yomukaku.net](http://memo.yomukaku.net/entries/jbjiYnP)
    * hoge.js - 機能を公開する側。オブジェクトを定義して、`module.exports = <定義オブジェクト>`して公開する
        * あるいは`Class`を定義して、`module.exports = <Class名>`して公開する
        * `require`の際に引数を取りたい場合は、`module.exports = (arg1, arg2) -> <引数を使ったオブジェクトやクラスの初期化処理>`といった具合に関数として公開する
    * huga.js - hoge.jsの機能を使う側。`hogeobj = require('hoge')`でrequireして、`hogeobj.関数``hogeobj.プロパティ`して使う
        * `require`の際に引数を取る形で公開されている場合は、`require('hoge')(arg1, arg2)`といった具合にカリー化関数の形式でrequireを呼ぶ
* 関数の呼び出しで引数を改行したい場合

```coffee
hogeFunc paramA, paramB, paramC

// ↑ は ↓ こうする
hogeFunc(
  paramA
  paramB
  paramC
)
```

## Memo
* スクリプトの構成をどのように設計するか？
    * `robot.respond`や`robot.http`のような、入力待ち受け処理 __のみ__ を定義したスクリプト
    * 共通モジュール群・`robot`や`msg`に依存した、 __hubot専用共通処理__ を定義したスクリプト
    * 共通モジュール群・`robot`や`msg`に依存しない、 __hubot以外のプロジェクトでも流用できそうな共通処理__ を定義したスクリプト
