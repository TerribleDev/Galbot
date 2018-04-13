module.exports = (robot) ->
    robot.router.get '/wholehog', (req, res) ->
        robot.messageRoom "226_gallery_testing@conf.hipchat.com", "https://tparnell.blob.core.windows.net/hubot/hqdefault.jpg"
        res.send 'OK'
    robot.respond /whole hog/i, (res) ->
        res.send "https://tparnell.blob.core.windows.net/hubot/hqdefault.jpg"
