# Announce payments to a strip account to the room

module.exports = (robot) ->
  robot.router.post '/hubot/kegbot', (req, res) ->
    if req.params.api_key == process.env.KEGBOT_API_KEY
      robot.messageRoom process.env.KEGBOT_ROOM_ID, req.body
      res.writeHead 204, { 'Content-Length': 0 }
    else
      res.writeHead 404, { 'Content-Length': 0 }

    res.end()
