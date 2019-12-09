class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :estado
      t.decimal :valor_venta
      t.belongs_to :product, null: false, foreign_key: true
      t.belongs_to :reservation, foreign_key: true
      t.belongs_to :sell, foreign_key: true

      t.timestamps
    end
  end
end
