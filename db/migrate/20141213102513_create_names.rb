class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.string :allegro_link
      t.integer :user_id

      t.timestamps
    end
  end
end
