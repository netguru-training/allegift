class Gift < ActiveRecord::Base
  belongs_to :user


  def fetch_id_from_link
    parts = allegro_link.split('i');
    allegro_id = parts.last.split('.').first;
  end
end
