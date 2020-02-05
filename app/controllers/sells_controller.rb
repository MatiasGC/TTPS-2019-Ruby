class SellsController < ApplicationController
	before_action :authenticate_user

	# GET /ventas
	def index
		@sells = Sell.where(user_id: @u.id)
		render json: SellSerializer.new(@sells, { fields: { sell: [ :fecha_venta, :razon_social_cliente, :monto_total_venta ] } })
	end

	# GET /ventas/:id
	def show
		@sell = Sell.find_by(id: params[:id])
		if @sell && (@sell.user.username == @u.username)
			options = {}
			sth_include = params[:include]
			if sth_include
				options[:include] = [sth_include]
				render json: SellSerializer.new(@sell, options), status: 200
			else
				render json: SellSerializer.new(@sell, { fields: { sell: [ :fecha_venta, :razon_social_cliente, :monto_total_venta ] } }), status: 200			
			end
		else
				render json: { error: "La venta no existe o vos no registraste la venta" }, status: 404
		end
	end

	# POST /ventas
	def create

		errors_messages = []
		if params[:productos]
			if params[:client_id].blank?
				errors_messages << "El cliente no existe"
			end
			@sell = Sell.create(client_id: params[:client_id], user_id: @u.id)
			can_do_sell = true
			for prod in params[:productos]
				if not exist_product?(prod['codigo_unico'])
					errors_messages << "El producto con código #{prod['codigo_unico']} no existe"
					can_do_sell = false
				end
				if not items_positive_quantity?(prod['cantidad_items'])
					errors_messages << "La cantidad de items del producto #{prod['codigo_unico']} debe ser positiva"
					can_do_sell = false
				end
				if not the_product_has_stock?(prod)
					errors_messages << "El producto con código #{prod['codigo_unico']} no tiene stock suficiente"
					can_do_sell = false
				end
			end

			# Si los parámetros son correctos se efectiviza la venta
			if can_do_sell
				for prod in params[:productos]
					@producto = Product.find_by(codigo_unico: prod['codigo_unico'])
					update_items(prod['cantidad_items'])
	
					update_stock_p(prod['cantidad_items'])					
				end
				render json: SellSerializer.new(@sell, {fields: {sell: [:fecha_venta, :razon_social_cliente, :monto_total_venta]}})					
			else
				# Si no son correctos se destruye y se renderiza el error
				@sell.destroy
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
		i = (Item.where(estado:"disponible", product_id: @producto.id).limit(items_quantity)).update(estado: "vendido", valor_venta: @producto.monto, sell_id: @sell.id)

	end

	def update_stock_p(items_quantity)
		@producto.update(cantidad_stock: @producto.cantidad_stock - items_quantity)
	end


  private

  def authenticate_user
    @u = User.find_by(token: request.headers['Authorization'] )
    if @u.blank?
      render :status => 401
    elsif not (@u.token_created_at + 30.minutes > Time.now)
      @u.update(token: nil, token_created_at: nil)
      render :status => 401
    end
  end

end
