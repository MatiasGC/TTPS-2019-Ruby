require 'test_helper'

class SellsControllerTest < ActionDispatch::IntegrationTest
	test "return sells" do 
		get "http://localhost:3000/ventas"
		assert_response 200
	end

	test "should return the sell if the id is correct" do 
		get "http://localhost:3000/ventas/#{sell(:one).id}"
		assert_response 200
	end

	test "should not return the sell if the id is incorrect" do 
		get "http://localhost:3000/ventas/helloworld"
		assert_response 404
	end
end
