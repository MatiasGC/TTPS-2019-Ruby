require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
	test "authorized user" do
		post "http://localhost:3000/sesiones",
			params: { u: users(:pedro).username, p: users(:pedro).password }

		assert_response :success
			
	end

	test "unauthorized user" do
		post "http://localhost:3000/sesiones",
			params: { u: "helloworld", p: "zzz_k" }

		assert_response :not_found
			
	end
end
