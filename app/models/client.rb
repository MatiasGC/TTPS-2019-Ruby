class Client < ApplicationRecord
	has_many :reservations, dependent: :destroy
	has_many :sells, dependent: :destroy
	has_many :contacts, dependent: :destroy

	

	validates :email, format:{
		with: /\A([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})\z/,
		message: "No es un formato válido"
	}
	validates :email, uniqueness: { case_sensitive: false }

	enum condicion_iva: { IVA_Responsable_Inscripto: 1, 
		IVA_Responsable_no_Inscripto: 2, 
		IVA_no_Responsable: 3,
		IVA_Sujeto_Exento: 4,
		Consumidor_Final: 5,
		Responsable_Monotributo: 6,
		Sujeto_no_Categorizado: 7,
		Proveedor_del_Exterior: 8,
		Cliente_del_Exterior: 9,
		IVA_Liberado_Ley_Nº_19_640: 10,
		IVA_Responsable_Inscripto_Agente_de_Percepción: 11,
		Pequeño_Contribuyente_Eventual: 12,
		Monotributista_Social: 13,
		Pequeño_Contribuyente_Eventual_Social: 14 }

	validates :cuil_o_cuit, :razon_social, :condicion_iva, :email, presence: true
	validate :has_the_client_phone?

	def has_the_client_phone?
		if self.contacts.blank?
			errors.add(:contacts, "El cliente debe tener al menos un télefono")
		end
	end
end