class GiftsController < ApplicationController

  def new
    @gift = Gift.new
  end

  def index
  end

  def create
    @gift = Gift.new(gift_params)

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
