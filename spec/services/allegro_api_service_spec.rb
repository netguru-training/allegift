require 'rails_helper'

RSpec.describe AllegroApiService, :type => :service do
  describe 'test' do
    api = AllegroApiService.new
    sum = api.sum_prices([4839334838, 4839334840, 4870198905])
    puts sum
    sum = api.sum_prices([4839334840])
    puts sum
  end

end
