module.exports = (robot) ->
    robot.router.get '/wholehog', (req, res) ->
        robot.messageRoom "226_gallery_testing@conf.hipchat.com", "https://tparnell.blob.core.windows.net/hubot/hqdefault.jpg"
