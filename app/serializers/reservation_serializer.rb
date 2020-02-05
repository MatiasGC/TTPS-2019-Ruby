class ReservationSerializer
  include FastJsonapi::ObjectSerializer
  
  has_many :items, dependent: :destroy
  has_one :sell

  attributes :fecha_de_reserva do |r|
    r.fecha_reserva
  end

  attributes :email_cliente do |r|
  	r.client.email
  end

  attributes :items_reserved do |r|
    r.items
  end

  attributes :sell do |r|
    r.sell
  end

  attributes :razon_social_cliente do |r|
  	r.client.razon_social
  end

  attributes :monto_total_reserva do |r|
  	r.items.map(&:valor_venta).sum
  end

  attributes :usuario_que_reservo do |r|
  	r.user.username
  end

  #attributes :productos_reservados do |r|
  #	r.products
  #end


end
