class Item < ApplicationRecord
  belongs_to :product
  belongs_to :reservation, optional: true
  belongs_to :sell, optional: true
  enum estado: { disponible: 0, reservado: 1, vendido: 2 }
  validates :valor_venta, numericality: { greater_than: 0 }, allow_nil: true, if: :reservationAndSellAreNil?

  def reservationAndSellAreNil?
  	(reservation_id == nil && sell_id == nil) 
  end
end
	