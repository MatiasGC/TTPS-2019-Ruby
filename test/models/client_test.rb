require 'test_helper'

class ClientTest < ActiveSupport::TestCase
	setup do 
		@client = Client.new
	end

	test "A client should be succesfully created if all field are correct" do 
		@client.cuil_o_cuit = "20219853456"
		@client.razon_social = "Jose Gomez"
		@client.condicion_iva = 5
		@client.email = "jose@gmail.com"
		@client.contacts.new(telefono: "2214567890")
		assert_equal(true, @client.save)
	end

	test "A client shouldn't be succesfully created if the email is wrong" do
		@client.cuil_o_cuit = "20219853456"
		@client.razon_social = "Juan Gómez"
		@client.condicion_iva = 5
		@client.email = "juancito"
		@client.contacts.new(telefono: "2214567890")
		assert_not @client.valid?
	end

	test "raise an ArgumentError if condicion_iva has a number out of range" do 
		@client.cuil_o_cuit = "20219853456"
		@client.razon_social = "Diego García"
		assert_raises(ArgumentError) { @client.condicion_iva = 900 }
	end

	test "A client shouldn't be succesfully created if has not a contact" do 
		@client.cuil_o_cuit = "20219853456"
		@client.razon_social = "Jose Gomez"
		@client.condicion_iva = 5
		@client.email = "jose@gmail.com"
		assert_not @client.valid?
	end

	test "A client shouldn't be succesfully created if it has not a cuil_o_cuit" do
		@client.razon_social = "Juan Gómez"
		@client.condicion_iva = 5
		@client.email = "email@gmail.com"
		@client.contacts.new(telefono: "2214567890")
		assert_equal(false, @client.save)
	end

end
