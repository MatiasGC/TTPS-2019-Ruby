class ReservationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :fecha_reserva
  belongs_to :client
  has_many :items, dependent: :destroy

  attributes :email_client do |r|
  	r.client.email
  end

  attributes :razon_social_cliente do |r|
  	r.client.razon_social
  end

  attributes :monto_total_reserva do |r|
  	r.items.map(&:valor_venta).sum
  end

  attributes :user_that_reserved do |r|
  	r.user.username
  end

  attributes :products_reserved do |r|
  	r.products
  end


end
