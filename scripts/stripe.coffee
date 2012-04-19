# Announce payments to a strip account to the room

module.exports = (robot) ->
  robot.router.post '/hubot/stripe/:account/:room', (req, res) ->
    room = req.params.room
    
    #data = JSON.parse req.body
    payment = req.body.data
    console.log payment

    msg = "STRIPE: #{payment.name} paid $#{payment.amount}"
    #msg = "TEST: #{data}"

    robot.messageRoom room, msg
      
    res.writeHead 204, { 'Content-Length': 0 }
    res.end()
