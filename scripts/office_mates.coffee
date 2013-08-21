# silver fox hound
#
module.exports = (robot) ->
  robot.hear /\b(silver|fox|hound|old)\b/i, (msg) ->
    msg.send "http://i.imgur.com/TgrOXTk.gif"

  robot.hear /\b(money|vices|smoking|pay day|suit)\b/i, (msg) ->
    msg.send "http://i.imgur.com/rGipnfq.gif"
