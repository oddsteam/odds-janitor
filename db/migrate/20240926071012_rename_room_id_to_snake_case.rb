class RenameRoomIdToSnakeCase < ActiveRecord::Migration[7.1]
  def change
    rename_column :reserves, :roomId, :room_id
  end
end
