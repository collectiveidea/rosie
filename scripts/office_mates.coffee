# silver fox hound
#
module.exports = (robot) ->
  robot.hear /\b(silver|fox)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.fox_timer? || (t - 300000) > robot.brain.data.fox_timer
      robot.brain.data.fox_timer = t - 1
      msg.send "http://i.imgur.com/TgrOXTk.gif"

  robot.hear /\b(vices|smoking|pay day|suit|vp)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.money_timer? || (t - 300000) > robot.brain.data.money_timer
      robot.brain.data.money_timer = t - 1
      msg.send "http://i.imgur.com/rGipnfq.gif"

  robot.hear /\b(country|western|straw hat|cowboy)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.country_timer? || (t - 300000) > robot.brain.data.country_timer
      robot.brain.data.country_timer = t - 1
      msg.send "http://farm3.staticflickr.com/2760/4444147325_a95c543463_n.jpg"
