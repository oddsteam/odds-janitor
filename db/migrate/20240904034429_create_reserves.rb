class CreateReserves < ActiveRecord::Migration[7.1]
  def change
    create_table :reserves do |t|
      t.string :date
      t.string :start_timer
      t.string :end_timer
      t.string :note

      t.timestamps
    end
  end
end
