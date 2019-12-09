class Reservation < ApplicationRecord
	has_many :items, dependent: :destroy
	has_many :products, through: :items
	has_one :sell
  belongs_to :client
  belongs_to :user

  validates :fecha_reserva, presence: true
end
