class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :name
      t.string :allegro_link
      t.integer :user_id

      t.timestamps
    end
  end
end
