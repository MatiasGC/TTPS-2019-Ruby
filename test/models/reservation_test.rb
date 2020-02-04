require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
	setup do 
		@reservation = Reservation.new
	end

	test "a reservation is not created if it hasn't a user and a client associated" do  
		@reservation.fecha_reserva = DateTime.new(2001,2,3)
		assert_not @reservation.save
	end

	test "a reservation is created if it has a client and a user associated" do  
		@reservation.client_id = clients(:juan).id
		@reservation.user_id = users(:pedro).id
		assert @reservation.save
	end

	test "a reservation created should have at least one product" do 
		assert_not_nil reservations(:one).items
	end


end
