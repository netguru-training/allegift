class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :create]
  def index
    @room = Room.new
    @rooms = Room.order("created_at DESC")
  end
  def create
    @room = Room.new(room_params)
    session = OpenTokService.new(@room).create_session

    if @room.save
      redirect_to room_path(@room), notice: "Now you can talk about your gift!"
    else
      render :index, error: "Can't create that room"
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
      params.require(:room).permit(:name, :session_id)
    end
end

