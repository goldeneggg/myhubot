# mybot

## Setup dependencies

### Node.js

```bash
$ wget http://nodejs.org/dist/v0.12.2/node-v0.12.2-linux-x64.tar.gz

# (for mac)
$ wget http://nodejs.org/dist/v0.12.2/node-v0.12.2-darwin-x64.tar.gz

$ tar zxf node-v0.12.2-linux-x64.tar.gz
$ cd node-v0.12.2-linux-x64
$ sudo cp -R bin include lib share /usr/local/
```

### Coffeescript

```bash
$ sudo npm install -g coffee-script
```

### This bot

```bash
$ git clone https://github.com/goldeneggg/myhubot.git
$ cd myhubot
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
