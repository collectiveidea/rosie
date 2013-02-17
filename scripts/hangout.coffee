# Description
#   Posts Google Hangout URL when a user mentions hangout
#
# Dependences:
#
# Configuration:
#
# Commands:
#   hubot, hangout add <url> - Add Hangout URL to rotation (Create a G+ Event way in future with hangout)
#   hubot, hangout rm <url> - Remove Hangout URL from rotation
#   hubot, hangouts - List Hangouts
#
# Author:
#   ersatzryan

module.exports = (robot) ->
  robot.respond /hangouts$/i, (msg) ->
    robot.brain.data.hangouts ?= []
    msg.send robot.brain.data.hangouts.join("\n")

  robot.respond /hangouts add (https\:\/\/\S+)/i, (msg) ->
    robot.brain.data.hangouts ?= []
    robot.brain.data.hangouts.push(msg.match[1])
    msg.send "Thank you. I now have #{robot.brain.data.hangouts.length} room(s)."

  robot.respond /hangouts rm (https\:\/\/\S+)/i, (msg) ->
    if robot.brain.data.hangouts?
      href = robot.brain.data.hangouts.splice(robot.brain.data.hangouts.indexOf(msg.match[1]), 1)
      msg.send "Removed: #{href}"
    else
      msg.send "No Hangouts"

  robot.hear /\bhangout\b/i, (msg) ->
    if robot.brain.data.hangouts?
      robot.brain.data.hangout_count ?= 0
      index = (robot.brain.data.hangout_count % robot.brain.data.hangouts.length)

      msg.send "#{msg.message.user.name}: #{robot.brain.data.hangouts[index]}"
      robot.brain.data.hangout_count++
    else
      msg.send "Please add some hangout urls"

