class AddSantaIdToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :santa_id, :integer
  end
end
