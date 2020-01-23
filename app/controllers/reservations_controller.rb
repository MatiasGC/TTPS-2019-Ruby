class ReservationsController < ApplicationController

	# GET /reservas
	def index	
		@reservations = Reservation.all
		reservationsWithOutSell = []		
		getReservationNoSold(reservationsWithOutSell)

		render json: ReservationSerializer.new(reservationsWithOutSell, {fields: {reservation: [:fecha_reserva, :razon_social_cliente, :monto_total_reserva]}})
	end

	private 
	#Recupera las reservas que no tienen asignada una venta
		def getReservationNoSold(array)
			@reservations.each do |r|
				if r.sell == nil
					array << r
				end
			end			
		end


	# POST /reservas
	public
	def create
		render json: params[:cantidad_de_productos]
		#if params[:codigo_unico] && params[:items] && params[:client_id] && params[:valor_venta]
			#@reservation = Reservation.create(client_id: params[:client_id].to_i, user_id: 1)
			#@product = Product.find_by(codigo_unico: params[:codigo_unico])
			#@reservation.products.create(codigo_unico: @product.codigo_unico, descripcion: @product.descripcion, detalle: @product.detalle, monto: @product.monto, cantidad_stock: @product.cantidad_stock)
			#@reservation.items.create(valor_venta: params[:valor_venta].to_d, product_id: @product.id, reservation_id: @reservation.id)
		#	render json: ReservationSerializer.new(Reservation.last, { fields: { reservation: [ :fecha_reserva, :user_that_reserved, :razon_social_cliente, :email_client, :products_reserved, :monto_total_reserva ] } } )		
		#end 		
	end

	# PUT /reservas/:id/vender
	def sell_reservation
		@reservation = Reservation.find_by(id: params[:id])
		if @reservation 
			if (@reservation.sell == nil)
				@sell = Sell.create(client_id: @reservation.client_id, user_id: @reservation.user_id, reservation_id: @reservation.id)
				add_items(@reservation, @sell)
				render json: :ok
			else
				render json: "La reserva ya tiene asignada una venta"
			end
		else
			render json: "No existe la reserva"
		end
	end

	private
	def add_items(a_reservation, a_sell)
		a_reservation.items.map do |i|
			i.update(estado: "vendido", sell_id: a_sell.id)
		end
	end

	# DELETE /reservas/:id
	public 
	def destroy
		@reservation = Reservation.find_by(id: params[:id])
		# Si existe esa reserva y no tiene asociada una venta
		if @reservation && @reservation.sell == nil
			update_state_items(@reservation)
			@reservation.destroy
			render json: :ok
		else
			render json: "La reserva no existe" if @reservation == nil
			render json: "La reserva no se puede borrar" if @reservation.sell != nil			
		end
	end

	private
	# Actualizo el estado de los items
	def update_state_items(a_reservation)
		a_reservation.items.map do |i|
			i.update(estado: "disponible")
			update_stock_product(i)
		end
	end
	# Actualizo el stock del producto a partir del nuevo item ahora disponible
	def update_stock_product(an_item)
		an_item.product.update(cantidad_stock: an_item.product.cantidad_stock + 1)
	end

end