class RemovePublicFromRooms < ActiveRecord::Migration
  def change
    remove_column :rooms, :public
  end
end
