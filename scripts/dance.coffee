images = [
  "http://gifsoup.com/webroot/animatedgifs/2966911_o.gif",
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
  "http://www.reactiongifs.com/wp-content/uploads/2012/09/horsing_around.gif",
  "http://24.media.tumblr.com/c9c393d9b69d5d60bcc3b15c0f5612bd/tumblr_mmgppxQ5BF1qdlh1io1_250.gif",
  "http://assets0.ordienetworks.com/images/GifGuide/dancing/sunny2.gif",
  "http://www.reactiongifs.com/wp-content/uploads/2013/11/blues-brothers.gif",
  "http://s3.amazonaws.com/rapgenius/ninja-rap.gif",
  "https://31.media.tumblr.com/1d98f053a16daafab702d1fb2cef42a0/tumblr_myfdzsR1bR1sh3xeyo1_500.gif",
  "https://38.media.tumblr.com/bfad620ce86dbf6d8fad0f6c79f4ef4d/tumblr_miqqpzPVQP1rw1he8o1_500.gif",
  "http://33.media.tumblr.com/ba0aae41226ccda0c1cf4d2d8cb802f6/tumblr_n9iq7sUBNf1sodwato1_500.gif",
  "http://i.imgur.com/eJa3pxn.gif"
]

# Now is the time on sprockets when we dance!
module.exports = (robot) ->
  robot.hear /\bdance\b/i, (msg) ->
    msg.send(msg.random(images))
