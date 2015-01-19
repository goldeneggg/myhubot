# Description:
#   Example script for github
#
# Dependencies:
#   "cheerio": "^0.17.0"
#
# Configuration:
#   HUBOT_GITHUB_TOKEN
#
# Commands:
#   hubot gh events <github user> - Show recent event on github.
#   hubot gh gists <github user> - Show gist on github.
#   hubot gh pulls <github user> <github repo name> - Show pull request on github
#   hubot gh hooks <github user> <github repo name> - Show hook request on github
#   hubot gh trrepo [since ("m", "w", "d")] [language] - Show github explore trending repository, since = "m": monthly, "w": weekly, "d": daily(default)
#   hubot gh trdev [since ("m", "w", "d")] - Show github explore trending developer, since = "m": monthly, "w": weekly, "d": daily(default)
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   goldeneggg

cheerio = require 'cheerio'

githubToken = process.env.HUBOT_GITHUB_TOKEN
githubApiDomain = "api.github.com"

module.exports = (robot) ->
  Log = require('../module/Log')(robot.logger)
  H = require('../module/Http')(robot.logger)
  Str = require('../module/Str')

  # env check
  checkEnv = ->
    ret = true
    unless githubToken
      ret = false
    return ret


  robot.respond /gh events (.+)/i, (msg) ->
    Log.showMatch msg

    unless checkEnv()
      msg.send "Please set the HUBOT_GITHUB_TOKEN env value."
      return

    user = msg.match[1]
    url = "https://#{githubApiDomain}/users/#{user}/events?access_token=#{githubToken}&page=1&per_page=5"
    Log.debug "url = #{url}"

    callback = (json) ->
      m = ""
      # json is array
      for j in json
        m = m + "\n" + "recently github event by #{user}, #{j.type}, #{j.repo.name}"
      msg.send m

    H.getGitHub url, callback


  robot.respond /gh gists (.+)/i, (msg) ->
    Log.showMatch msg

    unless checkEnv()
      msg.send "Please set the HUBOT_GITHUB_TOKEN env value."
      return

    user = msg.match[1]
    url = "https://#{githubApiDomain}/users/#{user}/gists?access_token=#{githubToken}&page=1&per_page=5"
    Log.debug "url = #{url}"

    callback = (json) ->
      m = ""
      # json is array
      for j in json
        m = m + "\n" + "recently github gists by #{user}, #{j.html_url}, #{j.description}"
      msg.send m

    H.getGitHub url, callback


  robot.respond /gh pulls (.+) (.+)/i, (msg) ->
    Log.showMatch msg

    unless checkEnv()
      msg.send "Please set the HUBOT_GITHUB_TOKEN env value."
      return

    owner = msg.match[1]
    repo = msg.match[2]
    url = "https://#{githubApiDomain}/repos/#{owner}/#{repo}/pulls?access_token=#{githubToken}"
    Log.debug "url = #{url}"

    callback = (json) ->
      m = ""
      # json is array
      for j in json
        m = m + "\n" + "pull requests by #{j.user.login}, '#{j.title}' ( #{j.html_url} ) is state [#{j.state}]"
      msg.send m

    H.getGitHub url, callback


  robot.respond /gh hooks (.+) (.+)/i, (msg) ->
    Log.showMatch msg

    unless checkEnv()
      msg.send "Please set the HUBOT_GITHUB_TOKEN env value."
      return

    owner = msg.match[1]
    repo = msg.match[2]
    url = "https://#{githubApiDomain}/repos/#{owner}/#{repo}/hooks?access_token=#{githubToken}"
    Log.debug "url = #{url}"

    callback = (json) ->
      m = ""
      # json is array
      for j in json
        m = m + "\n" + "webhooks for #{owner}/#{repo}, name:#{j.name}, events:#{j.events}, active:#{j.active}"
      msg.send m

    H.getGitHub url, callback


  # github trend repo
  robot.respond /gh trrepo(?:\s+)?((m|w|d)\s+)?([^\s]+)?/i, (msg) ->
    Log.showMatch msg

    since = "daily"
    if msg.match[2]?
      switch msg.match[2]
        when "m"
          since = "monthly"
        when "w"
          since = "weekly"

    l = if msg.match[3]? then "&l=#{msg.match[3]}" else ""

    common = require('./common')(robot)
    common.ghTrend(since, l, msg)

  # github trend developer
  robot.respond /gh trdev(?:\s+)?(m|w|d)?/i, (msg) ->
    Log.showMatch msg

    since = "daily"
    if msg.match[1]?
      switch msg.match[1]
        when "m"
          since = "monthly"
        when "w"
          since = "weekly"

    common = require('./common')(robot)
    common.ghDev(since, msg)
