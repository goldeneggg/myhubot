# mybot

## Setup dependencies

### Node.js

```bash
$ wget http://nodejs.org/dist/v0.12.0/node-v0.12.0-linux-x64.tar.gz
$ tar zxf node-v0.12.0-linux-x64.tar.gz
$ cd tar zxf node-v0.12.0-linux-x64
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
