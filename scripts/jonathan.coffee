# silver fox hound
#
module.exports = (robot) ->
  robot.hear /\b(silver|fox|hound|old)\b/, (msg) ->
    msg.send "http://i.imgur.com/TgrOXTk.gif"
