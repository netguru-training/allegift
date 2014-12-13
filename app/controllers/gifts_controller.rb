class GiftsController < ApplicationController
  def add
  end

  def index
  end

  def create
    self.gift = Gift.new(gift_params)

    if gift.save
      redirect_to gifts_index_path
    else
      render action: 'new'
    end
  end

  private
    def gift_params
      params.require(:gift).permit(:title)
    end
end
