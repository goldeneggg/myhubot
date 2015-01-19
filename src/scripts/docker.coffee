# Description:
#   Example script for docker remote api
#
# Dependencies:
#
# Configuration:
#   HUBOT_DOCKER_API_HOST
#   HUBOT_DOCKER_API_PORT
#
# Commands:
#   hubot dck c list - Show container list
#
# Notes:
#
# Author:
#   goldeneggg

module.exports = (robot) ->
  Log = require('../module/Log')(robot.logger)
  Docker = require('../module/Docker')(
    process.env.HUBOT_DOCKER_API_HOST
    process.env.HUBOT_DOCKER_API_PORT
  )

  # show container list
  robot.respond /dck c list/i, (msg) ->
    Log.showMatch msg

    handler = (containerInfo) ->
      Log.debug "find container", containerInfo
      msg.send "container Id: #{containerInfo.Id}, Image: #{containerInfo.Image}, Status: #{containerInfo.Status}"

    Docker.listC(handler)
