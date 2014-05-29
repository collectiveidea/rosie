# Get reaction gifs from reddit.com/r/reactiongifs
#
# reaction <query>

module.exports = (robot) ->
  robot.respond /react(ion)?( me)? (.*)/i, (msg) ->
    reactionMe msg, msg.match[3], (entry) ->
      msg.send entry.url
      msg.send entry.title

reactionMe = (msg, query, callback) ->
  msg.http('http://api.reddit.com/r/reactiongifs/search.json')
    .query(q: query, restrict_sr: true)
    .get() (err, res, body) ->
      records = JSON.parse(body).data.children
      callback records[randomNumber(records.length)].data

randomNumber = (limit) ->
  Math.floor(Math.random() * (1 + limit))
