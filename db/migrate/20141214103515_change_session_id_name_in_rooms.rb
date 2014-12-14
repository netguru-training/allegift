class ChangeSessionIdNameInRooms < ActiveRecord::Migration
  def change
    rename_column :rooms, :sessionId, :session_id
  end
end
