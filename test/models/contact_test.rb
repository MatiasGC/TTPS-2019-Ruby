require 'test_helper'

class ContactTest < ActiveSupport::TestCase
	setup do 
		@contact = Contact.new
	end

	test "a contact is created if it has a client associated" do 
		@contact.telefono = 123456
		@contact.client_id = clients(:juan).id
		assert @contact.save
	end

	test "a contact is not created if it not has a client associated" do 
		@contact.telefono = 123456
		assert_not @contact.save
	end

end
