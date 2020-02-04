class SellsController < ApplicationController
	before_action :authenticate_user

	# GET /ventas
	def index
		@sells = Sell.all

		render json: SellSerializer.new(@sells, { fields: { sell: [ :fecha_venta, :razon_social_cliente, :monto_total_venta ] } })

	end

	# GET /ventas/:id
	def show
		@sell = Sell.find_by(id: params[:id])
		if @sell && @sell.user.username == "matiasgc" #aquí hay que reemplazar por usuario logueado en el momento
			options = {}
			sth_include = params[:include]
			if sth_include
				options[:include] = [sth_include]
				render json: SellSerializer.new(@sell, options)
			else
				render json: SellSerializer.new(@sell, { fields: { sell: [ :fecha_venta, :razon_social_cliente, :monto_total_venta ] } })			
			end
			
		end
	end

	# POST /ventas
	def create
		
	end


  private

  def authenticate_user

      authenticate_or_request_with_http_token do |token, options|
        u = User.find_by(token: token)
        if not u.nil?
          (u.token_created_at + 30.minutes > Time.now)   
        end
      end
 
  end

end
