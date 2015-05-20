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

update = new cronJob trigger,
                ->
                  next()
                null
                true
                TIMEZONE

robot.respond /q add (.*)/i, (res) ->
 rotation = robot.brain.get('rotation')
 if rotation == null || typeof rotation == "undefined"?
  rotation = []
 rotation.push res.match[0]
 robot.brain.set "rotation", rotation

robot.respond /q remove (.*)/i, res() ->
 rotation = robot.brain.get('rotation')
 current = robot.brain.get('current')
 if(current == res.match[0])
  res.send "User is currently on rotation"
 else
  rotation = rotation.filter (word) -> current
 robot.brain.set('rotation', rotation)

robot.respond /q next/i, (res) ->
 next()
