class User < ActiveRecord::Base
  has_many :gifts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      generate_pass = SecureRandom.hex(8)
      user.password =  generate_pass
      user.password_confirmation = generate_pass
    end
  end
end
