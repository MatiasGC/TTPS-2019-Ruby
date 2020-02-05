require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest

	test "it is ok if a 'scarce' parameter is passed" do
		get "http://localhost:3000/productos", 
			params: { q: "scarce" }, headers: { Authorization: users(:pedro).token }
		assert_response 200
	end

	test "it is ok if an 'all' parameter is passed" do
		get "http://localhost:3000/productos", 
			params: { q: "all" }, headers: { Authorization: users(:pedro).token }
		assert_response 200
	end

	test "it is ok if no parameter is passed" do
		get "http://localhost:3000/productos",
			params: { }, headers: { Authorization: users(:pedro).token }
		assert_response 200
	end

	test "it is failed if a wrong paramater is passed" do
		get "http://localhost:3000/productos",
			params: { q: "anything" }, headers: { Authorization: users(:pedro).token }
		assert_response 400
	end

	# GET productos/:codigo
	test "it should find the product if the code is correct" do
		get "http://localhost:3000/productos/agk123456", 
			headers: { Authorization: users(:pedro).token }
		assert_response 200
	end

	test "it should not find the product if the code is incorrect" do
		get "http://localhost:3000/productos/helloworld", 
			headers: { Authorization: users(:pedro).token }
		assert_response 404
	end

	# GET productos/:codigo/items
	test "it should find the product if the code is correct" do 
		get "http://localhost:3000/productos/agk123456/items", 
			headers: { Authorization: users(:pedro).token }
		assert_response 200
	end

	test "it should not find the product if the code is incorrect" do 
		get "http://localhost:3000/productos/helloworld/items",
			headers: { Authorization: users(:pedro).token }
		assert_response 404
	end
end
