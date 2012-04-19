# Announce payments to a strip account to the room

module.exports = (robot) ->
  robot.router.post '/hubot/stripe/:account/:room', (req, res) ->
    room = parseInt(req.params.room)
    payment =  req.body.data.object

    if payment.paid == true
      msg = "STRIPE: #{payment.card.name} paid $#{payment.amount / 100.00} for #{req.params.account}"
      robot.messageRoom room, msg
      console.log "Sending stripe charge message to room #{req.params.room}"

    res.writeHead 204, { 'Content-Length': 0 }
    res.end()
