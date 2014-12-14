class AddQuantityToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :quantity, :integer
  end
end
