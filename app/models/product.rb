class Product < ApplicationRecord
	has_many :items, dependent: :destroy

	validates :descripcion, presence:true, length: { maximum: 200 }
	validates :detalle, presence:true, length: { maximum: 1500 }
	validates :monto, numericality: { greater_than: 0 }, presence:true
	validates :codigo_unico, presence:true, uniqueness: { case_sensitive: false }
	validates :cantidad_stock, presence: true
	validates :codigo_unico, format: {
		with: /\A[a-zA-z]{3}[\d]{6}\z/,
		message: "Debe contener 3 letras seguido de 6 numeros"
	}

end
