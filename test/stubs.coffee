SkywebAdapter = require '../src/skyweb'
{EventEmitter} = require 'events'
{Brain} = require 'hubot'

beforeEach ->
  @stubs = {}
  @stubs.message =
    resourceType: 'NewMessage'
    resource:
      id: 123534
      messagetype: 'Text'
      from: 'sadadasd/contacts/8:some.skype.name'
      conversationLink: 'asdasd/conversations/19:someid'
      content: 'Hello World'
  # Hubot.Robot instance
  @stubs.robot = do ->
    robot = new EventEmitter
    robot.logger =
      info: ->
      debug: ->
    robot.received = []
    robot.receive = (message) ->
      @received.push message
    robot.brain = new Brain robot
    robot

  # Generate new adapter before every test
  @adapter = SkywebAdapter.use @stubs.robot
