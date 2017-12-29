module.exports = (robot) -> 
    robot.router.get '/livecheck', (req, res) ->
        res.send 'ok'