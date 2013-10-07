# silver fox hound
#
module.exports = (robot) ->
  robot.hear /\b(silver|fox|hound)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.fox_timer? || (t - 300000) > robot.brain.data.fox_timer
      robot.brain.data.fox_timer = t - 1
      msg.send "http://i.imgur.com/TgrOXTk.gif"
    else
      msg.send "Too soon."

  robot.hear /\b(money|vices|smoking|pay day|suit|vp)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.money_timer? || (t - 300000) > robot.brain.data.money_timer
      robot.brain.data.money_timer = t - 1
      msg.send "http://i.imgur.com/rGipnfq.gif"
    else
      msg.send "Too soon."
