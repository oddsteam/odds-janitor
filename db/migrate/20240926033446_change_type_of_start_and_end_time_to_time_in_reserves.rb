class ChangeTypeOfStartAndEndTimeToTimeInReserves < ActiveRecord::Migration[7.1]
  def up
    remove_column :reserves, :start_timer
    remove_column :reserves, :end_timer
    add_column :reserves, :start_timer, :time
    add_column :reserves, :end_timer, :time
  end
  def down
    remove_column :reserves, :end_timer
    remove_column :reserves, :start_timer
    add_column :reserves, :end_timer, :string
    add_column :reserves, :start_timer, :string
  end
end
