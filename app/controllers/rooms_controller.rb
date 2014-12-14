class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :create]
  def index
    @room = Room.new
    @rooms = Room.where(public:  true).order("created_at DESC")
  end
  def create
    @room = Room.new(room_params)
    session = OpenTokService.new(@room).create_session

    if @room.save
      redirect_to room_path(@room)
    else
      render :index
    end
  end

  def show
    @room = Room.find(params[:id])
    token = OpenTokService.new(@room).generate_token
    gon.token =  token
    gon.api_key = ENV["OPENTOK_API_KEY"]
    gon.session_id = @room.session_id
  end

  private
    def room_params
      params.require(:room).permit(:name, :session_id, :public)
    end
end

