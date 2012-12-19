# drunk picture
#
module.exports = (robot) ->
  robot.hear /drunk|poor life choices?/, (msg) ->
    msg.send "http://www.whileiwasdrunk.org/image/drunk/1105/-drunk-1305561114.jpg"
