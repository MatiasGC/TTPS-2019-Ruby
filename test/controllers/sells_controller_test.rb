require 'test_helper'

class SellsControllerTest < ActionDispatch::IntegrationTest
	test "return sells" do 
		get "http://localhost:3000/ventas", 
			headers: { Authorization: users(:pedro).token }
		assert_response :success
	end

	test "should return the sell if the id is correct" do 
		get "http://localhost:3000/ventas/#{sells(:one).id}", # Debería mandar el usuario que está logueado en ese momento
			headers: { Authorization: users(:pedro).token }
		assert_response :success
	end

	test "should return a 'not found' if the id is incorrect" do 
		get "http://localhost:3000/ventas/helloworld", 
			headers: { Authorization: users(:pedro).token }
		assert_response :not_found
	end
end
