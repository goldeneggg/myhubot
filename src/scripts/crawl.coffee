# Description:
#   Example script for web crawling
#
# Dependencies
#   "cheerio": "^0.17.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot tram <number> - Show Helsinki tram map url by route number
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   goldeneggg

cheerio = require 'cheerio'

module.exports = (robot) ->
  Log = require('../module/Log')(robot.logger)
  H = require('../module/Http')(robot.logger)

  # test google
  robot.respond /cr test (.+)/i, (msg) ->
    Log.showMatch msg

    q = msg.match[1]
    url = "https://www.google.co.jp/?ei=4KwSVLTEMIbN8gf_y4HoDw#q=" + q
    Log.debug "url = #{url}"

    callback = (body) ->
      $ = cheerio.load body
      title = $('title').text().replace(/n/g, '')
      msg.send "title: #{title}"
    H.get url, callback

  # route map of helsinki tram
  robot.respond /tram ([1-9]([0-9A-Z])?)/i, (msg) ->
    Log.showMatch msg

    num = msg.match[1]
    line =
      if /[1-9][A-Z]/g.test(num)
        "100" + num + "+"
      else
        "10" + ("0" + num).slice(-2) + "++"
    url = "http://linjakartta.reittiopas.fi/en/#?mapview=map&line=#{line}1,#{line}2"
    Log.debug "url = #{url}"
    msg.send "#{url}"
