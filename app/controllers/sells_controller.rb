class SellsController < ApplicationController

	# GET /ventas
	def index
		@sells = Sell.all

		render json: SellSerializer.new(@sells, { fields: { sell: [ :fecha_venta, :razon_social_cliente, :monto_total_venta ] } })

	end

end
