# Description:
#   My Events
#
# Events:
#   console - [<output msg>, [inspection object], [tag]] - console logging
#   c_err - [<output msg>, [inspection object]] - console error logging
#   c_match - <msg> - console logging for regexp capture matches
#
# Examples:
#   robot.emit "console", [<output message>] *loglevel is "DEBUG"
#   robot.emit "console", [<output message>, <msg.message object>] *loglevel is "DEBUG"
#   robot.emit "console", [<output message>, <msg.message.user object>] *loglevel is "DEBUG"
#   robot.emit "c_err", [<output message>] *loglevel is "ERROR"
#   robot.emit "c_err", [<output message>, <msg.message object>] *loglevel is "ERROR"
#   robot.emit "c_match", <msg object> *loglevel is "DEBUG"

util = require 'util'

module.exports = (robot) ->

  parse = (msgEvent) ->
    [msgEvent[0], if msgEvent[1]? then util.inspect(msgEvent[1], true, null) else ""]

  robot.on 'console', (event) ->
    [output, inspection] = parse event
    robot.logger.debug "#{output} #{inspection}"

  # error logging
  robot.on 'c_err', (event) ->
    [output, inspection] = parse event
    robot.logger.error "#{output} #{inspection}"

  # debug for "msg.match" of regexp capture result
  robot.on 'c_match', (event) ->
    matched = ""
    for m, idx in event.match
      if idx > 0
        matched = matched + "[#{idx}]:\"#{m}\", "
    robot.logger.debug "#{event.message.text}\" capture to #{matched}"
