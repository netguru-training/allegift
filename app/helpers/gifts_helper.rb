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

  def getFormatedPrice(gift)
    number_to_currency(gift.price, unit: CURRENCY, format: "%n %u")
  end

end
