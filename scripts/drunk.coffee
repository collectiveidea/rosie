# drunk picture
#
module.exports = (robot) ->
  robot.hear /drunk|poor life choices?/, (msg) ->
    msg.send "http://i.imgur.com/jzsUs.jpg"
