# Description:
#   Example script for it ebook
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot iteb [page] <query> - Search it ebook
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   goldeneggg

domainItEbook = "http://it-ebooks-api.info/v1"

module.exports = (robot) ->
  Log = require('../module/Log')(robot.logger)
  H = require('../module/Http')(robot.logger)

  # it-ebooks
  robot.respond /iteb(?:\s+)?(([1-9]\d*)\s+)?(.+)/i, (msg) ->
    Log.showMatch msg

    page = if msg.match[2]? then msg.match[2] else 1
    q = msg.match[3]
    url = domainItEbook + "/search/#{q}/page/#{page}"
    Log.debug "url = #{url}"

    callback = (json) ->
      m = "===== Page:#{json.Page}, Total:#{json.Total} =====\n"
      if json.Total > 0
        for b in json.Books
          #ids.push b.ID
          dUrl = domainItEbook + "/book/#{b.ID}"
          m += "#{b.Title} ( #{dUrl} ) <#{b.isbn}> #{b.Image}\n"
      msg.send m
    H.get url, callback, true
