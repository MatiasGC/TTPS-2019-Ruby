class Item < ApplicationRecord
  belongs_to :product
  belongs_to :reservation, optional: true
  belongs_to :sell, optional: true
	
	validates :estado, inclusion: { in: %w(disponible reservado vendido), message: "%{value} no es un estado válido" }, presence: true
	validates :valor_venta, numericality: { only_integer: true }, allow_nil: true, on: :create
end
