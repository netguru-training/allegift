class ChangeTypeOfAllegroId < ActiveRecord::Migration

  def self.up
    change_column :gifts, :allegro_id, :string if Gift.column_types['allegro_id'].type == :integer
  end

  def self.down
    change_column :gifts, :allegro_id, :integer if Gift.column_types['allegro_id'].type == :string
  end

end
