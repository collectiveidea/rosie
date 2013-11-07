# Description
#   Bugs people to get Gravatars if they don't have them, as they join
#
# Author:
#   laserlemon

module.exports = (robot) ->
  robot.enter (msg) ->
    user = msg.message.user

    robot.adapter.bot.User user, (_, userData) ->
      if userData.user
        email = userData.user.email_address
        hash = CryptoJS.MD5((new String(email)).toString().toLowerCase())
        url = "http://www.gravatar.com/avatar/#{hash}?d=404"

        robot.http(url).get() (err, res, body) ->
          if err
            msg.send "#{user.name}: You should get a Gravatar! http://gravatar.com"
