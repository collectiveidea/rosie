# Description
#   Posts Google Hangout URL for standup. (Defaults to weekdays at 9:30AM EST)
#
# Dependences:
#   "cron"
#   "time"
#
# Configuration:
#   STANDUP_HANGOUT_URL
#   STANDUP_ROOM_ID
#   STANDUP_CRON_TIME - Defaults to M-F 9:30AM
#   STANDUP_TIME_ZONE - Defaults to America/New_York
#
# Commands:
#   hubot, standup - Returns the standup Hangout URL
#
# Author:
#   ersatzryan

cronJob = require('cron').CronJob

module.exports = (robot) ->
    robot.respond /standup$/i, ->
      robot.messageRoom process.env.STANDUP_ROOM_ID, process.env.STANDUP_HANGOUT_URL

    new cronJob
      cronTime: (process.env.STANDUP_CRON_TIME || '30 9 * * 1-5') # M-F 9:30AM
      onTick: ->
        robot.messageRoom process.env.STANDUP_ROOM_ID, "STANDUP: #{process.env.STANDUP_HANGOUT_URL}"
      onComplete: null
      start: true
      timeZone: (process.env.STANDUP_TIME_ZONE || "America/New_York")
