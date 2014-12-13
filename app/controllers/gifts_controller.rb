class GiftsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :index, :create]

  def new
    @gift = Gift.new
  end

  def index
  end

  def create
    @gift = Gift.new(gift_params)

    @gift.fetch_id_from_link unless @gift

    @gift.user = current_user


    if @gift.save
      redirect_to gifts_path
    else
      render action: 'new'
    end
  end

  private
    def gift_params
      params.require(:gift).permit(:name, :allegro_link, :user_id)
    end
end
