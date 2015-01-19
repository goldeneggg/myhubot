# Description:
#   Example script for parse rss
#
# Dependencies:
#
# Configuration:
#   None
#
# Commands:
#   hubot rss keys - Show rss site keys
#   hubot rss r <site key> - Show recent feed by site key
#
# Notes:
#
# Author:
#   goldeneggg

module.exports = (robot) ->
  Log = require('../module/Log')(robot.logger)
  Rss = require('../module/Rss')

  # rss keys
  robot.respond /rss keys/i, (msg) ->
    Log.showMatch msg

    m = ""
    for k, u of Rss.rdfs
      m = m + "#{k} => #{u}\n"
    msg.send m

  # parse rss
  robot.respond /rss r (.+)/i, (msg) ->
    Log.showMatch msg

    common = require('./common')(robot)
    common.parseRss(msg.match[1], msg)
