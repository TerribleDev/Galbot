module.exports = (robot) ->

  robot.router.post "/masterPr", (req, res) ->
    robot.messageRoom "226_gallery_testing@conf.hipchat.com", "A Production pull request has been created"
