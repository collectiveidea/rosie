images = [
  "http://gifsoup.com/webroot/animatedgifs/2966911_o.gif",
  "http://i557.photobucket.com/albums/ss15/edibility/sprocketsdance-1.gif"
]

# Now is the time on sprockets when we dance!
module.exports = (robot) ->
  robot.hear /dance/i, (msg) ->
    msg.send(msg.random(images))
