class AddDueDateToGift < ActiveRecord::Migration
  def change
    add_column :gifts, :due_date, :datetime
  end
end
