# Why not both? animated gif
#
module.exports = (robot) ->
  robot.hear /why not both?/i, (msg) ->
    msg.send "http://ak-hdl.buzzfed.com/static/2015-03/26/19/imagebuzz/webdr05/anigif_optimized-29941-1427413465-1.gif"
