require 'rails_helper'

RSpec.describe AllegroApiService, :type => :service do
  describe 'test' do
    ap = AllegroApiService.new
    ap.exec
  end

end
