images = [
  "http://gifsoup.com/webroot/animatedgifs/2966911_o.gif",
  "http://i557.photobucket.com/albums/ss15/edibility/sprocketsdance-1.gif",
  "http://gifs.gifbin.com/3282yu7074.gif",
  "http://images2.fanpop.com/images/photos/3800000/Animated-GIFs-flight-of-the-conchords-3809604-449-328.gif",
  "http://assets0.ordienetworks.com/images/GifGuide/dancing/1tumblr_lgp6q5NhE21qcjtu8o1_500.gif",
  "http://tullysportsblog.files.wordpress.com/2012/11/michelle-jenneke-dance.gif"
  "http://assets0.ordienetworks.com/images/GifGuide/dancing/280sw007883.gif",
  "http://assets0.ordienetworks.com/images/GifGuide/dancing/30075yu908.gif",
  "http://assets0.ordienetworks.com/images/GifGuide/dancing/163563561.gif",
  "http://assets0.ordienetworks.com/images/GifGuide/dancing/bale2.gif",
  "http://assets0.ordienetworks.com/images/GifGuide/dancing/flash6.gif",
  "http://assets0.ordienetworks.com/images/GifGuide/dancing/pr2.gif",
  "http://assets0.ordienetworks.com/images/GifGuide/dancing/smith4.gif",
  "http://assets0.ordienetworks.com/images/GifGuide/dancing/tumblr_lhrzztdSKy1qb7hapo1_500.gif",
  "http://assets0.ordienetworks.com/images/GifGuide/dancing/tumblr_lj3t79ToKm1qchk28.gif",
  "http://www.reactiongifs.com/wp-content/uploads/2012/12/thug-life.gif",
  "http://www.reactiongifs.com/wp-content/uploads/2013/02/EOD.gif",
  "http://www.reactiongifs.com/wp-content/uploads/2013/02/anigif_enhanced-buzz-31994-1359473038-6.gif",
  "http://www.reactiongifs.com/wp-content/uploads/2012/10/romney.gif",
  "http://www.reactiongifs.com/wp-content/uploads/2012/09/horsing_around.gif"
]

# Now is the time on sprockets when we dance!
module.exports = (robot) ->
  robot.hear /dance/i, (msg) ->
    msg.send(msg.random(images))
