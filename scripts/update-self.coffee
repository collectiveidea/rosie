# Get Rosie to update herself
#
module.exports = (robot) ->
  robot.respond /update self/, (msg) ->
    exec = require('child_process').exec
    exec "/usr/bin/git pull", (error, stdout, stderr) ->
      if stdout?
        msg.send('stdout: ' + stdout)
      if stderr?
        msg.send('stderr: ' + stderr)
      if error?
        msg.send('exec error: ' + error)

      robot.shutdown()
      process.exit()
