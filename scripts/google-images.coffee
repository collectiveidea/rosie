# A way to interact with the Google Images API.
#
# image me <query>    - The Original. Queries Google Images for <query> and
#                       returns a random top result.
# animate me <query>  - The same thing as `image me`, except adds a few
#                       parameters to try to return an animated GIF instead.
# mustache me <url>   - Adds a mustache to the specified URL.
# mustache me <query> - Searches Google Images for the specified query and
#                       mustaches it.
module.exports = (robot) ->
  robot.respond /(image|img)( me)? (.*)/i, (msg) ->
    imageMe msg, msg.match[3], (url) ->
      msg.send url

  robot.respond /animate me (.*)/i, (msg) ->
    animateMe msg, msg.match[1], (url) ->
      msg.send url

processResults = (msg, body, cb) ->
  data = JSON.parse(body).responseData
  if data?
    image = msg.random data.results
    cb "#{image.unescapedUrl}#.png"
  else
    cb "Google responded weird:"
    cb body

imageMe = (msg, query, cb) ->
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(v: "1.0", rsz: '8', q: query)
    .get() (err, res, body) ->
      processResults(msg, body, cb)

animateMe = (msg, query, cb) ->
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(v: "1.0", rsz: '8', as_filetype: 'gif', q: "#{query} animated gif")
    .get() (err, res, body) ->
      processResults(msg, body, cb)
