class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: false do |t|
      t.string :user_id, primary_key: true
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
