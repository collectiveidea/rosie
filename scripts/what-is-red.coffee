# Description
#   Posts what projects are keeping the build light red. (Defaults to weekdays at 9:25AM EST)
#
# Dependences:
#   "cron"
#   "time"
#
# Configuration:
#   PRIVATE_ROOM_ID
#
# Commands:
#   hubot what projects are red - Posts red projects report
#
# Author:
#   laserlemon

cronJob = require("cron").CronJob

module.exports = (robot) ->
  robot.respond /(what projects are red|red|borked|blame)$/i, (msg) ->
    postWhatIsRed(robot, msg)

  # new cronJob
  #   cronTime: "20 9 * * 1-5" # M-F 9:20AM
  #   onTick: -> postWhatIsRed(robot)
  #   onComplete: null
  #   start: true
  #   timeZone: "America/New_York"

postWhatIsRed = (robot, msg) ->
  robot.http("http://buildlight.collectiveidea.com/what-is-red.json").get() (err, res, body) ->
    redProjects = JSON.parse(body)
    if redProjects?.length > 0
      names = redProjects.map (project) -> project.username + "/" + project.project_name
      note = "The following projects are failing:\n"
      note += names.reduce (x, y) -> x + "\n" + y
      msg.send note
    else
      msg.send "All projects are green :tada:"
