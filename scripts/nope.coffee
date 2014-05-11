# nope picture
#
module.exports = (robot) ->
  robot.hear /nope/, (msg) ->
    msg.send "http://imgur.com/MxQsUJn"
