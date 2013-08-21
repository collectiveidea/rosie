# silver fox hound
#
module.exports = (robot) ->
  robot.hear /\b(silver|fox|hound)\b/i, (msg) ->
    msg.send "http://i.imgur.com/TgrOXTk.gif"

  robot.hear /\b(money|vices|smoking|pay day|suit|vp)\b/i, (msg) ->
    msg.send "http://i.imgur.com/rGipnfq.gif"
