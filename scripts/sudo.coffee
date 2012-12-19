# Description:
#   Forces hubot to do what you want, even if he doesn't know how
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot sudo <anything you want> - Force hubot to do what you want
#
# Author:
#   searls

module.exports = (robot) ->
  robot.respond /(sudo)(.*)/i, (msg) ->
    if Math.random() >= 0.5
      msg.send "Alright. I'll #{msg.match?[2] || "do whatever it is you wanted."}"

    else
      msg.send "You are not in the sudoers file. This incident has been reported."
