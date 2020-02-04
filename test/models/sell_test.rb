require 'test_helper'

class SellTest < ActiveSupport::TestCase
	setup do 
		@sell = Sell.new
	end

	test "a sell is not created if it hasn't a user and a client associated" do 
		@sell.fecha_venta = DateTime.new(2001,2,3)
		assert_not @sell.save
	end

	test "a sell is created if it has a client and a user associated" do  
		@sell.client_id = clients(:juan).id
		@sell.user_id = users(:pedro).id
		assert @sell.save
	end

	test "a sell created should have at least one product" do 
		assert_not_nil sells(:one).items
	end
end
