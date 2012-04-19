# Announce payments to a strip account to the room

module.exports = (robot) ->
  robot.router.post '/hubot/stripe/:account/:room', (req, res) ->
    room = req.params.room
    
    payment =  req.body.data.object
    #data = JSON.parse req.body.data

    msg = "STRIPE: #{payment.name} paid $#{payment.amount / 100.00}"
    #msg = "TEST: #{data}"

    robot.messageRoom room, msg
      
    res.writeHead 204, { 'Content-Length': 0 }
    res.end()
