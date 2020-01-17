require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
	setup do 
		@reservation = Reservation.new
	end

	test "a reservation is not created if it hasn't a user and a client associated" do  
		@reservation.fecha_reserva = DateTime.new(2001,2,3)
		assert_not @reservation.save
	end

	test "a reservation should has a client and a user associated" do  
		assert reservations(:one).valid?
	end

end
