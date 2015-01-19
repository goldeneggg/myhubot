# Description:
#   Example script for eng
#
# Dependencies:
#
# Configuration:
#   None
#
# Commands:
#   hubot en keys - Show english word list
#   hubot en t <en content> - Show translation and example
#   hubot en ser - Show serieses from japanese to other language
#   hubot en jtoe <series> - Show english of target japanese series
#
# Notes:
#
# Author:
#   goldeneggg

module.exports = (robot) ->
  Log = require('../module/Log')(robot.logger)
  E = require('../module/E')

  # eng keys
  robot.respond /en keys/i, (msg) ->
    Log.showMatch msg

    m = ""
    for k, v of E.engs
      m = m + "#{k} => #{v.j}\n"
    msg.send m

  # eng
  robot.respond /en t (.+)/i, (msg) ->
    Log.showMatch msg

    eng = msg.match[1]
    r = E.get(eng)
    Log.debug "#{eng} info", r
    if r
      exam = ""
      for e in r.ex
        exam = exam + "\n    (#{e})"
      msg.send "#{eng}  -  #{r.j}#{exam}"

  robot.respond /en ser/i, (msg) ->
    Log.showMatch msg

    msg.send "Serieses list....."
    m = ""
    for series, cts of E.ss
      m = m + "  #{series}\n"
    msg.send m

  robot.respond /en jtoe (.+)/i, (msg) ->
    Log.showMatch msg

    series = msg.match[1]
    m = ""
    for cts in E.ss[series]
      for jpn, outs of cts
        m = m + "#{jpn} => #{outs["EN"]}\n"
    msg.send m
