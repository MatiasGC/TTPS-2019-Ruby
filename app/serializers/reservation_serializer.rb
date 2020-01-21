class ReservationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :fecha_reserva
  belongs_to :client
  has_many :items, dependent: :destroy

  attributes :razon_social_cliente do |r|
  	r.client.razon_social
  end

  attributes :monto_total_reserva do |r|
  	r.items.map(&:valor_venta).sum
  end

end
