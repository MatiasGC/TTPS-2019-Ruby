require 'test_helper'

class ItemTest < ActiveSupport::TestCase
	setup do 
		@item = Item.new
	end

	test "each item belongs to a product" do 
		assert_not_nil items(:one).product
	end

	test "item is not created if it hasn't a product associated" do 
		@item.estado = "disponible"
		@item.valor_venta = 10
		assert_not @item.save
	end

	test "item should be registered as a reserved item if was reserved by a client" do 
		assert_not_nil items(:four).reservation
	end

	test "item should be registered as a sold item if it was bought by a client" do 
		assert_not_nil items(:five).sell
	end
end
