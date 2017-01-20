# Description:
#   Rodent Motivation
#
#   Set the environment variable HUBOT_SHIP_EXTRA_SQUIRRELS (to anything)
#   for additional motivation
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_SHIP_EXTRA_SQUIRRELS
#
# Commands:
#   ship it - Display a motivation squirrel
#
# Author:
#   maddox

squirrels = [
  "http://shipitsquirrel.github.io/images/ship%20it%20squirrel.png",
  "http://i.imgur.com/DPVM1.png",
  "http://d2f8dzk2mhcqts.cloudfront.net/0772_PEW_Roundup/09_Squirrel.jpg",
  "http://www.cybersalt.org/images/funnypictures/s/supersquirrel.jpg",
  "http://www.zmescience.com/wp-content/uploads/2010/09/squirrel.jpg",
  "http://dl.dropbox.com/u/602885/github/sniper-squirrel.jpg",
  "http://1.bp.blogspot.com/_v0neUj-VDa4/TFBEbqFQcII/AAAAAAAAFBU/E8kPNmF1h1E/s640/squirrelbacca-thumb.jpg",
  "http://dl.dropbox.com/u/602885/github/soldier-squirrel.jpg",
  "http://dl.dropbox.com/u/602885/github/squirrelmobster.jpeg",
  "http://i.imgur.com/DEJF1g2.jpg",
  "http://i.imgur.com/h3N15C2.gif"
]

module.exports = (robot) ->

  # Enable a looser regex if environment variable is set
  if process.env.HUBOT_SHIP_EXTRA_SQUIRRELS
    regex = /ship(ping|z|s|ped)? it/i
  else
    regex = /ship it/i

  robot.hear regex, (msg) ->
    msg.send msg.random squirrels

  robot.hear /ship all the things/i, (msg) ->
    msg.send "http://i.imgur.com/DEJF1g2.jpg"
