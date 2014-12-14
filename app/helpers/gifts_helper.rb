module GiftsHelper

  NO_DUE_DATE = '---'
  ENDED = 'ended'
  CURRENCY = 'zł'

  def time_until_end(gift)
    unless gift.due_date.nil?
      if gift.due_date - Time.now > 0
        return distance_of_time_in_words(Time.now, gift.due_date)
      else
        return ENDED
      end
    end
    return NO_DUE_DATE
  end

  def get_formated_price(gift)
    format_to_currency(gift.price)
  end

  def gift_prices_summary(gifts)
    total = gifts.sum("price")
    format_to_currency(total)
  end

  def format_to_currency(data)
    number_to_currency(data, unit: CURRENCY, format: "%n %u")
  end

end
