require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

	test "a user is not created if it has not a username" do 
		post "http://localhost:3000/usuarios",
			params: { password: "123456" }, as: :json
		assert_response 400
	end

	test "a user is not created if the username field is blank" do 
		post "http://localhost:3000/usuarios",
			params: { username: "", password: "123456" }, as: :json
		assert_response 400
	end

	test "a user is not created if the username already exists" do 
		post "http://localhost:3000/usuarios",
			params: { username: "diego1", password: "123456" }, as: :json
		assert_response 400
	end


end
