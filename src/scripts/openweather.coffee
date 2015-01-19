# Description:
#   Example script for openweathermap
#
# Dependencies:
#
# Configuration:
#   None
#
# Commands:
#   hubot ow <city> - Confirm weather by openweathermap
#
# Author:
#   goldeneggg

convSelsius = 2731  # 273.15

module.exports = (robot) ->
  Log = require('../module/Log')(robot.logger)
  H = require('../module/Http')(robot.logger)

  roundOne = (temp) ->
    return (Math.round(temp * 10) - convSelsius) / 10

  # openweathermap
  robot.respond /ow (.+)/i, (msg) ->
    Log.showMatch msg

    city = msg.match[1]
    url = "http://api.openweathermap.org/data/2.5/weather?q=#{city}"
    Log.debug "url = #{url}"

    callback = (json) ->
      if json.cod != 200
        msg.send "not found city #{city}"
        return

      celsius = roundOne(json.main.temp)
      celsiusMin = roundOne(json.main.temp_min)
      celsiusMax = roundOne(json.main.temp_max)
      mn = ""
      for w in json.weather
        mn = mn + " => " + w.description
      msg.send "current weather of #{json.name},#{json.sys.country} #{mn}: #{celsius}℃  (max #{celsiusMax} / min #{celsiusMin}) http://openweathermap.org/city/#{json.id}"
    H.get url, callback, true
