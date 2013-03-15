# pew pew pew picture
#
module.exports = (robot) ->
  robot.hear /pew( pew)+|[^a]'?merica\b/i, (msg) ->
    msg.send "http://i.imgur.com/uQg4I.jpg"