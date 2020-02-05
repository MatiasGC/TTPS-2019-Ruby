require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
	test "return reservations" do 
		get "http://localhost:3000/reservas", 
			headers: { Authorization: users(:pedro).token }
		assert_response 200
	end

	test "should return the reservation if the id is correct" do 
		get "http://localhost:3000/reservas/#{reservations(:one).id}", 
			headers: { Authorization: users(:pedro).token }
		assert_response 200
	end

	test "should not return the reservation if the id is incorrect" do 
		get "http://localhost:3000/reservas/helloworld", 
			headers: { Authorization: users(:pedro).token }
		assert_response 404
	end

	# put /reservas/:id/vender
	test "should be update the reservation with a sell if the id is correct" do 
		put "http://localhost:3000/reservas/#{reservations(:three).id}/vender", 
			headers: { Authorization: users(:pedro).token }
		assert_response 201
	end

	test "should be not updated the reservation which has already a sell" do 
		put "http://localhost:3000/reservas/#{reservations(:one).id}/vender", 
			headers: { Authorization: users(:pedro).token }
		assert_response 400
	end

	#delete /reservas/:id
	test "a reservation is succefully deleted if the id is correct and it has not a sell" do 
		delete "http://localhost:3000/reservas/#{reservations(:three).id}", 
			headers: { Authorization: users(:pedro).token }
		assert_response 200
	end

	test "a reservation is not deleted if the id is incorrect" do 
		delete "http://localhost:3000/reservas/123456", 
			headers: { Authorization: users(:pedro).token }
		assert_response 404
	end

	test "a reservation can't deleted if the id is correct but it has a sell" do 
		delete "http://localhost:3000/reservas/#{reservations(:one).id}", 
			headers: { Authorization: users(:pedro).token }
		assert_response 400
	end

end
