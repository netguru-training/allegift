class GiftsController < ApplicationController
  respond_to :html, :xml, :json

  before_action :authenticate_user!, only: [:new, :index, :create]
  before_action :prepare_gift, only: [:create]

  def new
    @gift = Gift.new
  end

  def index
  end

  def live_search
    if params[:search_query]
      search_query = "%#{params[:search_query]}%"
      @gifts = Gift.has_not_santa.not_same_user(current_user.id)
                   .where("name like ? or allegro_link like ?", search_query, search_query)
                   .includes(:importance, :user)
    else
      @gifts = Gift.has_not_santa.not_same_user(current_user.id)
                   .includes(:importance, :user)
    end
    render :json => @gifts.to_json(include: { user:{ only: :name }, importance:{ only: :name } } )
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

    render :json => chosen_gift.to_json
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

    def prepare_gift
      @gift = Gift.new(gift_params)
      @gift.fetch_id_from_link if @gift
      set_data_from_allegro
    end

    def set_data_from_allegro
      api = AllegroApiService.new
      @gift.due_date = api.get_due_date(@gift.allegro_id)
      @gift.price = api.sum_prices([@gift.allegro_id])
      @gift.name = api.get_name(@gift.allegro_id)
      @gift.quantity = api.get_quantity(@gift.allegro_id)
    end

end
