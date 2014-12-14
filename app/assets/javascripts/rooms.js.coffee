$ ->
  sessionConnectedHandler = (event) ->
    subscribeToStreams event.streams
    session.publish()

  streamCreatedHandler = (event) ->
    subscribeToStreams event.streams

  subscribeToStreams = (streams) ->
    i = 0
    while i < streams.length
      stream = streams[i]
      console.log stream.connection.connectionId + "&" + session.connection.connectionId
      session.subscribe stream  unless stream.connection.connectionId is session.connection.connectionId
      i++

  apiKey = gon.api_key
  sessionId = gon.session_id
  token = gon.token
  session = TB.initSession(sessionId)
  session.addEventListener "sessionConnected", sessionConnectedHandler
  session.addEventListener "streamCreated", streamCreatedHandler
  session.connect apiKey, token
