class GiftsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :index, :create]

  def new
    @gift = Gift.new
  end

  def index
    if params[:search_query]
      search_query = "%#{params[:search_query]}%"
      @gifts = Gift.has_not_santa.not_same_user(current_user.id)
                   .where("name like ? or allegro_link like ?", search_query, search_query)
                   .paginate( :page => params[:page], per_page: 10)
    else
      @gifts = Gift.has_not_santa.not_same_user(current_user.id)
                   .paginate(page: params[:page], per_page: 10)
    end
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
    @gifts = Gift.has_santa
  end

  def wish_list
    @gifts = Gift.same_user(current_user.id)
  end

  private
    def gift_params
      params.require(:gift).permit(:name, :allegro_link, :user_id)
    end


end
