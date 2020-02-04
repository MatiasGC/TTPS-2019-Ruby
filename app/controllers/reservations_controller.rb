class ReservationsController < ApplicationController
	before_action :authenticate_user

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

		errors_messages = []
		if params[:productos]
			if params[:client_id].blank?
				errors_messages << "El cliente no existe"
			end
			@reservation = Reservation.create(client_id: params[:client_id], user_id: 5)
			can_do_reservation = true
			for prod in params[:productos]
				if not exist_product?(prod['codigo_unico'])
					errors_messages << "El producto con código #{prod['codigo_unico']} no existe"
					can_do_reservation = false
				end
				if not items_positive_quantity?(prod['cantidad_items'])
					errors_messages << "La cantidad de items del producto #{prod['codigo_unico']} debe ser positiva"
					can_do_reservation = false
				end
				if not the_product_has_stock?(prod)
					errors_messages << "El producto con código #{prod['codigo_unico']} no tiene stock suficiente"
					can_do_reservation = false
				end
			end

			# Si los parámetros son correctos se efectiviza la reserva
			if can_do_reservation
				for prod in params[:productos]
					@producto = Product.find_by(codigo_unico: prod['codigo_unico'])
					update_items(prod['cantidad_items'])
	
					update_stock_p(prod['cantidad_items'])					
				end
				render json: ReservationSerializer.new(@reservation, {fields: {reservation: [:fecha_reserva, :razon_social_cliente, :monto_total_reserva]}})					
			else
				@reservation.destroy
				render json: errors_messages, status: 404			
			end

		else
			render json: { :error => "Debe enviar al menos un producto" }, status: 400 
		end
		
	end

	private
	def exist_product?(a_unique_code)
		Product.find_by(codigo_unico: a_unique_code)
	end

	def items_positive_quantity?(items)
		items > 0
	end

	def the_product_has_stock?(a_product)
		Product.find_by(codigo_unico: a_product['codigo_unico']).cantidad_stock >= a_product['cantidad_items']
	end

	def update_items(items_quantity)
		i = (Item.where(estado:"disponible", product_id: @producto.id).limit(items_quantity)).update(estado: "reservado", reservation_id: @reservation.id)

	end

	def update_stock_p(items_quantity)
		@producto.update(cantidad_stock: @producto.cantidad_stock - items_quantity)
	end



	# PUT /reservas/:id/vender
	public
	def sell_reservation
		@reservation = Reservation.find_by(id: params[:id])
		if @reservation 
			if (@reservation.sell == nil)
				@sell = Sell.create(client_id: @reservation.client_id, user_id: @reservation.user_id, reservation_id: @reservation.id)
				add_items(@reservation, @sell)
				render status: 201
			else
				render json: { error: "La reserva ya tiene asignada una venta" }, status: 400
			end
		else
			render json: { error: "No existe la reserva" }, status: 404
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
		if @reservation
			if @reservation.sell == nil
				update_state_items(@reservation)
				@reservation.destroy
				render status: 200
			else
				render json: { error: "La reserva no se puede borrar porque ya tiene una venta asignada" }, status: 400 			
			end
		else
			render json: { error: "La reserva no existe" }, status: 404 

		end
	end

	private
	# Actualizo el estado de los items
	def update_state_items(a_reservation)
		a_reservation.items.map do |i|
			i.update(estado: "disponible")
			i.product.update(cantidad_stock: i.product.cantidad_stock + 1)
		end
	end
	# Actualizo el stock del producto a partir del nuevo item ahora disponible
	#def update_stock_product(an_item)
	#	an_item.product.update(cantidad_stock: an_item.product.cantidad_stock + 1)
	#end


	# GET /reservas/:id
	# Considero que La venta y los items se piden de forma separada en el llamado al endpoint. Es decir,
	# nunca al mismo tiempo
	public
	def show
		@reservation = Reservation.find_by(id: params[:id])
		if @reservation 
			options = {}
			sth_include = params[:include]
			if sth_include
				options[:include] = [sth_include]
				render json: ReservationSerializer.new(@reservation, options)
			else
				render json: ReservationSerializer.new(@reservation, {fields: {reservation: [:fecha_de_reserva, :monto_total_reserva]}})
			end
				
		else
			render json: { error: "No existe una reserva con ese id"}, status: 404  
			
		end
	end


  private

  def authenticate_user
    u = User.find_by(token: request.headers['Authorization'] )
    if (u.nil? || (not (u.token_created_at + 30.minutes > Time.now)))
      render json: { error: "Acceso denegado" }, status: 401
    end
  end

end