require 'test_helper'

class ItemTest < ActiveSupport::TestCase
	setup do 
		@item = Item.new
	end

	test 'item is created if it has the correct data' do 
		@item.estado = "disponible"
		@item.valor_venta = 0
		@item.product_id = products(:agua).id
		assert @item.save
	end

	test 'raise an ArgumentError if estado has an incorrect option' do 
		assert_raises(ArgumentError) { @item.estado = 'cualquier cosa' }
	end

	test 'an item has to belong to a product' do 
		assert_not_nil items(:one).product
		assert_not_nil items(:two).product
	end

	test "item is not created if it hasn't a product associated" do 
		@item.estado = "disponible"
		@item.valor_venta = 10
		assert_not @item.save
	end

	test "item should be registered as a reserved item if it was reserved" do 
		assert_not_nil items(:four).reservation
	end

	test "item should be registered as a sold item if it was bought by a client" do 
		assert_not_nil items(:five).sell
	end
end
