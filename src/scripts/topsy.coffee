# Description:
#   Example script for topsy
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot tps trend [offset] [lang] - Show topsy trend contents
#   hubot tps search [window] [offset] [lang] <query> - Show topsy search result contents. window="m"(monthly),"w"(weekly),"d"(dately *default*),"h"(hourly)
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   goldeneggg

domainOtter = "http://otter.topsy.com"

module.exports = (robot) ->
  Log = require('../module/Log')(robot.logger)
  H = require('../module/Http')(robot.logger)
  Str = require('../module/Str')

  # topsy trend
  robot.respond /tps trend(?:\s+)?(0|[1-9]\d*)?([a-z]+)?/i, (msg) ->
    Log.showMatch msg

    offset = if msg.match[1]? then msg.match[1] else 0
    locale = if msg.match[2]? then "&locale=#{msg.match[2]}" else ""
    common = require('./common')(robot)
    common.tpsTrend(offset, locale, msg)

  # topsy search for a day
  robot.respond /tps search(?:\s+)((a|m|w|d|h)\s+)?((0|[1-9]\d*)\s+)?(([a-z]+)\s+)?(.+)/i, (msg) ->
    Log.showMatch msg

    win = if msg.match[2]? then msg.match[2] else "d"
    offset = if msg.match[4]? then msg.match[4] else 0
    lang = if msg.match[6]? then "&allow_lang=#{msg.match[6]}" else ""
    q = msg.match[7]
    common = require('./common')(robot)
    common.tpsSearch(win, offset, lang, q, msg)
