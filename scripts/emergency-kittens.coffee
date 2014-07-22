module.exports = (robot) ->
  robot.hear /\bkitten\b/i, (msg) ->
    msg.http("http://emergencykitten.com/img/random").get() (err, res, body) ->
      msg.send(res.getHeader('Location') + "#.png")
