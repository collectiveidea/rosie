# Listen for HTTP status codes and turn them into kittens!
#
module.exports = (robot) ->
  robot.hear /(?:\D|^)(\d{3})(?:\D|$)/i, (msg) ->
    status = parseInt(msg.match[1])
    if status in statuses
      msg.send "http://httpcats.herokuapp.com/#{status}.jpg"

statuses = [
  100, 101,
  200, 201, 202, 204, 206, 207,
  300, 301, 303, 304, 305, 307,
  400, 401, 402, 403, 404, 405, 406, 408, 409, 410, 411, 413, 414, 416, 417, 418, 422, 423, 424, 425, 426, 429, 431, 444, 450,
  500, 502, 503, 506, 507, 508, 509, 599
]
