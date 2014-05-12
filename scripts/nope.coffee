# nope picture
#
module.exports = (robot) ->
  robot.hear /nope/, (msg) ->
    msg.send "http://i.imgur.com/MxQsUJn.gif"
