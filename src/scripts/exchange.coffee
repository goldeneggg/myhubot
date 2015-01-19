# Description:
#   Example script for exchange information
#
# Dependencies:
#
# Configuration:
#   None
#
# Commands:
#   hubot rate <from currency> <to currency> - Show currency rate
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   goldeneggg

module.exports = (robot) ->
  Log = require('../module/Log')(robot.logger)
  H = require('../module/Http')(robot.logger)

  # currency rate
  robot.respond /rate (.*) (.*)/i, (msg) ->
    Log.showMatch msg

    from = msg.match[1]
    to = msg.match[2]

    common = require('./common')(robot)
    common.exchange(from, to, msg)
