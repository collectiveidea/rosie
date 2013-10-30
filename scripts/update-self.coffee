# Get Rosie to update herself
#
module.exports = (robot) ->
  robot.respond /update self/, (msg) ->
    sys = require('sys')
    exec = require('child_process').exec
    puts = (error, stdout, stderr) ->
      if error?
        msg.send(error)
      if stdout?
        msg.send(stdout)
      if stderr
        msg.send(stderr)
    exec("git pull", puts)
    robot.shutdown()
    process.exit()
