# Description:
#   Example script for bitcoin information
#
# Dependencies:
#
# Configuration:
#   None
#
# Commands:
#   hubot bc ti <currency> - Show bitcoin ticker information by <currency>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   goldeneggg

module.exports = (robot) ->
  Log = require('../module/Log')(robot.logger)
  H = require('../module/Http')(robot.logger)

  # bitcoin tick
  robot.respond /bc ti(?:ck)? (.*)/i, (msg) ->
    Log.showMatch msg

    currency = msg.match[1]

    common = require('./common')(robot)
    common.bcTick(currency, msg)
