class Gift < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :allegro_link, presence: true
  validates :user_id, presence: true

  def fetch_id_from_link
    parts = allegro_link.split('i');
    self.allegro_id = parts.last.split('.').first;
  end
end
