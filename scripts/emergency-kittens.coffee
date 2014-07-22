module.exports = (robot) ->
  robot.hear /\bkittens?\b/i, (msg) ->
    msg.http("http://emergencykitten.com/img/random").get() (err, res, body) ->
      msg.send(res.headers.location + "#.png")
