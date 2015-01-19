# Description:
#   Example script for topsy
#
# Dependencies:
#   "cheerio": "^0.17.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot lin s [query] - Show sample sentences from linguee
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   goldeneggg

cheerio = require 'cheerio'

lingueeBaseUrl = "http://www.linguee.com/english-japanese/search?source=auto&query="

module.exports = (robot) ->
  Log = require('../module/Log')(robot.logger)
  H = require('../module/Http')(robot.logger)
  Str = require('../module/Str')

  # topsy trend
  robot.respond /lin s (.+)/i, (msg) ->
    Log.showMatch msg

    q = msg.match[1]

    url = lingueeBaseUrl + q
    Log.debug "url = #{url}"

    callback = (body) ->
      $ = cheerio.load body
      m = ""
      en = ""
      ja = ""
      #$('#result_table > tbody.examples > tr > td.left,td.right2 div.wrap').each (i, e) ->
      $('#result_table > tbody.examples > tr > td > div.wrap').each (i, e) ->
        if i < 10
          if i % 2 == 0
            en = Str.trimBlanks($(e).text())
              .replace(/\[\.\.\.\]/g, "")
              .replace(new RegExp(q, "g"), "*#{q}*")
          else
            ja = Str.trimAll($(e).text())
            nm = "#{en} => #{ja}"
            Log.debug "linguee msg. i: #{i}, nm: #{nm}"
            m = m + "\n" + nm

      Log.debug "linguee m: #{m}"
      msg.send m

    H.get url, callback
