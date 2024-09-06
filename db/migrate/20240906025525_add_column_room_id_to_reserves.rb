class AddColumnRoomIdToReserves < ActiveRecord::Migration[7.1]
  def change
    add_column :reserves, :roomId, :string
  end
end
