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

  robot.respond /animate( me)? (.*)/i, (msg) ->
    animateMe msg, msg.match[1], (url) ->
      msg.send url

processResults = (msg, query, body, cb, search_function, attempt) ->
  data = JSON.parse(body).responseData
  if data?
    image = msg.random data.results
    cb "#{image.unescapedUrl}#.png"
  else if attempt == 5
    cb "I failed to get an image due to rate limiting."
  else if attempt <= 5
    setTimeout(
      () -> search_function(msg, query, cb, attempt + 1),
      (attempt * 1000 + (Math.random() * 1000)) + 2000
    )

imageMe = (msg, query, cb, attempt = 1) ->
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(v: "1.0", rsz: '8', q: query)
    .get() (err, res, body) ->
      processResults(msg, query, body, cb, imageMe, attempt)

animateMe = (msg, query, cb, attempt = 1) ->
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(v: "1.0", rsz: "8", imgtype: "animated", q: query)
    .get() (err, res, body) ->
      processResults(msg, query, body, cb, animateMe, attempt)
