# Description:
#   Example script for stock information
#
# Dependencies:
#   "cheerio": "^0.17.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot stock <stock code> - Show current stock info
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   goldeneggg

cheerio = require 'cheerio'

module.exports = (robot) ->
  Log = require('../module/Log')(robot.logger)

  # stock (using yahoo.jp)
  robot.respond /stock ([1-9]\d*)/i, (msg) ->
    Log.showMatch msg

    common = require('./common')(robot)
    common.stock(msg.match[1], msg)
