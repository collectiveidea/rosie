# pew pew pew picture
#
module.exports = (robot) ->
  robot.hear /pew( pew)+|'?merica/, (msg) ->
    msg.send "http://i.imgur.com/uQg4I.jpg"