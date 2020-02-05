class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :telefono
      t.belongs_to :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
