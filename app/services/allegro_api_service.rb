class AllegroApiService

  def initialize
    setup_connection
  end

  def sum_prices_for_gifts(gifts)
    ids = getAllegroIds(gifts)
    return sum_prices(ids)
  end

  def sum_prices(ids)
    items = get_items(ids)
    sum = 0
    if items.kind_of?(Array)
      items.each do |item|
        puts item[:item_info][:it_buy_now_price]
        sum += item[:item_info][:it_buy_now_price].to_f
      end
    else
      sum += items[:item_info][:it_buy_now_price].to_f
    end
    return sum
  end

  private
    def setup_connection
      if [ENV['ALLEGRO_LOGIN'], ENV['ALLEGRO_HASH_PASSWORD'], ENV['ALLEGRO_KEY']].any? {|var| var==nil}
        raise "Missing allegro connection data"
      end

      @allegro_client = Savon.client(wsdl: 'https://webapi.allegro.pl/service.php?wsdl')
      
      localVersion = @allegro_client.call(:do_query_sys_status, message: { sysvar: 3, countryId: 1, webapiKey: '2a5a259b'})
      
      ver_key = localVersion.body[:do_query_sys_status_response][:ver_key]
      
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
      
      @session_handle = response.hash[:envelope][:body][:do_login_enc_response][:session_handle_part]
    end

    def getAllegroIds(gifts)
      ids = []
      gifts.each do |gift|
        ids.push(gift.allegro_id) if gift.allegro_id != nil
      end
      return ids
    end

    def get_items(ids)
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
      items = []
      if list_info != nil
        items = list_info[:item]
      end
      return items;
    end

end

