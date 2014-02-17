# Commands:
#   /music status - Displays the current Walkman URL
#   /music play - Plays music
#   /music stop - Stops the beats
#   /music next - Plays the next song
#   /music current - Returns the song currently playing
#   /music queue - Returns next 5 songs in the queue
#   /music like - Tells Walkman to play more songs like the current song
#   /music ban - Tells Walkman to never play this song again
#   /music play <song> by <artist> - Plays given song and starts a song radio station
#   /music play artist <artist> - Plays songs from the given artist
#   /music radio artist <artist> - Plays music similar to the given artist
#   /music output <output> - Directs audio to the given output as named in System Preferences

URL = process.env.MUSIC_API_URL # "http://music.collectiveidea.com/api"

apiRequest = (message, path, action, options, callback) ->
  message.http("#{URL}#{path}")
    .query(github_login: message.message.user.githubLogin, auth_token: process.env.MUSIC_AUTH_TOKEN)
    .header("Content-Length", 0)
    .query(options)[action]() (err, res, body) ->
      if res.statusCode == 401
        message.send(":cop: To control music, you must have an account at http://music.collectiveidea.com:3000 and identify yourself with hubot using /i am <github username>")
      else
        callback(err,res,body)

module.exports = (robot) ->
  robot.router.post "/music", (req, res) ->
    if req.body.api_key == process.env.MUSIC_AUTH_TOKEN
      song = req.body.song
      if song
        robot.messageRoom req.body.room_id || process.env.KEGBOT_ROOM_ID, ":musical_note: #{song.title} by #{song.artist}"
      else
        robot.messageRoom req.body.room_id || process.env.KEGBOT_ROOM_ID, ":speak_no_evil: No song could be played"

      res.writeHead 204, { "Content-Length": 0 }
    else
      res.writeHead 404, { "Content-Length": 0 }

    res.end()

  robot.respond /music status/i, (message) ->
    message.send(":information_source: Walkman is pointed to #{URL}")

  robot.respond /music play$/i, (message) ->
    apiRequest message, "/player/play", "post", {}, (err, res, body) ->
      songs = JSON.parse(body)["songs"]
      if songs.length > 0
        message.send(":musical_note: #{songs[0].title} by #{songs[0].artist}")
      else
        message.send(":speak_no_evil: No music is queued")

  robot.respond /music stop/i, (message) ->
    apiRequest message, "/player/stop", "post", {}, (err, res, body) ->
      message.send(":mute: Stopping the beats")

  robot.respond /music (next|skip)$/i, (message) ->
    params = { count: 1 }
    apiRequest message, "/player/next", "post", params, (err, res, body) ->
      songs = JSON.parse(body)["songs"]
      if songs.length > 0
        message.send(":musical_note: #{songs[0].title} by #{songs[0].artist}")
      else
        message.send(":speak_no_evil: No more music is queued")

  robot.respond /music skip (\d+)/i, (message) ->
    params = { count: message.match[1] }
    apiRequest message, "/player/next", "post", params, (err, res, body) ->
      songs = JSON.parse(body)["songs"]
      if songs.length > 0
        message.send(":musical_note: #{songs[0].title} by #{songs[0].artist}")
      else
        message.send(":speak_no_evil: No more music is queued")

  robot.respond /music current/i, (message) ->
    apiRequest message, "/player/current_song", "get", {}, (err, res, body) ->
      songs = JSON.parse(body)["songs"]
      if songs.length > 0
        message.send(":musical_note: #{songs[0].title} by #{songs[0].artist}")
      else
        message.send(":speak_no_evil: No music is playing")

  robot.respond /music queue/i, (message) ->
    apiRequest message, "/queue", "get", {}, (err, res, body) ->
      songs = JSON.parse(body)["songs"]
      if songs.length > 0
        response = songs.map (song) ->
          "#{song.artist} - #{song.title}"
        message.send(response.join("\n"))
      else
        message.send(":speak_no_evil: No more music is queued")

  robot.respond /music like/i, (message) ->
    apiRequest message, "/songs/like", "post", {}, (err, res, body) ->
      songs = JSON.parse(body)["songs"]
      if songs.length > 0
        message.send(":star: Awesome! I'll play more music like #{songs[0].title} by #{songs[0].artist}")
      else
        message.send(":warning: I couldn't like this song")

  robot.respond /music ban/i, (message) ->
    apiRequest message, "/songs/ban", "post", {}, (err, res, body) ->
      songs = JSON.parse(body)["songs"]
      if songs.length > 0
        message.send(":boom: Bummer. I won't play #{songs[0].title} by #{songs[0].artist} again")
      else
        message.send(":warning: I couldn't ban this song")

  robot.respond /music play artist (.*)/i, (message) ->
    params = { type: "artist", artist: message.match[1], room_id: message.message.room }
    apiRequest message, "/queue", "post", params, (err, res, body) ->
      songs = JSON.parse(body)["songs"]
      if songs.length > 0
        message.send(":musical_note: #{songs[0].title} by #{songs[0].artist}")
      else if res.statusCode == 200
        message.send(":cloud: I don't know those beats. Queueing from The Cloud!")
      else
        message.send(":speak_no_evil: I couldn't queue up any songs for that artist")

  robot.respond /music play (.*) by (.*)/i, (message) ->
    return if message.match[1].search(/artist/) != -1

    params = { type: "song-radio", title: message.match[1], artist: message.match[2] }
    apiRequest message, "/queue", "post", params, (err, res, body) ->
      songs = JSON.parse(body)["songs"]
      if songs.length > 0
        message.send(":musical_note: #{songs[0].title} by #{songs[0].artist}")
      else
        message.send(":speak_no_evil: I couldn't queue up that song")

  robot.respond /music radio artist (.*)/i, (message) ->
    params = { type: "artist-radio", artist: message.match[1], room_id: message.message.room }
    apiRequest message, "/queue", "post", params, (err, res, body) ->
      songs = JSON.parse(body)["songs"]
      if songs.length > 0
        message.send(":musical_note: #{songs[0].title} by #{songs[0].artist}")
      else if res.statusCode == 200
        message.send(":cloud: I don't know those beats. Queueing from The Cloud!")
      else
        message.send(":speak_no_evil: I couldn't queue up any music like that artist")

  robot.respond /music output (.*)/i, (message) ->
    params = { audio_output: message.match[1] }
    apiRequest message, "/player/audio_output", "post", params, (err, res, body) ->
      response = JSON.parse(body)
      if res.statusCode == 200
        message.send(":speaker: Audio output changed to #{params["audio_output"]}")
      else
        message.send(":warning: #{response["error"]}")
