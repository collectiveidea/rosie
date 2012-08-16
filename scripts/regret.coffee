# Do you regret?
#
module.exports = (robot) ->
  robot.hear /do you regret/, (msg) ->
    imageMe msg, "i regret nothing", (text) ->
      msg.send text

imageMe = (msg, query, cb) ->
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(v: "1.0", rsz: '8', q: query)
    .get() (err, res, body) ->
      images = JSON.parse(body)
      images = images.responseData.results
      image  = msg.random images
      cb "#{image.unescapedUrl}#.png"

