Skyweb = require 'skyweb'

{Adapter, TextMessage} = require 'hubot'

class SkywebAdapter extends Adapter

  constructor: (@robot, @skyweb) ->
    @lastMessageIds = Array.apply null, length: 20

  send: (envelope, strings...) ->
    @skyweb.sendMessage envelope.user.room, str for str in strings

  reply: (envelope, strings...) ->
    @send envelope, strings.map((str) -> "@#{envelope.user.name}: #{str}")...

  run: ->
    username = process.env.HUBOT_SKYPE_USERNAME
    throw new Error 'Provide username in HUBOT_SKYPE_USERNAME' unless username
    password = process.env.HUBOT_SKYPE_PASSWORD
    throw new Error 'Provide password in HUBOT_SKYPE_PASSWORD' unless password

    @skyweb.login(username, password).then =>
      @robot.logger.debug "Successfully logged in to Skype as #{username}"
      @emit 'connected'

    @skyweb.messagesCallback = (messages) =>
      for message in messages
        continue if message.resourceType is not 'NewMessage' or
                    message.resource?.messagetype not in ['Text', 'RichText'] or
                    message.resource.id in @lastMessageIds

        @lastMessageIds.shift
        @lastMessageIds.push message.resource.id

        userId = message.resource.from.match(/contacts\/\d+:(.+)$/)[1]

        throw new Error 'Unable to parse user id' if userId is null
        continue if userId is username

        room = message.resource.conversationLink.match(/conversations\/(\d+:.+)$/)[1]
        user = @robot.brain.userForId userId, room: room

        # TODO: Implement EnterMessage, LeaveMessage and others.
        @receive new TextMessage user, message.resource.content, message.resource.id

exports.use = (robot) ->
  new SkywebAdapter robot, new Skyweb
