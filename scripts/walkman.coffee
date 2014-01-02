# Commands:
#   /walkman status - Displays the current Walkman URL
#   /play - Plays music.
#   /stop - Stops the beats.
#   /next - Plays the next song.
#   /what's playing - Returns the song current playing.
#   /what's next - Returns next 5 songs in the queue.
#   /like song - Tells Walkman to play more songs like the current song.
#   /ban song - Tells Walkman to never play this song again.
#   /play artist <artist> - Plays songs from the given artist.
#   /radio artist <artist> - Plays music similar to the given artist.
#   /audio output <output> - Directs audio to the given output as named in System Preferences

# URL = process.env.MUSIC_URL # "http://music.collectiveidea.com"
URL = "http://localhost:3000/api/player"

apiRequest = (message, path, action, options, callback) ->
  message.http("#{URL}#{path}")
    .header("Content-Length", 0)
    .query(options)[action]() (err, res, body) ->
      callback(err,res,body)

module.exports = (robot) ->
  robot.respond /walkman status/i, (message) ->
    message.send("Walkman is pointed to #{URL}")

  robot.respond /play/i, (message) ->
    apiRequest message, "/play", "post", {}, (err, res, body) ->
      # we started playing, now let's get the current song
      apiRequest message, "/now-playing", "get", {}, (err, res, body) ->
        if song = JSON.parse(body)
          message.send("♫ #{song.title} by #{song.artist}")
        else
          message.send("♯ No music is queued")

  robot.respond /stop/i, (message) ->
    apiRequest message, "/stop", "post", {}, (err, res, body) ->
      message.send("♯ Stopping the beats")

  robot.respond /(skip|next)/i, (message) ->
    apiRequest message, "/next", "post", {}, (err, res, body) ->
      song = JSON.parse(body)
      if song != null
        message.send("♫ #{song.title} by #{song.artist}")
      else
        message.send("♯ No more music is queued")

  robot.respond /skip (.*) songs/i, (message) ->
    params = { count: message.match[1] }
    apiRequest message, "/next", "post", params, (err, res, body) ->
      song = JSON.parse(body)
      if song != null
        message.send("♫ #{song.title} by #{song.artist}")
      else
        message.send("♯ No more music is queued")

  robot.respond /what'?s playing/i, (message) ->
    apiRequest message, "/now-playing", "get", {}, (err, res, body) ->
      song = JSON.parse(body)
      if song != null
        message.send("♫ #{song.title} by #{song.artist}")
      else
        message.send("♯ No music is playing")

  robot.respond /what'?s next/i, (message) ->
    apiRequest message, "/up-next", "get", {}, (err, res, body) ->
      songs = JSON.parse(body)
      if songs != null
        response = songs.map (song) ->
          "#{song.artist} - #{song.title}"
        message.send(response.join("\n"))
      else
        message.send("♯ No more music is queued")

  robot.respond /(like|love|dig)( this)? song/i, (message) ->
    apiRequest message, "/like", "post", {}, (err, res, body) ->
      response = JSON.parse(body)
      if res.statusCode == 200
        message.send("✓ Awesome! I'll play more music like this")
      else
        message.send("♯ #{response["message"]}")

  robot.respond /(ban|hate)( this)? song/i, (message) ->
    apiRequest message, "/ban", "post", {}, (err, res, body) ->
      response = JSON.parse(body)
      if res.statusCode == 200
        message.send("✗ Bummer. I won't play this song again")
      else
        message.send("♯ #{response["message"]}")

  robot.respond /play artist (.*)/i, (message) ->
    if message.match[1].search(/\bradio\b/) != -1 ||
       message.match[1].search(/\bmusic\b/) != -1
      return

    params = { type: "artist", artist: message.match[1] }
    apiRequest message, "/queue", "post", params, (err, res, body) ->
      song = JSON.parse(body)
      if song != null
        message.send("♫ #{song.title} by #{song.artist}")
      else
        message.send("♯ I couldn't queue up any songs for that artist")

  robot.respond /radio artist (.*)/i, (message) ->
    params = { type: "artist-radio", artist: message.match[1] }
    apiRequest message, "/queue", "post", params, (err, res, body) ->
      song = JSON.parse(body)
      if song != null
        message.send("♫ #{song.title} by #{song.artist}")
      else
        message.send("♯ I couldn't queue up any music like that artist")

  robot.respond /audio output (.*)/i, (message) ->
    params = { audio_output: message.match[1] }
    apiRequest message, "/audio-output", "post", params, (err, res, body) ->
      response = JSON.parse(body)
      if res.statusCode == 200
        message.send("✓ #{response["message"]}")
      else
        message.send("✗ #{response["message"]}")
