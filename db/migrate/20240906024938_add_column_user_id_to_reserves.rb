class AddColumnUserIdToReserves < ActiveRecord::Migration[7.1]
  def change
    add_column :reserves, :userId, :string
  end
end
