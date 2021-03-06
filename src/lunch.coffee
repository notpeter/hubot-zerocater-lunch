# Description:
#   Zerocater lunch
#
# Configuration (environment variable):
#   ZEROCATER_TAG='XZ89'
#
# Commands:
#   hubot lunch [today|tomorrow]
#
# Author
#   notpeter

console.log "ERROR: ZEROCATER_TAG environment variable unset." if !process.env.ZEROCATER_TAG

module.exports = (robot) ->
  robot.hear /^(?:lunch is here|lunch time|lunch$)/i, (msg) ->
    getLunch(msg)
  robot.respond /(?:what(?:\'s| is))?(?: for)? lunch\s?(today|tomorrow)?/i, (msg) ->
    getLunch(msg)

getLunch = (msg) ->
  day = if !msg.match[1] then 'today' else msg.match[1].trim().toLowerCase()
  now =  Math.floor(new Date().getTime() / 1000)
  now = now + 43200 if day == 'tomorrow'
  url = "https://api.zerocater.com/v3/companies/#{process.env.ZEROCATER_TAG}/meals"
  msg.http(url).get() (err, res, body) ->
    meals = JSON.parse(body)
    themeal = (m for m in meals when m.time > now - 14400)[0]
    details = "https://zerocater.com/m/#{process.env.ZEROCATER_TAG}/#{themeal.id}"
    msg.http("#{themeal.url}").get() (err, res, meal) ->
      m = JSON.parse(meal)
      choices = (item.name for item in m.items).join(', ')
      img = m.vendor_image_url.replace /upload/, "upload/c_fill,h_250,w_400"
      msg.send "Lunch #{day}: #{m.name} (from #{m.vendor_name})\n#{choices}\nDetails: #{details}\n#{img}"
