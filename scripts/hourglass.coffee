# Description
#   Posts an Hourglass time-tracking report. (Defaults to weekdays at 9:25AM EST)
#
# Dependences:
#   "cron"
#   "time"
#
# Configuration:
#   HOURGLASS_URL
#   HOURGLASS_ROOM_ID
#   HOURGLASS_CRON_TIME - Defaults to M-F 9:25AM
#   HOURGLASS_TIME_ZONE - Defaults to America/New_York
#
# Commands:
#   hubot hours - Posts an Hourglass report
#
# Author:
#   laserlemon

cronJob = require("cron").CronJob

module.exports = (robot) ->
  robot.respond /hours$/i, (msg) ->
    msg.http("http://#{process.env.HOURGLASS_USERNAME}:#{process.env.HOURGLASS_PASSWORD}@hourglass.collectiveidea.com/projects.txt").get() (err, res, body) ->
      robot.adapter.bot.Room(process.env.HOURGLASS_ROOM_ID).paste(body)

  new cronJob
    cronTime: (process.env.HOURGLASS_CRON_TIME || "25 9 * * 1-5") # M-F 9:25AM
    onTick: ->
      robot.adapter.bot.Room(process.env.HOURGLASS_ROOM_ID).paste("Hello, world!")
    onComplete: null
    start: true
    timeZone: (process.env.HOURGLASS_TIME_ZONE || "America/New_York")
