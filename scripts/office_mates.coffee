# silver fox hound
#
module.exports = (robot) ->
  robot.hear /\blucky\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.lucky_timer? || (t - 300000) > robot.brain.data.lucky_timer
      robot.brain.data.lucky_timer = t - 1
      msg.send "http://i.imgur.com/3Z5FjvK.gif"

  robot.hear /\bthe point\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.the_point_timer? || (t - 300000) > robot.brain.data.the_point_timer
      robot.brain.data.the_point_timer = t - 1
      msg.send "http://i.imgur.com/QgIoRSJ.gif"

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

  robot.hear /\b(ladies man|hey ladies)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.ladies_timer? || (t - 300000) > robot.brain.data.ladies_timer
      robot.brain.data.ladies_timer = t - 1
      msg.send "https://collectiveidea.campfirenow.com/room/109379/uploads/5708742/ladies_man_small.png"

  robot.hear /\b(gosling|hey girl)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.gosling_timer? || (t - 300000) > robot.brain.data.gosling_timer
      robot.brain.data.gosling_timer = t - 1
      msg.send "http://imgur.com/PXK1lza.jpg"

  robot.hear /\b(lumberjack|axe|flannel)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.lumberjack_timer? || (t - 300000) > robot.brain.data.lumberjack_timer
      robot.brain.data.lumberjack_timer = t - 1
      msg.send "http://imgur.com/yDXC3Xt.jpg"

  robot.hear /\b(orly|oh really)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.orly_timer? || (t - 300000) > robot.brain.data.orly_timer
      robot.brain.data.orly_timer = t - 1
      msg.send "http://imgur.com/1yn3xVc.jpg"

  robot.hear /\b(sombrero)\b/i, (msg) ->
    images = [
      "http://25.media.tumblr.com/tumblr_m1ikw0vTEY1qh5d8ko1_500.jpg",
      "http://s.mlkshk.com/r/YMI4.gif"
    ]
    t = new Date
    if !robot.brain.data.sombrero_timer? || (t - 300000) > robot.brain.data.sombrero_timer
      robot.brain.data.sombrero_timer = t - 1
      msg.send(msg.random(images))
