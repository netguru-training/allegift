class GiftsController < ApplicationController

  def new
    @gift = Gift.new
  end

  def index
    @gifts = Gift.all
  end

  def create
    @gift = Gift.new(gift_params)
    @gift.fetch_id_from_link

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
