# Commands:
#   /music status - Displays the current Walkman URL
#   /music play - Plays music
#   /music stop - Stops the beats
#   /music next - Plays the next song
#   /music current - Returns the song currently playing
#   /music queue - Returns next 5 songs in the queue
#   /music like - Tells Walkman to play more songs like the current song
#   /music ban - Tells Walkman to never play this song again
#   /music play artist <artist> - Plays songs from the given artist
#   /music radio artist <artist> - Plays music similar to the given artist
#   /music output <output> - Directs audio to the given output as named in System Preferences

# URL = process.env.MUSIC_URL # "http://music.collectiveidea.com"
URL = "http://localhost:3000/api/player"

apiRequest = (message, path, action, options, callback) ->
  message.http("#{URL}#{path}")
    .header("Content-Length", 0)
    .query(options)[action]() (err, res, body) ->
      callback(err,res,body)

module.exports = (robot) ->
  robot.respond /music status/i, (message) ->
    message.send(":information_source: Walkman is pointed to #{URL}")

  robot.respond /music play (.*)/i, (message) ->
    if message.match[1].search(/artist/) != -1
      return

    apiRequest message, "/play", "post", {}, (err, res, body) ->
      if song = JSON.parse(body)
        message.send(":musical_note: #{song.title} by #{song.artist}")
      else
        message.send(":speak_no_evil: No music is queued")

  robot.respond /music stop/i, (message) ->
    apiRequest message, "/stop", "post", {}, (err, res, body) ->
      message.send(":mute: Stopping the beats")

  robot.respond /music (next|skip)/i, (message) ->
    apiRequest message, "/next", "post", {}, (err, res, body) ->
      song = JSON.parse(body)
      if song != null
        message.send(":musical_note: #{song.title} by #{song.artist}")
      else
        message.send(":speak_no_evil: No more music is queued")

  robot.respond /music skip (\d+)/i, (message) ->
    params = { count: message.match[1] }
    apiRequest message, "/next", "post", params, (err, res, body) ->
      song = JSON.parse(body)
      if song != null
        message.send(":musical_note: #{song.title} by #{song.artist}")
      else
        message.send(":speak_no_evil: No more music is queued")

  robot.respond /music current/i, (message) ->
    apiRequest message, "/now-playing", "get", {}, (err, res, body) ->
      song = JSON.parse(body)
      if song != null
        message.send(":musical_note: #{song.title} by #{song.artist}")
      else
        message.send(":speak_no_evil: No music is playing")

  robot.respond /music queue/i, (message) ->
    apiRequest message, "/up-next", "get", {}, (err, res, body) ->
      songs = JSON.parse(body)
      if songs != null
        response = songs.map (song) ->
          "#{song.artist} - #{song.title}"
        message.send(response.join("\n"))
      else
        message.send(":speak_no_evil: No more music is queued")

  robot.respond /music like/i, (message) ->
    apiRequest message, "/like", "post", {}, (err, res, body) ->
      response = JSON.parse(body)
      if res.statusCode == 200
        message.send(":star: Awesome! I'll play more music like #{response.title} by #{response.artist}")
      else
        message.send(":warning: #{response["message"]}")

  robot.respond /music ban/i, (message) ->
    apiRequest message, "/ban", "post", {}, (err, res, body) ->
      response = JSON.parse(body)
      if res.statusCode == 200
        message.send(":boom: Bummer. I won't play #{response.title} by #{response.artist} again")
      else
        message.send(":warning: #{response["message"]}")

  robot.respond /music play artist (.*)/i, (message) ->
    params = { type: "artist", artist: message.match[1] }
    apiRequest message, "/queue", "post", params, (err, res, body) ->
      song = JSON.parse(body)
      if song != null
        message.send(":musical_note: #{song.title} by #{song.artist}")
      else
        message.send(":speak_no_evil: I couldn't queue up any songs for that artist")

  robot.respond /music radio artist (.*)/i, (message) ->
    params = { type: "artist-radio", artist: message.match[1] }
    apiRequest message, "/queue", "post", params, (err, res, body) ->
      song = JSON.parse(body)
      if song != null
        message.send(":musical_note: #{song.title} by #{song.artist}")
      else
        message.send(":speak_no_evil: I couldn't queue up any music like that artist")

  robot.respond /music output (.*)/i, (message) ->
    params = { audio_output: message.match[1] }
    apiRequest message, "/audio-output", "post", params, (err, res, body) ->
      response = JSON.parse(body)
      if res.statusCode == 200
        message.send(":speaker: #{response["message"]}")
      else
        message.send(":warning: #{response["message"]}")
