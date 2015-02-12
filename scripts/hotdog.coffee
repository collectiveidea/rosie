images = [
  "http://cl.ly/image/3M3c0d3h1M0g"
]

module.exports = (robot) ->
  robot.hear /(?:^|\s)hot\s?dogs?(?:\s|$)/i, (msg) ->
    msg.send(msg.random(images))
