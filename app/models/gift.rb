class Gift < ActiveRecord::Base
  belongs_to :user
  belongs_to :importance
  validates :name, presence: true
  validates :allegro_link, presence: true
  validates :user_id, presence: true
  validates :importance, presence: true

  scope :has_not_santa, -> { where ("santa_id IS NULL") }
  scope :has_santa, -> { where ("santa_id IS NOT NULL") }
  scope :not_same_user, ->(id) { where("user_id != ?", id)}
  scope :same_user, ->(id) { where("user_id = ?", id)}

  def fetch_id_from_link
    parts = allegro_link.split('i');
    self.allegro_id = parts.last.split('.').first;
  end

end
