# Description:
#   Example script for cron
#
# Dependencies
#   "cron": "^1.0.4"
#
# Configuration:
#   HUBOT_CRON_CHANNEL
#
# Commands:
#   None
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   goldeneggg

CronJob = require('cron').CronJob

module.exports = (robot) ->
  Log = require('../module/Log')(robot.logger)
  common = require('./common')(robot)

  room = process.env.HUBOT_CRON_CHANNEL

  jobs = {
#    jobMorningHatHot: new CronJob
#      cronTime: "00 45 09 * * 1-5"
#      timeZone: "Asia/Tokyo"
#      onTick: ->
#        common.parseRss('htnhi', null, room, true)
#
#    jobTpsTrend: new CronJob
#      cronTime: "00 50 10-23/2 * * *"
#      timeZone: "Asia/Tokyo"
#      onTick: ->
#        common.tpsTrend(0, '&locale=ja', null, room, true)
#
#    jobMorningHnFund: new CronJob
#      cronTime: "00 02 10 * * 1-5"
#      timeZone: "Asia/Tokyo"
#      onTick: ->
#        common.parseRss('hnfund', null, room, true)
#
#    jobMorningHnPay: new CronJob
#      cronTime: "00 06 10 * * 1-5"
#      timeZone: "Asia/Tokyo"
#      onTick: ->
#        common.parseRss('hnpay', null, room, true)
#
#    jobMorningHn: new CronJob
#      cronTime: "00 10 10 * * 1-5"
#      timeZone: "Asia/Tokyo"
#      onTick: ->
#        common.parseRss('hn', null, room, true)
#
#    jobMorningGhTrendGo: new CronJob
#      cronTime: "00 30 10 * * *"
#      timeZone: "Asia/Tokyo"
#      onTick: ->
#        common.ghTrend('daily', '&l=go', null, room)

    jobMorningStock1: new CronJob
      cronTime: "00 00 10 * * 1-5"
      timeZone: "Asia/Tokyo"
      onTick: ->
        common.stock('9424', null, room)

    jobMorningStock2: new CronJob
      cronTime: "00 01 10 * * 1-5"
      timeZone: "Asia/Tokyo"
      onTick: ->
        common.stock('2491', null, room)

    jobMorningStock3: new CronJob
      cronTime: "00 02 10 * * 1-5"
      timeZone: "Asia/Tokyo"
      onTick: ->
        common.stock('7612', null, room)

    jobMorningStock4: new CronJob
      cronTime: "00 03 10 * * 1-5"
      timeZone: "Asia/Tokyo"
      onTick: ->
        common.stock('2489', null, room)

    jobAfternoonBitcoin: new CronJob
      cronTime: "00 00 13 * * *"
      timeZone: "Asia/Tokyo"
      onTick: ->
        common.bcTick('USD', null, room)

#    jobAfternoonExp: new CronJob
#      cronTime: "00 30 11 * * *"
#      timeZone: "Asia/Tokyo"
#      onTick: ->
#        common.exchange('USD', 'JPY', null, room)

#    jobAfternoonHima: new CronJob
#      cronTime: "00 00 13 * * *"
#      timeZone: "Asia/Tokyo"
#      onTick: ->
#        common.parseRss('hima', null, room)
#
#    jobAfternoonHtnNewIt: new CronJob
#      cronTime: "00 10 13 * * *"
#      timeZone: "Asia/Tokyo"
#      onTick: ->
#        common.parseRss('htnni', null, room)

  }

  # start jobs
  for k, job of jobs
    job.jobKey = k
    job.start()
    Log.debug "Start CronJob #{k}"

  #job.stop()
