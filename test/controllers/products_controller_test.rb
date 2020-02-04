require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest

	test "it is ok if a 'scarce' parameter is passed" do
		get "http://localhost:3000/productos", 
			params: { q: "scarce" }
		assert_response 200
	end

	test "it is ok if a 'all' parameter is passed" do
		get "http://localhost:3000/productos", 
			params: { q: "all" }
		assert_response 200
	end

	test "it is ok if no parameter is passed" do
		get "http://localhost:3000/productos",
			params: { }
		assert_response 200
	end

	test "it is failed if a wrong paramater is passed" do
		get "http://localhost:3000/productos",
			params: { q: "anything" }
		assert_response 400
	end

	# GET productos/:codigo
	test "it should find the product if the code is correct" do
		get "http://localhost:3000/productos/agk123456"
		assert_response 200
	end

	test "it should not find the product if the code is incorrect" do
		get "http://localhost:3000/productos/helloworld"
		assert_response 404
	end

	# GET productos/:codigo/items
	test "it should find the product if the code is correct" do 
		get "http://localhost:3000/productos/agk123456/items"
		assert_response 200
	end

	test "it should not find the product if the code is incorrect" do 
		get "http://localhost:3000/productos/helloworld/items"
		assert_response 404
	end

	# POST /productos/:codigo/items
	# Consultar en la clase del martes 4
=begin
	test "it should create the quantity of items if the code is ok" do 
		assert_difference("Item.where(product_id:1, estado:'disponible').count", +2) do 			
			post "http://localhost:3000/productos/'agk123456'/items",
				params: { items: 2 }
			end
	end	
=end


	test "it should create the quantity of items if the code is ok" do 
		assert_difference("#{products(:yerba).cantidad_stock}", +2) do 			
			post "http://localhost:3000/productos/ymt259820/items",
				params: { items: 1 }, as: :json
			end
	end


end
