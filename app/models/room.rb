class Room < ActiveRecord::Base
  belongs_to :user
  validates :name, :session_id, presence: true
end
