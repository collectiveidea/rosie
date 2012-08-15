# Do you regret?
#
module.exports = (robot) ->
  robot.hear /do you regret/, (msg) ->
    msg.send "http://i214.photobucket.com/albums/cc66/uchiha_sasuke_777/Gifs/chickeniregretnothing.gif#.png"

imageMe = (msg, query, cb) ->
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(v: "1.0", rsz: '8', q: query)
    .get() (err, res, body) ->
      images = JSON.parse(body)
      images = images.responseData.results
      image  = msg.random images
      cb "#{image.unescapedUrl}#.png"

