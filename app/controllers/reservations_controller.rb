class ReservationsController < ApplicationController

	# GET /reservas
	def index	
		@reservations = Reservation.all
		reservationsWithOutSell = []		
		getReservationNoSold(reservationsWithOutSell)

		render json: ReservationSerializer.new(reservationsWithOutSell, {fields: {reservation: [:fecha_reserva, :razon_social_cliente, :monto_total_reserva]}})
	end

	private 
		def getReservationNoSold(array)
			@reservations.each do |r|
				if r.sell == nil
					array << r
				end
			end			
		end

	# INVESTIGAR CÓMO PODER SOLUCIONARLO

	# POST /reservas
	public
	def create
		reservations.create()
	end
end