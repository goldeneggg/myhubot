request = require 'request'

# HTTP client class
class Http
  constructor: (logger) ->
    @log = require('./Log')(logger)

  # http
  req: (url, callback, method = "GET", form = {}, isJson = false, timeout = 8000, headers = {}) ->
    options =
      url: url
      method: method
      json: isJson
      timeout: timeout
    if Object.keys(form).length > 0
      options['form'] = form
    if Object.keys(headers).length > 0
      options['headers'] = headers

    # execute request
    # callback use '=>' instead of '->' because want to close "@" object
    request options, (error, response, body) =>
      if error
        @log.error "Request occured some problems, #{error}"
        return

      status = response.statusCode
      if status == 200
        callback(body)
        @log.debug "Status is success(200)"
      else
        @log.error "Status(#{status}) is error, #{body}"

  get: (url, callback, isJson = false, timeout = 8000, headers = {}) ->
    @req(url, callback, "GET", {}, isJson, timeout, headers)

  post: (url, callback, form, isJson = false, timeout = 8000, headers = {}) ->
    @req(url, callback, "POST", form, isJson, timeout, headers)

  getGitHub: (url, callback, timeout = 8000) ->
    @get(url, callback, true, timeout, {"User-Agent": "hubot"})

  # bitcoin
  # callback = (json) -> ...function contents...
  bcTick: (currency, callback) ->
    url = "https://api.bitcoinaverage.com/ticker/global/#{currency}/"
    @get(url, callback, true)

module.exports = (logger) -> new Http(logger)
