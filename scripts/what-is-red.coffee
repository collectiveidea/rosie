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
#   hubot what-is-red - Posts red projects report
#
# Author:
#   laserlemon

# cronJob = require("cron").CronJob

module.exports = (robot) ->
  robot.respond /what-is-red$/i, -> postWhatIsRed(robot)

  new cronJob
    cronTime: "20 9 * * 1-5" # M-F 9:20AM
    onTick: -> postWhatIsRed(robot)
    onComplete: null
    start: true
    timeZone: "America/New_York"

postWhatIsRed = (robot) ->
  robot.http("http://buildlight.collectiveidea.com/what-is-red.json").get() (err, res, body) ->
    redProjects = JSON.parse(body)
    if redProjects?.length > 0
      names = redProjects.map (project) -> project.project_name
      msg = "The following projects are failing\n" + names.reduce (x, y) -> x + "\n" + y
      robot.messageRoom process.env.PRIVATE_ROOM_ID, msg
    else
      robot.messageRoom process.env.PRIVATE_ROOM_ID, "All projects are green :tada:"
