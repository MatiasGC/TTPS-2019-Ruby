class Client < ApplicationRecord
	has_many :reservations, dependent: :destroy
	has_many :sells, dependent: :destroy
	validates :cuil_o_cuit, :razon_social, :condicion_iva, :email, :telefono_1, presence: true
	validates :telefono_1, numericality: { only_integer: true }
	validates :telefono_2, numericality: { only_integer: true }, allow_nil: true
	validates :email, format:{
		with: /\A([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})\z/,
		message: "No es un formato válido"
	}
	validates :email, uniqueness: { case_sensitive: false }
	validates :condicion_iva, inclusion: { 
		in: ["IVA Responsable Inscripto", 
			 "IVA Responsable no Inscripto", 
			 "IVA no Responsable", 
			 "IVA Sujeto Exento",
			 "Consumidor Final",
			 "Responsable Monotributo",
			 "Sujeto no Categorizado",
			 "Proveedor del Exterior",
			 "Cliente del Exterior",
			 "IVA Liberado – Ley Nº 19.640",
			 "IVA Responsable Inscripto – Agente de Percepción",
			 "Pequeño Contribuyente Eventual",
			 "Monotributista Social",
			 "Pequeño Contribuyente Eventual Social"], 
			  message: "%{value} no es una condición válida" }
end