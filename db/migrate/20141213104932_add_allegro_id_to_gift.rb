class AddAllegroIdToGift < ActiveRecord::Migration
  def change
    add_column :gifts, :allegro_id, :string
  end
end
