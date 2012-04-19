# Announce payments to a strip account to the room

module.exports = (robot) ->
  robot.router.post '/hubot/stripe/:account/:room', (req, res) ->
    room = req.params.room
    
    #data = JSON.parse req.body
    #payment = data.data.object

    #msg = "STRIPE: #{payment.name} paid $#{payment.amount}"
    msg = "TEST: #{req.body.payload}"

    robot.messageRoom room, msg
      
    res.writeHead 204, { 'Content-Length': 0 }
    res.end()
