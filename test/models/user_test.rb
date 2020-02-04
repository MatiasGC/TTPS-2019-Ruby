require 'test_helper'
require 'minitest/autorun'

class UserTest < ActiveSupport::TestCase
	setup do
		@user = User.new
		@user2 = User.new
	end

	test "a user should be succesfully saved if data are ok" do 
		@user.username = "juan"
		@user.password = "123456"
		assert @user.save
	end

	test "a user shouldn't be saved if the username is missing" do 
		@user.password = "123456"
		assert_not @user.save
	end

	test "a user shouldn't be saved if the password is missing" do 
		@user.username = "juan"
		assert_not @user.save
	end

	test "a user shouldn't be saved if already exist another user with the same username" do 
		@user.username = 'juan'
		@user.save
		@user2.username = 'juan'
		assert_not @user2.save
	end
end
