class Room < ActiveRecord::Base
  belongs_to :user
  validates :name, :sessionId, presence: true
end
