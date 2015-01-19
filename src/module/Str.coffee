moment = require 'moment'

# String utility class
class Str
  constructor: ->

  # date
  formatDate: (inDate, f = 'YYYY-MM-DD HH:mm:ss') ->
    moment(inDate).format(f)

  formatUnixTs: (inUnixTs, f = 'YYYY-MM-DD HH:mm:ss') ->
    moment.unix(inUnixTs).format(f)

  # trim
  trim: (str) ->
    str.replace(/(^\s+)|(\s+$)/g, '')

  trimIn: (str) ->
    str.replace(/\s+/g, '')

  trimCrLf: (str) ->
    str.replace(/\r?\n/g, '')

  trimBlanks: (str) ->
    @trim(@trimCrLf(str))

  trimAll: (str) ->
    @trimIn(@trim(@trimCrLf(str)))

module.exports = new Str
