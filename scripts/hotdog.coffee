images = [
  "http://f.cl.ly/items/352M0i0y3P2t110W0W1c/pasted_image_at_2015_02_12_04_07_pm.png"
]

module.exports = (robot) ->
  robot.hear /(?:^|\s)hot\s?dogs?(?:\s|$)/i, (msg) ->
    msg.send(msg.random(images))
