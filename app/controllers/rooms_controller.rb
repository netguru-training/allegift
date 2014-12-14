class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :create]
  def index
    @room = Room.new
    @rooms = Room.where(public:  true).order("created_at DESC")
  end
  def create
    @room = Room.new(room_params)
    @token = OpenTokService.new(@room).generate_token
    if @room.save
      redirect_to room_path(@room)
    else
      render :index
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  private
    def room_params
      params.require(:room).permit(:name, :session_id, :public)
    end
end

