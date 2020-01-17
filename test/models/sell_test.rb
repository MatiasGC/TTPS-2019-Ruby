require 'test_helper'

class SellTest < ActiveSupport::TestCase
	setup do 
		@sell = Sell.new
	end

	test "a sell is not created if it hasn't a user and a client associated" do 
		@sell.fecha_venta = DateTime.new(2001,2,3)
		assert_not @sell.save
	end

	test "a sell should has a client and a user associated" do  
		assert sells(:one).valid?
	end
end
