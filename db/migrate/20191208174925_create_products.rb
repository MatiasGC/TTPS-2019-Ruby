class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :codigo_unico, null: false
      t.string :descripcion, null: false
      t.text :detalle, null: false
      t.decimal :monto, null: false
      t.integer :cantidad_stock, null: false

      t.timestamps
    end
    add_index :products, :codigo_unico
  end
end
