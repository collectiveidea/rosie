# Description
#   Posts Google Hangout URL for morning standup on weekdays at 9:30AM
#
# Dependences:
#   "cron"
#   "time"
#
# Configuration:
#   GOOGLE_HANGOUT_URL
#   STANDUP_ROOM_ID
#
# Commands:
#   /standup - Returns the standup Hangout URL
# Author:
#   ersatzryan

TIMEZONE = "America/New_York"
STANDUP_TIME = '30 9 * * 1-5' # M-F 9:29AM

cronJob = require('cron').CronJob

module.exports = (robot) ->
  if process.env.GOOGLE_HANGOUT_URL
    robot.respond /standup/i, ->
        robot.messageRoom process.env.STANDUP_ROOM_ID, process.env.GOOGLE_HANGOUT_URL

    standup = new cronJob
                cronTime: STANDUP_TIME
                onTick: ->
                  robot.messageRoom process.env.STANDUP_ROOM_ID, process.env.GOOGLE_HANGOUT_URL
                onComplete: null
                start: true
                timeZone: TIMEZONE
  else
    robot.messageRoom process.env.STANDUP_ROOM_ID, 'Environment variable GOOGLE_HANGOUT_URL has not been set.'
