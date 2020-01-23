class ProductSerializer
  include FastJsonapi::ObjectSerializer
  #set_type :products

  attributes :codigo_unico, :descripcion, :detalle, :monto, :cantidad_stock
  has_many :items

  attributes :estado_y_valor_venta_item do |p|
  	p.items.map { |i| [ i.estado, i.valor_venta ] }
  end

end
