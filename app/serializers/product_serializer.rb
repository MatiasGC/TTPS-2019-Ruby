class ProductSerializer
  include FastJsonapi::ObjectSerializer
  #set_type :products

  attributes :codigo_unico, :descripcion, :detalle, :monto, :cantidad_stock
  has_many :items

  #attributes :valor_mas_alto_item_vendido do |p| 
  #	p.items.map(&:valor_venta).max  
  #end
end
