require 'rails_helper'

RSpec.describe Gift, :type => :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :allegro_link }
    it { should validate_presence_of :user_id }
  end

end
