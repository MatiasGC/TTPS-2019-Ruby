class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :cuil_o_cuit, null: false
      t.string :razon_social, null: false
      t.string :condicion_iva, null: false
      t.string :email, null: false
      t.integer :telefono_1, null: false
      t.integer :telefono_2

      t.timestamps
    end
  end
end
