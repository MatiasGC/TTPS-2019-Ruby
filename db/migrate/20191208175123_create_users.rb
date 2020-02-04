class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username, null:false
      t.string :password, null: false
      t.string :token
      t.datetime :token_created_at

      t.timestamps
    end
    add_index :users, :username
  end
end
