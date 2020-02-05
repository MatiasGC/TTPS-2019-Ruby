class SellSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :client
  has_many :items, dependent: :destroy

  attributes :fecha_de_venta do |s|
    s.fecha_venta
  end

  attributes :razon_social_cliente do |s|
    s.client.razon_social
  end

  attributes :items_sold do |s|
    s.items
  end

  attributes :monto_total_venta do |s|
    s.items.map(&:valor_venta).sum
  end

end
