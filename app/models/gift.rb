class Gift < ActiveRecord::Base

  belongs_to :user
  validates :name, presence: true
  validates :allegro_link, presence: true
  validates :user_id, presence: true

  scope :has_not_santa, -> { where ("santa_id IS NULL") }
  scope :has_santa, -> { where ("santa_id IS NOT NULL") }


  def fetch_id_from_link
    parts = allegro_link.split('i');
    self.allegro_id = parts.last.split('.').first;
  end

end
end
