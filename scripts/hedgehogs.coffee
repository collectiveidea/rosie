# Description:
#   Hedgehogs!
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot hedgehog me - A randomly selected kitten
#   hubot hedgehog bomb me <number> - Many many kittens!

hedgehogImages = [
  "https://media.tenor.com/images/76d9acb1f1d7493db9f71aa91a66097e/tenor.gif",
  "https://i1.wp.com/cutesypooh.com/wp-content/uploads/2017/03/2Ioov5x.gif",
  "https://media.giphy.com/media/BKLKoUfdBeRG0/giphy.gif",
  "https://assets.rbl.ms/10624646/980x.gif",
  "https://media.giphy.com/media/DIJvB2WPCFsm4/giphy.gif",
  "https://media.giphy.com/media/F7Jm8U4J8SZMY/giphy.gif",
  "https://assets-auto.rbl.ms/353b2f6ae2b6c1a3eba793b396e6f161d832bc9ebc68604b18608416c183cc17",
  "http://i0.kym-cdn.com/photos/images/original/000/970/556/772.gif",
  "http://iruntheinternet.com/lulzdump/images/hedgehog-sonic-sonic-movie-IRL-real-hedgehog-collecting-rings-1429748059k.gif"
]

module.exports = (robot) ->
  robot.hear /hedgehog?(?: me)?$/i, (msg) ->
    msg.send hedgehogMe()

  robot.hear /hedgehog bomb(?: me)?( \d+)?$/i, (msg) ->
    hedgehogs = msg.match[1] || 5
    msg.send(hedgehogMe()) for i in [1..hedgehogs]

  robot.hear /emergency hedgehog?/i, (msg) ->
    hedgehogs = msg.match[1] || 5
    msg.send(hedgehogMe()) for i in [1..hedgehogs]

hedgehogMe = () ->
  rand = Math.floor(Math.random() * Math.floor(hedgehogImages.length))
  return hedgehogIMages[rand]
