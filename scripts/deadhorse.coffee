# Description
#   Keeps track of links already posted and mocks the user who posted
#
# Dependences:
#
# Configuration:
#
# Commands:
#   hubot deadhorses - Returns the list of guilty
#
# Author:
#   ersatzryan
#

class DeadHorse
  constructor: (@robot) ->
    @cache = {}
    @links = []

    @robot.brain.on 'loaded', =>
      if @robot.brain.data.deadhorse
        @cache = @robot.brain.data.deadhorse
        @links = @robot.brain.data.deadhorse_links

  sort: ->
    s = []
    for key, val of @cache
      s.push({name: key, deadhorses: val})
    s.sort (a, b) -> b.deadhorses - a.deadhorses

  increment: (user) ->
    @cache[user] ?= 0
    @cache[user] -= 1
    @robot.brain.data.deadhore = @cache

  top: (n = 5) ->
    sorted = @sort()
    sorted.slice(-n).reverse()

  add: (url, user) ->
    if url in @links
      increment(user)
      true
    else
      @links << url
      false


module.exports = (robot) ->
  deadhorse = new DeadHorse(robot)

  robot.respond /deadhorses/i, (msg) ->
    text = ["Most Dead Horses Kicked"]
    for item, rank in deadhorse.top()
      text.push "#{rank + 1}. #{item.name} - #{item.deadhorses}"
    msg.send text.join("\n")

  robot.hear /http(s?)\:\/\/\S+/i, (msg) ->
    console.log(deadhorse.links)
    if deadhorse.add(msg.match[1])
      msg.respond "You're really kicking a dead horse, #{msg.user.name}."
