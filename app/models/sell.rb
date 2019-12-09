class Sell < ApplicationRecord
	has_many :items, dependent: :destroy	
	has_many :products, through: :items
  belongs_to :client
  belongs_to :user
  belongs_to :reservation, optional: true

  validates :fecha_venta, presence: true
end
