# Description:
#   Example scripts for you to examine and try out.
# Dependencies:
#   "cron": "0.3.3",
#   "time": "0.8.2"
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md
#
# Commands:
#   hubot q add <UserName> - add user to rotation!
#   hubot q remove <UserName> - remove user to rotation!
#   hubot q next - move to next
#   hubot q current - move to next

TIMEZONE = "America/New_York"
TRIGGER = '0 0 9 * * 2-6' # M-F 5am
ROOM = "226_gallery@conf.hipchat.com"
cronJob = require('cron').CronJob

module.exports = (robot) ->


  next = () ->
   rotation = robot.brain.get('rotation')
   current = robot.brain.get('current')
   if current == null || typeof current == "undefined"
    current = roation[0]
   else
    location = rotation.indexOf current
   if location < 0 || location == (rotation.length - 1)
    current = rotation[0]
   else
    current = rotation[location + 1]
   robot.brain.set('current', current)
   robot.messageRoom ROOM, "#{current} is now Queue boss"

  update = new cronJob TRIGGER,
                  ->
                    next()
                  null
                  true
                  TIMEZONE

  robot.respond /q add (.*)/i, (res) ->
   rotation = robot.brain.get('rotation')
   if rotation == null || typeof rotation == "undefined"?
    rotation = []
   rotation.push res.match[1]
   robot.brain.set "rotation", rotation

  robot.respond /q remove (.*)/i, (res) ->
   rotation = robot.brain.get('rotation')
   current = robot.brain.get('current')
   if(current == res.match[1])
    res.send "User is currently on rotation"
   else
    rotation = rotation.filter (word) -> current
   robot.brain.set('rotation', rotation)

  robot.respond /q list/i, (res) ->
    rotation = robot.brain.get('rotation')
    res.send rotation.join('\n')
  robot.respond /queueboss/i, (res) ->
    res.send robot.brain.get('current')

  robot.respond /q next/i, (res) ->
   next()


  # robot.hear /badger/i, (res) ->
  #   res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"
  #
  # robot.respond /open the (.*) doors/i, (res) ->
  #   doorType = res.match[1]
  #   if doorType is "pod bay"
  #     res.reply "I'm afraid I can't let you do that."
  #   else
  #     res.reply "Opening #{doorType} doors"
  #
  # robot.hear /I like pie/i, (res) ->
  #   res.emote "makes a freshly baked pie"
  #
  # lulz = ['lol', 'rofl', 'lmao']
  #
  # robot.respond /lulz/i, (res) ->
  #   res.send res.random lulz
  #
  # robot.topic (res) ->
  #   res.send "#{res.message.text}? That's a Paddlin'"
  #
  #
  # enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
  # leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  #
  # robot.enter (res) ->
  #   res.send res.random enterReplies
  # robot.leave (res) ->
  #   res.send res.random leaveReplies
  #
  # answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING
  #
  # robot.respond /what is the answer to the ultimate question of life/, (res) ->
  #   unless answer?
  #     res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
  #     return
  #   res.send "#{answer}, but what is the question?"
  #
  # robot.respond /you are a little slow/, (res) ->
  #   setTimeout () ->
  #     res.send "Who you calling 'slow'?"
  #   , 60 * 1000
  #
  # annoyIntervalId = null
  #
  # robot.respond /annoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #     return
  #
  #   res.send "Hey, want to hear the most annoying sound in the world?"
  #   annoyIntervalId = setInterval () ->
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #   , 1000
  #
  # robot.respond /unannoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "GUYS, GUYS, GUYS!"
  #     clearInterval(annoyIntervalId)
  #     annoyIntervalId = null
  #   else
  #     res.send "Not annoying you right now, am I?"
  #
  #
  # robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
  #   room   = req.params.room
  #   data   = JSON.parse req.body.payload
  #   secret = data.secret
  #
  #   robot.messageRoom room, "I have a secret: #{secret}"
  #
  #   res.send 'OK'
  #
  # robot.error (err, res) ->
  #   robot.logger.error "DOES NOT COMPUTE"
  #
  #   if res?
  #     res.reply "DOES NOT COMPUTE"
  #
  # robot.respond /have a soda/i, (res) ->
  #   # Get number of sodas had (coerced to a number).
  #   sodasHad = robot.brain.get('totalSodas') * 1 or 0
  #
  #   if sodasHad > 4
  #     res.reply "I'm too fizzy.."
  #
  #   else
  #     res.reply 'Sure!'
  #
  #     robot.brain.set 'totalSodas', sodasHad+1
  #
  # robot.respond /sleep it off/i, (res) ->
  #   robot.brain.set 'totalSodas', 0
  #   res.reply 'zzzzz'
