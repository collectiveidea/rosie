# Description:
#   Cowsay.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot cowsay <statement> - Returns a cow that says what you want
#
# Author:
#   brettbuddin

module.exports = (robot) ->
  robot.respond /cowsay( me)? (.*)/i, (msg) ->
    if msg.match[2].match /^fortune$/i
      msg.http('http://www.fortunefortoday.com/getfortuneonly.php')
        .get() (err, res, body) ->
          cowsay(msg, body)
    else
      cowsay(msg, msg.match[2])

cowsay = (msg, text) ->
  msg
    .http("http://cowsay.morecode.org/say")
    .query(format: 'text', message: text)
    .get() (err, res, body) ->
      msg.send "```\n#{body}\n```"
