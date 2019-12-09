class CreateSells < ActiveRecord::Migration[6.0]
  def change
    create_table :sells do |t|
      t.timestamp :fecha_venta, null: false
      t.belongs_to :client, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :reservation, foreign_key: true

      t.timestamps
    end
  end
end
