module.exports = (robot) ->
  robot.hear /\bkittens?\b/i, (msg) ->
    kittenMe(msg)

  robot.hear /\b(kittens?!|emergency kittens?)\b/i, (msg) ->
    for i in [1..5]
      kittenMe(msg)

  kittenMe = (msg)->
    msg.http("http://emergencykitten.com/img/random").get() (err, res, body) ->
      msg.send(res.headers.location + "#.png")