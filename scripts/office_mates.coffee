# silver fox hound
#
module.exports = (robot) ->
  robot.hear /\blucky\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.lucky_timer? || (t - 300000) > robot.brain.data.lucky_timer
      robot.brain.data.lucky_timer = t - 1
      msg.send "http://i.imgur.com/3Z5FjvK.gif"

  robot.hear /\b(country|western|straw hat|cowboy)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.country_timer? || (t - 300000) > robot.brain.data.country_timer
      robot.brain.data.country_timer = t - 1
      msg.send "http://farm3.staticflickr.com/2760/4444147325_a95c543463_n.jpg"

  robot.hear /\b(ladies man|hey ladies)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.ladies_timer? || (t - 300000) > robot.brain.data.ladies_timer
      robot.brain.data.ladies_timer = t - 1
      msg.send "https://files.slack.com/files-pri/T024LL7PK-F04GVFHG2/ladies_man_small.png"

  robot.hear /\b(lumberjack|axe|flannel)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.lumberjack_timer? || (t - 300000) > robot.brain.data.lumberjack_timer
      robot.brain.data.lumberjack_timer = t - 1
      msg.send(
        msg.random([
          "https://files.slack.com/files-pri/T024LL7PK-F3AQ3HCLD/slack_for_ios_upload.jpg",
          "http://i.imgur.com/Pv005Es.jpg"
        ])
      )

  robot.hear /\b(orly|oh really)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.orly_timer? || (t - 300000) > robot.brain.data.orly_timer
      robot.brain.data.orly_timer = t - 1
      msg.send "http://imgur.com/1yn3xVc.jpg"

  robot.hear /\b(magic)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.magic_timer? || (t - 300000) > robot.brain.data.magic_timer
      robot.brain.data.magic_timer = t - 1
      msg.send "http://i.kinja-img.com/gawker-media/image/upload/s--JUMxC_o1--/1462432556329353359.gif"

  robot.hear /\b(modern)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.modern_timer? || (t - 300000) > robot.brain.data.modern_timer
      robot.brain.data.modern_timer = t - 1
      msg.send "https://collectiveidea.slack.com/files/victor/F0DEUDU68/pasted_image_at_2015_10_29_02_37_pm.png"

  robot.hear /\b(wizard)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.wizard_timer? || (t - 300000) > robot.brain.data.wizard_timer
      robot.brain.data.wizard_timer = t - 1
      msg.send "https://collectiveidea.slack.com/files/ray/F6508RY04/raydalf.jpg"

  robot.hear /\b(ninja)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.ninja_timer? || (t - 300000) > robot.brain.data.ninja_timer
      robot.brain.data.ninja_timer = t - 1
      msg.send "https://collectiveidea.slack.com/files/p/F6LTKM4RX/ninja_ray.jpg"

  robot.here /\b(looks fine to me)\b/i, (msg) ->
    t = new Date
    if !robot.brain.data.looks_fine_timer? || (t - 300000) > robot.brain.data.looks_fine_timer
      robot.brain.data.looks_fine_timer = t - 1
      msg.send "https://assets-auto.rbl.ms/353b2f6ae2b6c1a3eba793b396e6f161d832bc9ebc68604b18608416c183cc17"
