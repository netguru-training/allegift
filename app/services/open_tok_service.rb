class OpenTokService

  def initialize(room)
    @room = room
    @opentok = OpenTok::OpenTok.new ENV["OPENTOK_API_KEY"], ENV["OPENTOK_API_SECRET"]
  end

  def generate_token
    create_session unless @room.session_id.present?
    @opentok.generate_token @room.session_id
  end

  def create_session
    tok_session = @opentok.create_session
    @room.update_attributes session_id: tok_session.session_id
  end

end
