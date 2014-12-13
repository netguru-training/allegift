class GiftsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :index, :create]

  def new
    @gift = Gift.new
  end

  def index
    @gifts = Gift.where("santa_id IS NULL").paginate(page: params[:page], per_page: 10)
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

  def register_santa

    chosen_gift = Gift.find(params[:gift_id])
    chosen_gift.santa_id = current_user.id
    chosen_gift.save

    redirect_to gifts_path
  end

  def santa_list
    @gifts = Gift.where("santa_id IS NOT NULL")
  end

  private
    def gift_params
      params.require(:gift).permit(:name, :allegro_link, :user_id)
    end


end
