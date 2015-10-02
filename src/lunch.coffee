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
  url = "https://zerocater.com/api/v3/companies/#{process.env.ZEROCATER_TAG}/meals"
  msg.http(url).get() (err, res, body) ->
    meals = JSON.parse(body)
    meal_id = (m.id for m in meals when m.time > now - 7200)[0]
    msg.http("#{url}/#{meal_id}").get() (err, res, meal) ->
      m = JSON.parse(meal)
      choices = (item.name for item in m.items).join(', ')
      msg.send "Lunch #{day}: #{m.name} (from #{m.vendor_name})\n#{choices}\n#{m.vendor_image_url}"
