module.exports = (robot) ->

  robot.hear /(Mike Croci | ChandraShaker Avvaru) have been added automatically as predefined branch/i, (res) ->
    robot.messageRoom "226_gallery_testing@conf.hipchat.com", "A Production pull request has been created #{process.env.PullRequestUrl}"
