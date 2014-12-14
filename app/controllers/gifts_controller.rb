class GiftsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :index, :create]
  before_action :prepare_gift, only: [:create]

  def new
    @gift = Gift.new
  end

  def index
    if params[:search_query]
      search_query = "%#{params[:search_query]}%"
      @gifts = Gift.has_not_santa.not_same_user(current_user.id)
                   .where("name ilike ? or allegro_link ilike ?", search_query, search_query)
                   .includes(:importance, :user)
                   .paginate( :page => params[:page], per_page: 10)
      @title = "Search with query: '#{params[:search_query]}'"
    else
      @gifts = Gift.has_not_santa.not_same_user(current_user.id)
                   .includes(:importance, :user)
                   .paginate(page: params[:page], per_page: 10)
      @title = 'All gifts'
    end
  end

  def live_search
    if params[:search_query]
      search_query = "%#{params[:search_query]}%"
      @gifts = Gift.has_not_santa.not_same_user(current_user.id)
                   .where("name like ? or allegro_link like ?", search_query, search_query)
                   .paginate( :page => params[:page], per_page: 10)

    else
      @gifts = Gift.has_not_santa.not_same_user(current_user.id)
    end
    render json: @gifts
  end

  def create

    @gift.user = current_user

    if @gift.save
      redirect_to gifts_path, notice: "Gift created successfully."
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
      params.require(:gift).permit(:name, :allegro_link, :user_id, :importance_id)
    end

    def set_price(gift)
      api = AllegroApiService.new
      gift.price = api.sum_prices([gift.allegro_id])
    end

    def prepare_gift
      @gift = Gift.new(gift_params)

      @gift.fetch_id_from_link if @gift
      set_price(@gift)
    end

end
