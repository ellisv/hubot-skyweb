{TextMessage} = require 'hubot'

chai = require 'chai'
expect = chai.expect

describe 'Receive skyweb messages', ->
  it 'Should receive proper TextMessage', ->
    @adapter.receiveSkywebMessages [@stubs.message]
    receivedMessage = @adapter.robot.received.pop()
    expect(receivedMessage).to.be.an.instanceof TextMessage

  it 'Should not receive same message more than once', ->
    @adapter.receiveSkywebMessages [@stubs.message, @stubs.message]
    expect(@adapter.robot.received).to.have.length 1

  it 'Should not receive any messages if sent from same username', ->
    @adapter.username = 'some.skype.name'
    @adapter.receiveSkywebMessages [@stubs.message]
    expect(@adapter.robot.received).to.have.length 0

  it 'Should throw error when unable to parse user id', ->
    @stubs.message.resource.from = 'somecrazystring'
    expect =>
      @adapter.receiveSkywebMessages [@stubs.message]
    .to.throw Error
