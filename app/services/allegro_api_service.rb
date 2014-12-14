class AllegroApiService

  def initialize
    setup_connection
  end

  def sum_prices_for_gifts(gifts)
    ids = get_allegro_ids(gifts)
    return sum_prices(ids)
  end

  def sum_prices(ids)
    items = get_items(ids)
    sum = 0
    items.each do |item|
      if item[:item_info][:it_buy_now_active].to_i==1
        sum += item[:item_info][:it_buy_now_price].to_f
      else
        sum += item[:item_info][:it_price].to_f
      end
    end
    return sum
  end

  def get_due_date(id)
    items = get_items(id)
    due_date_timestamp = items.first[:item_info][:it_ending_time].to_f
    return Time.at(due_date_timestamp).to_datetime
  end

  def get_quantity(id)
    items = get_items(id)
    items.first[:item_info][:it_quantity].to_i
  end

  def get_name(id)
    get_items(id).first[:item_info][:it_name]
  end

  private
    def setup_connection
      validate_connection_data
      @allegro_client = Savon.client(wsdl: 'https://webapi.allegro.pl/service.php?wsdl')
      ver_key = get_ver_key
      response = call_do_login(ver_key)
      @session_handle = response.hash[:envelope][:body][:do_login_enc_response][:session_handle_part]
    end

    def validate_connection_data
      if [ENV['ALLEGRO_LOGIN'], ENV['ALLEGRO_HASH_PASSWORD'], ENV['ALLEGRO_KEY']].any? {|var| var==nil}
        raise "Missing allegro connection data"
      end
    end

    def get_ver_key
      local_version = @allegro_client.call(
        :do_query_sys_status, 
        message: { 
          sysvar: 3, 
          countryId: 1, 
          webapiKey: '2a5a259b'
        }
      )
      ver_key = local_version.body[:do_query_sys_status_response][:ver_key]
    end

    def call_do_login(ver_key)
      response = @allegro_client.call(
        :do_login_enc, 
        message: {
          userLogin: ENV['ALLEGRO_LOGIN'],
          userHashPassword: ENV['ALLEGRO_HASH_PASSWORD'],
          countryCode: 1,
          webapiKey: ENV['ALLEGRO_KEY'],
          localVersion: ver_key
        }
      )
    end

    def get_allegro_ids(gifts)
      ids = []
      gifts.each do |gift|
        ids << gift.allegro_id unless gift.allegro_id.nil?
      end
    end

    def get_items(ids)
      unless @items.nil?
        return @items
      end
      call_result=@allegro_client.call(
        :do_get_items_info,
        message: {
          session_handle: @session_handle,
          itemsIdArray: {
            item: ids
          }
        }
      )
      list_info = call_result.body[:do_get_items_info_response][:array_item_list_info]

      @items = list_info[:item] ? list_info[:item] : []

      if @items.kind_of?(Hash)
        @items = [@items]
      end

      return @items;
    end

end

