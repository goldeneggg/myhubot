util = require 'util'

# log class
class Log
  constructor: (@logger) ->

  insp: (inspectTarget) ->
    if inspectTarget? then util.inspect(inspectTarget, true, null) else ""

  debug: (output, inspectTarget = null) ->
    @logger.debug "#{output} #{@insp(inspectTarget)}"

  error: (output, inspectTarget = null) ->
    @logger.error "#{output} #{@insp(inspectTarget)}"

  showMatch: (msgObj) ->
    matched = ""
    for m, idx in msgObj.match
      if idx > 0
        matched = matched + "[#{idx}]:\"#{m}\", "
    @logger.debug "\"#{msgObj.message.text}\" capture to #{matched}"

module.exports = (logger) -> new Log(logger)
