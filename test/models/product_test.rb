require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	setup do
		@product = Product.new
	end

	test "Product is not created without a description" do 
		@product.codigo_unico = "agk123456"
		@product.detalle = "Agua 100 por ciento natural. Botella plástica no retornable"
		@product.monto = 20
		@product.cantidad_stock = 4
		assert_not @product.save
	end

	test "Product is created with all fields correctly completed" do 
		@product.codigo_unico = "vws259820"
		@product.descripcion = "Agua Kin 500cc"
		@product.detalle = "Agua 100 por ciento natural. Botella plástica no retornable"
		@product.monto = 20
		@product.cantidad_stock = 4
		assert @product.save
	end 

	test 'product is not created if it is updated with a wrong unique code' do 
		@product.codigo_unico = "agk123456"
		@product.detalle = "Agua 100 por ciento natural. Botella plástica no retornable"
		@product.monto = 20
		@product.cantidad_stock = 4
		@product.save
		@product.update(codigo_unico: "pepe")
		assert_not @product.save
	end

	test "Product is not created if the description has more than 200 characters" do
		@product.codigo_unico = "vws259820"
		@product.descripcion = "holaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholaholahola"
		@product.detalle = "Agua 100 por ciento natural. Botella plástica no retornable"
		@product.monto = 20
		@product.cantidad_stock = 4
		refute @product.save
		#assert_equal("is too long (maximum is 200 characters)", @product.save)
	end

end
