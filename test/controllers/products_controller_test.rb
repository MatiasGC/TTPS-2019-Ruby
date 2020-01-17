require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
	setup do 
		@product = Product.create(codigo_unico: "mml174391", descripcion:"Mermelada Arcor Durazno light 390g", detalle: "Mermelada de durazno reducida 47 por ciento en calorías, libre de gluten", monto: 100, cantidad_stock: 1)
	end

end
