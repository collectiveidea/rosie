# Name:
#   Nest
#
# Description:
#   Control your nest thermostat.
#
# Commands:
#   how (warm|cold) is it? - show the current temperature
#   it's warm - set the nest 1 degree Fahrenheit lower
#   it's cold - set the nest 1 degree Fahrenheit higher
#   hubot nest status - show the current nest setting
#   hubot nest set <temp> - set the nest to the specified temperature
#
# Lovingly ganked from m2mIO
#   https://github.com/m2mIO/2lemetry-hubot/blob/master/scripts/nest.coffee


# https://github.com/kasima/nesting
nest = require('nesting')

# Be sure to set the following environment variables
options =
  login:    process.env.NEST_LOGIN
  password: process.env.NEST_PASSWORD
  nest_id:  process.env.NEST_ID


changeTemperatureBy = (byF, msg) ->
  nest.fetchStatus (data) ->
    byC = (5 / 9) * byF
    current_temp = data.shared[options.nest_id].target_temperature
    new_temp = current_temp + byC
    msg.send "I've set the nest to " + nest.ctof(new_temp) + 'ºF for you.'
    nest.setTemperature options.nest_id, new_temp

changeTemperatureTo = (toF, msg) ->
  nest.fetchStatus (data) ->
    toC = nest.ftoc(toF)
    msg.send "I've set the nest to " + nest.ctof(toC) + 'ºF for you.'
    nest.setTemperature options.nest_id, toC


module.exports = (robot) ->
  robot.hear /how (warm|cold|hot) is it\??/i, (msg) ->
    nest.login options.login, options.password, (data) ->
      nest.fetchStatus (data) ->
        current_temp = data.shared[options.nest_id].current_temperature
        msg.send "The temperature is currently " + nest.ctof(current_temp) + "ºF."

  robot.hear /it'?s(.*)( really)? (hot|warm)|nest (down|cooler|colder)/i, (msg) ->
    msg.send("Decreasing the temperature...")
    nest.login options.login, options.password, (data) ->
      changeTemperatureBy -1, msg

  robot.hear /it'?s(.*) cold|nest (up|warmer)/i, (msg) ->
    msg.send("Increasing the temperature...")
    nest.login options.login, options.password, (data) ->
      changeTemperatureBy +1, msg

  robot.respond /(nest|n) set (\d{2}).*/i, (msg) ->
    nest.login options.login, options.password, (data) ->
      changeTemperatureTo msg.match[2], msg

  robot.respond /(nest|n) (status|st)/i, (msg) ->
    nest.login options.login, options.password, (data) ->
      nest.fetchStatus (data) ->
        current_target = data.shared[options.nest_id].target_temperature
        msg.send "The nest is currently set to " + nest.ctof(current_target) + "ºF."

  robot.router.get "/nest/status", (req, res) ->
    nest.login options.login, options.password, (data) ->
      nest.fetchStatus (data) ->
        current_target = data.shared[options.nest_id].target_temperature
        res.end "{\"current_temperature\": \"" + nest.ctof(current_target) + "\"}"
