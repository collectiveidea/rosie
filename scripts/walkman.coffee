# Commands:
#   walkman startup - Starts the Walkman services.
#   walkman shutdown - Stops the Walkman services.
#   play music - Plays music.
#   stop music - Stops the beats.
#   next song - Plays the next song.
#   what's playing - Returns the song current playing.
#   what's next - Returns next 5 songs in the queue.
#   I like this song - Tells Walkman to play more songs like the current song.
#   play artist <artist> - Plays songs from the given artist.
#   play artist radio <artist> - Plays music similar to the given artist.

URL = "http://music.collectiveidea.com"

apiRequest = (message, path, action, options, callback) ->
  message.http("#{URL}#{path}")
    .header('Content-Length', 0)
    .query(options)[action]() (err, res, body) ->
      callback(err,res,body)

module.exports = (robot) ->
  robot.hear /walkman start/i, (message) ->
    apiRequest message, '/startup', 'post', {}, (err, res, body) ->
      message.send(body)

  robot.hear /walkman stop/i, (message) ->
    apiRequest message, '/shutdown', 'post', {}, (err, res, body) ->
      message.send(body)

  robot.hear /play music/i, (message) ->
    apiRequest message, '/play', 'post', {}, (err, res, body) ->
      message.send(body)

  robot.hear /stop music/i, (message) ->
    apiRequest message, '/stop', 'post', {}, (err, res, body) ->
      message.send("Stopping the beats.")

  robot.hear /next (song|tune)/i, (message) ->
    apiRequest message, '/next', 'post', {}, (err, res, body) ->
      message.send(body)

  robot.hear /what'?s playing/i, (message) ->
    apiRequest message, '/now-playing', 'get', {}, (err, res, body) ->
      message.send(body)

  robot.hear /what'?s next/i, (message) ->
    apiRequest message, '/up-next', 'get', {}, (err, res, body) ->
      message.send(body)

  robot.hear /I (like|star|love|dig) this( song)?/i, (message) ->
    apiRequest message, '/like', 'post', {}, (err, res, body) ->
      message.send(body)

  robot.hear /play artist (.*)/i, (message) ->
    if message.match[1].search(/radio/) != -1 ||
       message.match[1].search(/music/) != -1
      return

    params = { artist: message.match[1] }
    apiRequest message, '/play/artist', 'post', params, (err, res, body) ->
      message.send(body)

  robot.hear /play artist radio (.*)/i, (message) ->
    params = { artist: message.match[1] }
    apiRequest message, '/play/artist-radio', 'post', params, (err, res, body) ->
      message.send(body)
