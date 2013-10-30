# pew pew pew picture
#
module.exports = (robot) ->
  robot.respond /update self/, (msg) ->
    sys = require('sys')
    exec = require('child_process').exec
    puts = (error, stdout, stderr) -> msg.send(stdout)
    exec("git pull", puts)
    robot.shutdown()
    process.exit()
